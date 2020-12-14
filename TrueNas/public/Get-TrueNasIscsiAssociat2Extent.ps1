function Get-TrueNasIscsiAssociate2Extent
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [ValidateSet("Id", "Name")]
        [string]$Output = "Id"

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/iscsi/targetextent"

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        switch ($Output)
        {
            'Id'
            {
                $TruenasIscsiAssociate2Extent = New-Object -TypeName System.Collections.ArrayList
                if ($null -eq $result.count)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSIExtentID" -Value "$($result.extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSILUNID" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSITargetID" -Value "$($result.target)"
                    $TruenasIscsiAssociate2Extent.Add($temp) | Out-Null
                }

                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSIExtentID" -Value "$($result[$i].extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSILUNID" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSITargetID" -Value "$($result[$i].target)"

                    $TruenasIscsiAssociate2Extent.Add($temp) | Out-Null
                }
            }
            'Name'
            {
                $TruenasIscsiAssociate2Extent = New-Object -TypeName System.Collections.ArrayList

                if ($null -eq $result.Count)
                {
                    $value = $result.extent
                    $value2 = $result.target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent

                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.TargetName
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.ExtentName
                        }
                    }
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "ID" -Value "$($result.Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSIExtentName" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUNId" -Value "$($result.lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "TargetName" -Value $TargetNameF

                    $TruenasIscsiAssociate2Extent.Add($temp) | Out-Null


                }


                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $value = $result[$i].extent
                    $value2 = $result[$i].target
                    $TargetName = Get-TruenasIscsiTarget
                    $IscsiExtend = Get-TruenasIscsiExtent


                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.TargetName
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.ExtentName
                        }
                    }


                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "iSCSIExtentName" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUNId" -Value "$($result[$i].lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "TargetName" -Value $TargetNameF

                    $TruenasIscsiAssociate2Extent.Add($temp) | Out-Null
                }

            }

        }

        return $TruenasIscsiAssociate2Extent
    }
    End
    { }
}
