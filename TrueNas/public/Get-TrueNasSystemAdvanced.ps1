function Get-TrueNasSystemAdvanced
{
    Param( )

    $Uri = "api/v2.0/system/advanced"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results)
    {
        [PSCustomObject]@{
            Id               = ($Info.id)
            'LegacyUI'       = ($Info.legacy_ui)
            ConsoleMenu      = ($Info.consolemenu)
            'SerialConsole' = ($Info.serialconsole)
            'SerialPort'    = ($Info.serialport)
            'SerialSpeed'   = ($Info.serialspeed)
            'PowerDaemon'   = ($Info.powerdaemon)
            'SwapOnDrive'  = ($Info.swapondrive)
            'ConsoleMsg'    = ($Info.consolemsg)
            'Traceback'     = ($Info.traceback)
            'AdvancedMode'  = ($Info.advancedmode)
            'Autotune'       = ($Info.autotune)
            'DebugKernel'   = ($Info.debugkernel)
            'UploadCrash'   = ($Info.uploadcrash)
            'MOTD'           = ($Info.motd)
            'Anonstats'      = ($Info.anonstats)
            'BootScrub'     = ($Info.boot_scrub)
            'FQDNSyslog'    = ($Info.fqdn_syslog)
            'SEDUser'       = ($Info.sed_user)
            'SEDPassword'   = ($Info.sed_passwd)

        }
    }
}
