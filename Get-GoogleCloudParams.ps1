<#
    .Synopsis
        Gets parameters for other Google Cloud DNS Functions
    .Description
        Creates a variable to pass Gettings to other functions
    .Example
        C:\PS>$Google = Get-GoogleCloudParams -Domain yourdomain.com

    .Notes
        Name: Get-GoogleCloudParams
        Author: Jeremy jackson
        Last Edit: September 17 2020
        Keywords: Google DNS
    .Link

    .Inputs
        None
    .Outputs
        None

    #>
function Get-GoogleCloudParams {
    param (
        [string]$Domain
    )
    $GoogeleDNS = [PSCustomObject]@{
        Domain  = $Domain + "."
        Project = (Get-GcpProject).projectid
        Zone    = ((Get-GcdManagedZone).where{ $_.DnsName -eq $Domain + "." }).Name

    }
    return $GoogeleDNS
}
