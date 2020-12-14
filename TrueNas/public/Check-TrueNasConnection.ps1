function Check-TrueNasConnection
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v2.0/system/general"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        if($($result.ui_address)) {
            Return $true
        } else {
            Return $false
        }
    }
}
