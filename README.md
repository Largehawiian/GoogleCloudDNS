### GoogleCloudDNS
Powershell functions for interacting with the Google Cloud SDK relating to DNS records
This module requires the Google Cloud SDK to be installed and configured.  See https://cloud.google.com/sdk/docs/quickstarts for more information.

#### Installation
```powershell
    Install-Module GoogleCloudDNS
    Import-Module GoogleCloudDNS
```
#### Get exiting records
```powershell
    Get-GoogleCloudParams -Domain "YourDomain.com" | Get-GoogleCloudDNSRecord -Type A
    Get-GoogleCloudParams -Domain "YourDomain.com" | Get-GoogleCloudDNSRecord -Type MX
    Get-GoogleCloudParams -Domain "YourDomain.com" | Get-GoogleCloudDNSRecord -Type TXT
    Get-GoogleCloudParams -Domain "YourDomain.com" | Get-GoogleCloudDNSRecord -Type CNAME
    Get-GoogleCloudParams -Domain "YourDomain.com" | Get-GoogleCloudDNSRecord -Type NS
```
#### Add new records
```powershell
    Get-GoogleCloudParams -Domain "YourDomain.com" | New-GoogleCloudDNSRecord -RecordType "A" -HostName "www" -Value "169.254.2.3"
```
#### Remove records
```powershell
    Get-GoogleCloudParams -Domain "YourDomain.com" | Remove-GoogleCloudDNSRecord -RecordType "A" -Hostname "www"
```