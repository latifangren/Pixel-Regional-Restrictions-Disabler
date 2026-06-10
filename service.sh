{
    WIFI_REGION="AU"
    TELEPHONY_SPOOF="false"
    TELEPHONY_REGION="US"
    REGION_CONF="${0%/*}/region.conf"

    if [ -f "$REGION_CONF" ]; then
        . "$REGION_CONF"
    fi

    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done

    cmd wifi force-country-code enabled "$WIFI_REGION"

    if command -v resetprop >/dev/null 2>&1; then
        resetprop ro.boot.wificountrycode "$WIFI_REGION"
        resetprop wifi.country "$WIFI_REGION"
    fi

    if [ "$TELEPHONY_SPOOF" = "true" ]; then
        LOWER_TELEPHONY_REGION=$(echo "$TELEPHONY_REGION" | tr '[:upper:]' '[:lower:]')
        setprop gsm.operator.iso-country "$LOWER_TELEPHONY_REGION,$LOWER_TELEPHONY_REGION"
        setprop gsm.sim.operator.iso-country "$LOWER_TELEPHONY_REGION,$LOWER_TELEPHONY_REGION"
    fi
}&

