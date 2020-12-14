function Get-TrueNasSystemNTP
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/system/ntpserver"

        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        foreach ($NTP in $results)
        {
            [PSCustomObject]@{
                Id      = ($NTP.id)
                Address = ($NTP.address)
                Burst   = ($NTP.burst)
                IBurst  = ($NTP.iburst)
                Prefer  = ($NTP.prefer)
                MinPoll = ($NTP.minpoll)
                MaxPoll = ($NTP.maxpoll)
            }
        }

    }
    End { }
}
