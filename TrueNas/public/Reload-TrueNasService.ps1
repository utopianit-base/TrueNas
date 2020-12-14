function Reload-TrueNasService
{
    Param
    (
        [Parameter (Mandatory = $true)]
        #Removed validateset below to make API more future proof for new services. Use Get-TrueNASService to list those available
        #[ValidateSet("afp", "cifs", "dynamicdns", "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "lldp", "webdav", "s3", "openvpn_client", "openvpn_server")]
        [String]$Service
    )

    Begin
    {

    }
    Process
    {
        $ValidServices = $(Get-TrueNasService | Select-Object service).service
        if($Service -inotin $ValidServices) {
            Write-Output "ERROR: Service named '$Service' is not known to this system"
            $Result = $false
        } else {
            # We have a valid service that has been enabled
            $Uri = "api/v2.0/service/reload"
            $Obj = [Ordered]@{

                service           = $Service
                'service-control' = @{
                    ha_propagate = $true
                }
            }
            $result = Invoke-TrueNasRestMethod -Method Post -body $Obj -Uri $uri
        }
    }
    End
    {
        $result
    }
}
