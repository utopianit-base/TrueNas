function Remove-TrueNasIscsiAssociate2Extent
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v2.0/iscsi/targetextent/id/$Id"

        if ($PSCmdlet.ShouldProcess("will be removed" , "The Association to Extent with the ID $Id"))
        {
            $response = Invoke-TrueNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}

New-Alias -Name Remove-TrueNasIscsiAssociate2Extent -Value Remove-TrueNasIscsiAssociat2Extent