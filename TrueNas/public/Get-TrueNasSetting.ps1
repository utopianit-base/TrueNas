function Get-TrueNasSetting
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
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Language" -membertype NoteProperty -Value "$($result.language)"
        $Global | add-member -name "KeyboardMap" -membertype NoteProperty -Value "$($result.kbdmap)"
        $Global | add-member -name "TimeZone" -membertype NoteProperty -Value "$($result.timezone)"
        $Global | add-member -name "SysLogLevel" -membertype NoteProperty -Value "$($result.sysloglevel)"
        $Global | add-member -name "SyslogServer" -membertype NoteProperty -Value "$($result.syslogserver)"
        $Global | add-member -name "CrashReporting" -membertype NoteProperty -Value "$($result.crash_reporting )"
        $Global | add-member -name "WizardShonw" -membertype NoteProperty -Value "$($result.wizardshown)"
        $Global | add-member -name "UsageCollection" -membertype NoteProperty -Value "$($result.usage_collection)"
        $Global | add-member -name "UICertificate" -membertype NoteProperty -Value "$($result.ui_certificate)"
        $Global | add-member -name "UIAddressIPv4" -membertype NoteProperty -Value "$($result.ui_address)"
        $Global | add-member -name "UIAddressIPv6" -membertype NoteProperty -Value "$($result.ui_v6address)"
        $Global | add-member -name "UIPort" -membertype NoteProperty -Value "$($result.ui_port)"
        $Global | add-member -name "UIHTTPSPort" -membertype NoteProperty -Value "$($result.ui_httpsport)"
        $Global | add-member -name "UIHTTPSRedirect" -membertype NoteProperty -Value "$($result.ui_httpsredirect)"
        $Global | add-member -name "isCrashReportingSet" -membertype NoteProperty -Value "$($result.crash_reporting_is_set)"
        $Global | add-member -name "isUsageCollectionSet" -membertype NoteProperty -Value "$($result.usage_collection_is_set)"

        return $Global
    }
}
