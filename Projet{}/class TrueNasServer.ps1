enum Action {
    GET
    PUT
    POST
    DELETE
}
class TrueNasServer
{
    [String] $NomCommun
    [ipaddress]$ServerAddress 
    [String]$Uri
    [String]$AuthToken
    [String]$ConnectionType

    TrueNasServer ([String]$NomCommun, [ipaddress]$ServerAddress,[String]$ConnectionType)
    {
        $This.NomCommun = $NomCommun
        $This.ServerAddress = $ServerAddress
        switch ($ConnectionType) {
            http {  $This.Uri =  "http://$ServerAddress/api/v2.0" }
            https { $This.Uri =  "https://$ServerAddress/api/v2.0"}
        }
        $This.ConnectionType = $ConnectionType
    }

    ConnectTrueNas()
    {
        $Credentials = Get-Credential -Message 'Please enter administrative credentials for your TrueNas'
        $cred = $Credentials.username + ":" + $Credentials.GetNetworkCredential().Password
        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))
       
        #headers, We need to have Content-type set to application/json...
        $Script:headers = @{ Authorization = "Basic " + $base64; "Content-type" = "application/json" }
        $invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $true }

        if ($this.GetPsEdition() -eq "Desktop"){
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }
            switch ($This.ConnectionType) {
            http  {  $This.Uri =  $This.Uri + "/system/info"}
            https {  $This.Uri =  $This.Uri + "/system/info"
                    if ($this.GetPsEdition() -eq "Desktop"){

                        Write-Verbose -Message "Core Version try to Enable TLS 1.1 and 1.2"
                        
                        $this.SetTrueNasCipherSSL()
                        
                        #By Default
                        $this.SetTrueNasUntrustedSSL()

                    }
            }            
        }


        $result = Invoke-RestMethod -Uri $This.Uri -Method Get -SessionVariable Truenas_S -headers $Script:headers @invokeParams 
        
        $Script:Session = $global:TrueNas_S
        Write-Host "Welcome on"$result.name"-"$result.version"-"$result.system_product""


    }
    SetTrueNasCipherSSL(){

        $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
        [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
    
    }
    SetTrueNasUntrustedSSL(){

    # Hack for allowing untrusted SSL certs with https connections
    Add-Type -TypeDefinition @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@

    [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName TrustAllCertsPolicy


    
    }

    TrueNasRestMethod([String]$Url, [psobject]$Body,[string]$Method){

        if([enum]::GetNames("Action").Contains($Method)){

            switch ($This.ConnectionType) {
                http  { $This.Uri =  $This.Uri + "/"+"$Url"}
                https { $This.Uri =  $This.Uri + "/"+"$Url"}
                try
                {
                    if ($body)
                    {
                       # $response = Invoke-RestMethod  $This.Uri -Method $method -body ($body | ConvertTo-Json -Compress -Depth 5) -WebSession $Script:Session -headers $Script:headers @invokeParams
                    }
                    else
                    {
                        # $response = Invoke-RestMethod  $This.Uri -Method $method -WebSession $Script:Session -headers $Script:headers @invokeParams
                    }
                }
        
                catch
                {
                    #Show-TrueNasException $_
                    throw "Unable to use TrueNAS API"
                }
        


        }else{

            Write-Warning "The Method is not recognozied or available"
        }



    }
    }
    TrueNasRestMethod([String]$Url,[string]$Method){

        if([enum]::GetNames("Action").Contains($Method)){

            switch ($This.ConnectionType) {
                http  { $This.Uri =  $This.Uri + "/"+"$Url"}
                https { $This.Uri =  $This.Uri + "/"+"$Url"}
                try
                {
                    $response = Invoke-RestMethod  $This.Uri -Method $method -WebSession $Script:Session -headers $Script:headers $Script:invokeParams
                }
        
                catch
                {
                    #Show-TrueNasException $_
                    throw "Unable to use TrueNAS API"
                }
        }else{

            Write-Warning "The Method is not recognozied or available"
        }



    }
    }
    [Bool]IsPsVersionSupported(){
        Return ($script:PSVersionTable.PSVersion.Major -ge 5)
    }
    [String]GetPsVersion(){
        return ($script:PSVersionTable).PSVersion.ToString()
    }
    [string]GetPsEdition(){
        return ($script:PSVersionTable).PsEdition.ToString()
    }

}


$Server = [TrueNasServer]::new("OneServer","192.168.68.129","https")
$Server
$Server.connectTrueNas()
