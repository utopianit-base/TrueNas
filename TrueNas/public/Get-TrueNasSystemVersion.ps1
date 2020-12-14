function Get-TrueNasSystemVersion
{
    Param( )

    $Uri = "api/v2.0/system/info"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get


    [PSCustomObject]@{
        Version               = ($results.version)
        'BuildTime'           = ($results.buildtime)
        'PhysicalMemory'      = ($results.physmem)
        Model                 = ($results.model)
        Cores                 = ($results.cores)
        'LoadAverage'         = ($results.loadavg)
        Uptime                = ($results.uptime)
        'UptimeSeconds'       = ($results.uptime_seconds)
        'SystemSerial'        = ($results.system_serial)
        'SystemProduct'       = ($results.system_product)
        license               = ($results.license)
        'BootTime'            = ($results.boottime)
        'Datetime'            = ($results.datetime)
        TimeZone              = ($results.timezone)
        'SystemManufacturer'  = ($results.system_manufacturer)

    }

}
