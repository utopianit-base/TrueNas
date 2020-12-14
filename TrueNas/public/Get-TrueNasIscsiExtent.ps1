function Get-TrueNasIscsiExtent
{

    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/extent"
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        $Extent = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object

        if ($null -eq $result.Count)
        {

            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentType" -Value "$($result.type)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentName" -Value  "$($result.name)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentPath" -Value  "$($result.path)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentBlockSize" -Value  "$($result.blocksize)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentSpeedType" -Value "$($result.rpm)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentNaa" -Value "$($result.naa)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentEnabled" -Value "$($result.enabled)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentDisk" -Value "$($result.disk)"
            $temp | Add-Member -MemberType NoteProperty -Name "ExtentXen" -Value "$($result.xen)"

            $Extent.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentType" -Value "$($result[$i].type)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentName" -Value  "$($result[$i].name)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentPath" -Value  "$($result[$i].path)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentBlockSize" -Value  "$($result[$i].blocksize)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentSpeedType" -Value "$($result[$i].rpm)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentNaa" -Value "$($result[$i].naa)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentEnabled" -Value "$($result[$i].enabled)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentDisk" -Value "$($result[$i].disk)"
                $temp | Add-Member -MemberType NoteProperty -Name "ExtentXen" -Value "$($result[$i].xen)"
                $Extent.Add($temp) | Out-Null
            }

        }

        return $Extent


    }
    End
    { }
}
