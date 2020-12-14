function Get-TrueNasCertificateById
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id,
        [Parameter (Mandatory = $false)]
        [switch]$ExportCert,
        [Parameter (Mandatory = $false)]
        [switch]$PrivateKey

    )

    Begin
    {
        $uri = "api/v2.0/certificate/id/$Id"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Certificate = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.name)"
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
        $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result.certificate)"
        $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result.privatekey)"
        $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result.CSR)"
        $temp | Add-Member -MemberType NoteProperty -Name "Signedby" -Value "$($result.signedby)"
        $temp | Add-Member -MemberType NoteProperty -Name "RootPath" -Value "$($result.root_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "CertificatePath" -Value "$($result.certificate_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "PrivateKeyPath" -Value "$($result.private_key_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "CSRPath" -Value "$($result.csr_path)"
        $temp | Add-Member -MemberType NoteProperty -Name "CertType" -Value "$($result.cert_type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result.issuer)"
        $temp | Add-Member -MemberType NoteProperty -Name "ChainList" -Value "$($result.chain_list)"
        $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result.country)"
        $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.state)"
        $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result.city)"
        $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result.organization)"
        $temp | Add-Member -MemberType NoteProperty -Name "OrganizationalUnit" -Value "$($result.organization_unit)"
        $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result.Common)"
        $temp | Add-Member -MemberType NoteProperty -Name "SAN" -Value "$($result.San)"
        $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result.email)"
        $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result.DN)"
        $temp | Add-Member -MemberType NoteProperty -Name "DigestAlgorithm" -Value "$($result.digest_algorithm)"
        $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result.lifetime)"
        $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result.from)"
        $temp | Add-Member -MemberType NoteProperty -Name "Until" -Value "$($result.until)"
        $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result.serial)"
        $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result.chain)"
        $temp | Add-Member -MemberType NoteProperty -Name "Fingerprint" -Value "$($result.fingerprint)"
        $temp | Add-Member -MemberType NoteProperty -Name "KeyLength" -Value "$($result.key_length)"
        $temp | Add-Member -MemberType NoteProperty -Name "KeyType" -Value "$($result.key_type)"
        $temp | Add-Member -MemberType NoteProperty -Name "Parsed" -Value "$($result.parsed)"
        $temp | Add-Member -MemberType NoteProperty -Name "Internal" -Value "$($result.internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CATypeExisting" -Value "$($result.CA_type_existing)"
        $temp | Add-Member -MemberType NoteProperty -Name "CATypeInternal" -Value "$($result.CA_type_internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CATypeIntermediate" -Value "$($result.CA_type_intermediate)"
        $temp | Add-Member -MemberType NoteProperty -Name "CertTypeExisting" -Value "$($result.cert_type_existing)"
        $temp | Add-Member -MemberType NoteProperty -Name "CertTypeInternal" -Value "$($result.cert_type_internal)"
        $temp | Add-Member -MemberType NoteProperty -Name "CertTypeCSR" -Value "$($result.cert_type_CSR)"
        $Certificate.Add($temp) | Out-Null

    }
    End
    {
        if ( $PsBoundParameters.ContainsKey('ExportCert') )
        {
            Write-Verbose "We are trying to export the Cerificate file  $($result.name).crt"
            $crtFile = $($result.certificate)
            $crtFile | Out-File -FilePath "$($result.name).crt"
            Write-Output "The certificate is exported to $($result.name).crt"

        }
        if ( $PsBoundParameters.ContainsKey('PrivateKey') )
        {
            Write-Verbose "We are trying to export the private Key   $($result.name).key"
            $KeyFile = $($result.privatekey)
            $KeyFile | Out-File -FilePath "$($result.name).key"
            Write-Output "The private is exported to $($result.name).key"
        }
        return $Certificate
    }
}
