function Disconnect-TrueNasServer
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    ()

    Begin
    {
    }
    Process
    {
        if($Script:TrueNASSession -or $Script:TrueNASServer -or $Script:TrueNASSpecs) {
            Write-Host "Disconnecting from TrueNAS Server" -ForegroundColor Green

            $Script:TrueNASSession = $NULL
            $Script:TrueNASServer  = $NULL
            $Script:TrueNASSpecs   = $NULL
            Return
        }

    }
    End
    {

    }
}
