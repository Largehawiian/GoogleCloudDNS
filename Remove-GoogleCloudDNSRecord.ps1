<#
    .Synopsis
        Removes an existing Google Cloud DNS entry
    .Description
        Removes an existing Google Cloud DNS entry
    .Example
        C:\PS>Remove-GoogleCLoudDNSRecord -RecordType A -Hostname webserver.youdomain.com -GoogleCloudParams $Google

        The -GoogleCloudParams variable is populated by Set-GoogleCloudParams function
    .Notes
        Name: Remove-GoogleCloudDNSRecord
        Author: Jeremy Jackson
        Last Edit: September 17, 2020
        Keywords: Google Cloud DNS
#>
function Remove-GoogleCloudDNSRecord {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][ValidateSet('A', 'CNAME', 'MX', 'TXT')][string]$RecordType,
        [Parameter(Mandatory = $True)][string]$Hostname,
        [Parameter(Mandatory = $true,ValueFromPipeline)][array]$GoogleCloudParams
    )
    switch ($RecordType) {
        A       { $Type = "A" }
        CNAME   { $Type = "CNAME"}
        MX      { $Type = "MX"}
        TXT     { $Type = "TXT"}

    }
    $Recordset = (Get-GcdResourceRecordSet -Project $GoogleCloudParams.project -Zone $GoogleCloudParams.zone).where{ $_.type -match $Type -and $_.name -match $Hostname }
    $Recordset
    try {
        Write-Host "Confirm Removal of this record. Y/N" -ForegroundColor Green
    $Confirm = Read-host
    if ($Confirm -match "y" -or "yes") {
        Add-GcdChange -Project $GoogleCloudParams.project -zone $GoogleCloudParams.zone -Remove $Recordset
    }
    else {
        if ($Confirm -match "n" -or "no") {
            Write-host -ForegroundColor Red "Action Canceled at user request."
        }
    }
    }
    catch {
        write-host -ForegroundColor red "No Valid input was received. No changes have been processed."
    }

}