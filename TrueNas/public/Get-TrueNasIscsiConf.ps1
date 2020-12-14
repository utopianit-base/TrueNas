function Get-TrueNasIscsiConf
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/global"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $IscsiConf = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "BaseName" -Value $result.basename
        $temp | Add-Member -MemberType NoteProperty -Name "ISNSServer" -Value $result.isns_servers
        $temp | Add-Member -MemberType NoteProperty -Name "PoolAvailableSpaceThresholdPercent" -Value $result.pool_avail_threshold
        $temp | Add-Member -MemberType NoteProperty -Name "ALUA" -Value $result.alua


        $IscsiConf.Add($temp) | Out-Null

        return $IscsiConf | fl
    }
}
