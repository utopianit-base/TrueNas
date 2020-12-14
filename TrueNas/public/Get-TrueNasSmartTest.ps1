function Get-TrueNasSmartTest
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
    )
    Begin
    {
        $Uri = "api/v2.0/smart/test/results"
    }
    Process
    {
        #"http://192.168.1.123/api/v2.0/smart/test?limit=&offset=&count=&sort="
        
        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        
        $results
    }
    End
    {
    }
}
