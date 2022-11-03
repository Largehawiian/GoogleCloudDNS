<#
.SYNOPSIS
    Returns DNS records from Google Cloud DNS
.DESCRIPTION
    Returns DNS records from Google Cloud DNS
.NOTES
    Requires Google Cloud SDK https://cloud.google.com/tools/powershell/docs/quickstart
.LINK
    https://cloud.google.com/tools/powershell/docs/quickstart
.EXAMPLE
    Returns The specified record type.
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord -RecordType A
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord -RecordType CNAME
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord -RecordType MX
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord -RecordType TXT
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord -RecordType NS
.EXAMPLE
    Returns All Records
    Get-GoogleCloudParams -Domain yourdomain.com | Get-GoogleCloudDNSRecord
#>
function Get-GoogleCloudDNSRecord {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline)][array]$GoogleCloudParams,
        [ValidateSet('A', 'CNAME', 'MX', 'TXT', 'NS')][String]$Type
    )
    $Results = Get-GcdResourceRecordSet $GoogleCloudParams.Zone

    if ($type) {
        $ResultsIndex = $Results | Group-Object -AsHashTable -AsString -Property type
        switch ($type) {
            "A" { return $ResultsIndex["A"] }
            "CNAME" { return $ResultsIndex["CNAME"] }
            "MX" { return $ResultsIndex["MX"] }
            "TXT" { return $ResultsIndex["TXT"] }
            "NS" { return $ResultsIndex["NS"] }
        }

    }
    else {
        return $Results
    }
}