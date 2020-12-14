function Get-TrueNasIscsiTarget
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/target"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
        $TruenasIscsiTarget = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.Count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "TargetAlias" -Value "$($result.alias)"
            $temp | Add-Member -MemberType NoteProperty -Name "TargetName" -Value "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "TargetMode" -Value "$($result.mode)"
            $temp | Add-Member -MemberType NoteProperty -Name "GroupsPortal" -Value "$($result.groups.portal)"
            $temp | Add-Member -MemberType NoteProperty -Name "GroupsInitiator" -Value "$($result.groups.initiator)"
            $temp | Add-Member -MemberType NoteProperty -Name "GroupsAuth" -Value "$($result.groups.auth)"
            $temp | Add-Member -MemberType NoteProperty -Name "GroupsAuthMethod" -Value "$($result.groups.authmethod)"
            $TruenasIscsiTarget.Add($temp) | Out-Null
        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "TargetAlias" -Value "$($result[$i].alias)"
                $temp | Add-Member -MemberType NoteProperty -Name "TargetName" -Value "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "TargetMode" -Value "$($result[$i].mode)"
                $temp | Add-Member -MemberType NoteProperty -Name "GroupsPortal" -Value "$($result[$i].groups.portal)"
                $temp | Add-Member -MemberType NoteProperty -Name "GroupsInitiator" -Value "$($result[$i].groups.initiator)"
                $temp | Add-Member -MemberType NoteProperty -Name "GroupsAuth" -Value "$($result[$i].groups.auth)"
                $temp | Add-Member -MemberType NoteProperty -Name "GroupsAuthMethod" -Value "$($result[$i].groups.authmethod)"

                $TruenasIscsiTarget.Add($temp) | Out-Null
            }
        }

        return $TruenasIscsiTarget
    }
    End
    { }
}
