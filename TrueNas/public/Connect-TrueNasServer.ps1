function Connect-TrueNasServer
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Description of TrueNAS Server
        [Parameter(Mandatory = $true)]
        [Alias("TrueNAS")]
        $Server,
        [Parameter(Mandatory = $false)]
        [String]$Username,
        [Parameter(Mandatory = $false)]
        [SecureString]$Password,
        [Parameter(Mandatory = $false)]
        [PSCredential]$Credentials,
        [Parameter(Mandatory = $false)]
        [switch]$httpOnly = $false,
        [Parameter(Mandatory = $false)]
        [switch]$SkipCertificateCheck = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Force = $false,                # Force reconnection even if existing session is found (Default = NO/$False)
        [Parameter(Mandatory = $false)]
        [ValidateRange(1, 65535)]
        [int]$port
    )

    Begin
    {
    }
    Process
    {
        if($Script:TrueNASSession -and $Script:TrueNASServer -and $Script:TrueNASSpecs -and -not $Force) {
            $result = $Script:TrueNASSpecs
            Write-Host "Already connected to $($result.hostname) - $($result.version)" -ForegroundColor Green
            Write-Host " - Hardware : " -NoNewLine -ForegroundColor Cyan
            Write-Host "$($result.system_manufacturer) $($result.system_product)" -ForegroundColor Gray
            Write-Host " - Uptime   : " -NoNewLine -ForegroundColor Cyan
            Write-Host "$($result.uptime)" -ForegroundColor Gray
            Write-Host " - CPU      : " -NoNewLine -ForegroundColor Cyan
            Write-Host "$($result.model) ($($result.cores) cores)" -ForegroundColor Gray
            Write-Host " - Memory   : " -NoNewLine -ForegroundColor Cyan
            Write-Host "$([math]::Ceiling([long]$result.physmem/1024/1024/1024)) GB" -ForegroundColor Gray
            Return
        }

        $Script:TrueNASServer = $Server

        #If there is a password (and a user), create a credentials
        if ($Password)
        {
            $Credentials = New-Object -TypeName System.Management.Automation.PSCredential($Username, $securecurepassword)
        }

        #Not Credentials (and no password)
        if ($NULL -eq $Credentials)
        {
            $Credentials = Get-Credential -Message 'Please enter administrative credentials for your TrueNas'
        }
        $cred = $Credentials.username + ":" + $Credentials.GetNetworkCredential().Password
        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))
        #headers, We need to have Content-type set to application/json...
        $script:headers = @{ Authorization = "Basic " + $base64; "Content-type" = "application/json" }
        $script:invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $SkipCertificateCheck }

        if ("Desktop" -eq $PSVersionTable.PsEdition)
        {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }

        if ($httpOnly)
        {
            if (!$port)
            {
                $port = 80
            }

            $uri = "http://${Server}:${port}/api/v2.0/system/info"

        }
        else
        {
            if (!$port)
            {
                $port = 443
            }
            #for PowerShell (<=) 5 (Desktop), Enable TLS 1.1, 1.2 and Disable SSL chain trust
            if ("Desktop" -eq $PSVersionTable.PsEdition)
            {
                Write-Verbose -Message "Desktop Version try to Enable TLS 1.1 and 1.2"
                #Enable TLS 1.1 and 1.2
                Set-TrueNasCipherSSL
                if ($SkipCertificateCheck)
                {
                    Write-Verbose -Message "Disable SSL Chain Trust Check"

                    #Disable SSL chain trust...
                    Set-TrueNasUntrustedSSL
                }

            }
            $uri = "http://${Server}:${port}/api/v2.0/system/info"

        }

        $script:port = $port
        $script:httpOnly = $httpOnly
        $Script:ApiVersion = $ApiVersion

        try
        {
            $result = Invoke-RestMethod -Uri $uri -Method Get -SessionVariable Truenas_S -headers $headers @invokeParams
        }
        catch
        {
            Show-TrueNasException -Exception $_
            throw "Unable to connect"
        }

        if ($null -eq $result.version )
        {
            throw "Unable to get data"
        }

        Write-Host "Connected to $($result.hostname) - $($result.version)" -ForegroundColor Green
        Write-Host " - Hardware : " -NoNewLine -ForegroundColor Cyan
        Write-Host "$($result.system_manufacturer) $($result.system_product)" -ForegroundColor Gray
        Write-Host " - Uptime   : " -NoNewLine -ForegroundColor Cyan
        Write-Host "$($result.uptime)" -ForegroundColor Gray
        Write-Host " - CPU      : " -NoNewLine -ForegroundColor Cyan
        Write-Host "$($result.model) ($($result.cores) cores)" -ForegroundColor Gray
        Write-Host " - Memory   : " -NoNewLine -ForegroundColor Cyan
        Write-Host "$([math]::Ceiling([long]$result.physmem/1024/1024/1024)) GB" -ForegroundColor Gray
        
        $Script:TrueNASSpecs   = $result
        $Script:TrueNASSession = $Truenas_S

    }
    End
    {

    }
}
