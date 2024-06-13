#! /vendor/bin/sh
LOG_HEAD="[time-services]"

current_time=$(date +%s)
echo "${LOG_HEAD} current time : ${current_time}" > /dev/kmsg

# if time-service initialization is required
if [ "$1" != "1" ]; then
    #FIXME : date cmd could return 0 without broadcasting SET_TIME intent, the time diff b/w old & new must be enough
    new_time=$((current_time+5))
    date -s @${new_time}
    ret=$?
    # echo "${LOG_HEAD} date return code : ${ret} " > /dev/kmsg
    if [ "$ret" -ne 0 ]; then
        echo "${LOG_HEAD} failed to exec date cmd : ${current_time} to ${new_time} with ${ret}" > /dev/kmsg
        echo c > /proc/sysrq-trigger #it's not working due to selinux
        exit 1
    else
        echo "${LOG_HEAD} initialized : ${current_time} to ${new_time}" > /dev/kmsg
    fi

    setprop persist.vendor.time_services.init 1
fi
