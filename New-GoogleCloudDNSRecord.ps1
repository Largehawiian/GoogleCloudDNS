<#
    .Synopsis
        Creates a new DNS record using Google Cloud DNS API.
    .Description
        Creates a new DNS record using Google Cloud DNS API.
    .Example
        C:\PS>New-GoogleCloudDNSRecord -RecordType A -Hostname webserver.yourdomain.com -Value 123.123.123.123 -GoogleCloudParams $Google

        The -GoogleCloudParams variable is created using Set-GoogleCloudParams function
    .Notes
        Name: New-GoogleCloudDNSRecord
        Author: Jeremy jackson
        Last Edit: September 17, 2020
        Keywords: Google Cloud DNS
    .Link
#>
function New-GoogleCloudDNSRecord {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory = $true)][ValidateSet('A', 'CNAME', 'MX', 'TXT')][string]$RecordType,
            [Parameter(Mandatory = $True)][string]$Hostname,
            [Parameter(Mandatory = $true)][string]$Value,
            [Parameter(Mandatory = $true, ValueFromPipeline)][array]$GoogleCloudParams
        )
        switch ($RecordType) {
            A       { $Type = "A" }
            CNAME   { $Type = "CNAME"; $Value = $Value + "." }
            MX      { $Type = "MX"; $Value = $Value + "." }
            TXT     { $Type = "TXT"; $Value = $Value + "." }

        }
        $RecordSet = New-GcdResourceRecordSet -Name ($Hostname + ".") -Rrdata $value -Type $Type
        Add-GcdChange -Project $GoogleCloudParams.project -zone $GoogleCloudParams.zone -add $RecordSet
    }