function Get-TrueNasInterface
{
    [CmdletBinding()]
    [Alias()]

    Param
    ()


    Begin
    {
        $uri = "api/v2.0/interface"
    }
    Process
    {

        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        for ($i = 0; $i -lt $result.Count; $i++)
        {
            foreach ($item in $result[$i])
            {
                [PSCustomObject]@{
                    id                   = ($result[$i].id)
                    Name                 = ($result[$i].name)
                    Fake                 = ($result[$i].fake)
                    Type                 = ($result[$i].type)
                    Aliases              = ($result[$i].aliases)
                    "DHCP_IPv4"          = ($result[$i].ipv4_dhcp)
                    "DHCP_IPv6"          = ($result[$i].ipv6_auto)
                    Description          = ($result[$i].description)
                    Options              = ($result[$i].options)
                    "ParentName"        = ($result[$i].state.name)
                    "OriginName"        = ($result[$i].state.description)
                    "ParentDescription" = ($result[$i].state.description)
                    MTU                  = ($result[$i].state.mtu)
                    Cloned               = ($result[$i].state.cloned)
                    Flags                = ($result[$i].state.nd6_flags)
                    "LinkState"         = ($result[$i].state.link_state)
                    "MediaType"         = ($result[$i].state.media_type)
                    "ActiveMediaType"  = ($result[$i].state.active_media_type)
                    "SupportedMedia"    = ($result[$i].state.supported_media)
                    "MediaOptions"      = ($result[$i].state.media_options)
                    "MACAddress"        = ($result[$i].state.link_address)

                }
            }
        }

    }
}
