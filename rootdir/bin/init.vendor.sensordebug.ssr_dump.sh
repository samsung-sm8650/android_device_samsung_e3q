#!/vendor/bin/sh
# Copyright (c) 2020 The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# Function to start sensors for SSC enabled platforms
#
echo "Sensor SSR Dump"
param=$1
echo "param: $param"
index=0
adsp_path="none"
adsp_str="adsp"

if [[ "$param" == "start" || "$param" == "stop" ]]; then
	COUNT_CMD='ls -l /sys/class/remoteproc | grep ^l | wc -l'
	count=$(eval $COUNT_CMD)
	echo "count: $count"
	for file in /sys/class/remoteproc/*
	do
		local_path=$file"/name"
		echo "$local_path:$local_path"
		name=$(eval cat $local_path)
		echo "name:$name"
		if [[ "$name" == *"$adsp_str"* ]]; then
			echo "found~!! index: $index"
			adsp_path=$file
			break
		fi
		((index++))
	done

	if [ "$param" == "start" ]; then
		echo "start"
		if [ "$adsp_path" != "none" ]; then
			echo "adsp_path:$adsp_path"
			SSR_DUMP_CMD=""
			ENABLE_RAMDUMPS_CMD='getprop persist.vendor.ssr.enable_ramdumps'
			enable_ramdumps=$(eval $ENABLE_RAMDUMPS_CMD)
			echo "enable_ramdumps:$enable_ramdumps"
			if [ "$enable_ramdumps" == "0" ]; then
				SSR_DUMP_CMD+="setprop persist.vendor.ssr.enable_ramdumps 1 &"
			fi
			
			RESTART_LEVEL_CMD='getprop persist.vendor.ssr.restart_level'		
			restart_level=$(eval $RESTART_LEVEL_CMD)
			echo "restart_level:$restart_level"
			if [ "$restart_level" == "ALL_ENABLE" ]; then
				set_val="$restart_level"
			elif [ "$restart_level" == "ALL_DISABLE" ]; then
				set_val="adsp"
			elif [ -n "$restart_level" ];then
				if [[ "$restart_level" == *adsp* ]]; then
					set_val="$restart_level"
				else
					set_val="$restart_level adsp"
				fi
			else
				set_val="adsp"
			fi

			SSR_DUMP_CMD+="echo enabled > $adsp_path/recovery &"
			SSR_DUMP_CMD+="echo enabled > $adsp_path/coredump &"
			SSR_DUMP_CMD+="setprop persist.vendor.ssr.restart_level '$set_val'"
			echo "SSR_DUMP_CMD:$SSR_DUMP_CMD"
			eval $SSR_DUMP_CMD
		fi
	fi

	if [ "$param" == "stop" ]; then
		echo "stop"
		if [ "$adsp_path" != "none" ]; then
			echo "adsp_path:$adsp_path"
			SSR_DUMP_CMD="setprop persist.vendor.ssr.enable_ramdumps 0 &"
			SSR_DUMP_CMD+="echo 0 > /sys/module/qcom_ramdump/parameters/enable_dump_collection &"
			SSR_DUMP_CMD+="echo disabled > $adsp_path/recovery &"
			SSR_DUMP_CMD+="echo disabled > $adsp_path/coredump &"
			SSR_DUMP_CMD+="setprop persist.vendor.ssr.restart_level ALL_DISABLE"
			eval $SSR_DUMP_CMD
		fi
	fi
fi

if [ "$param" == "complete" ]; then
	chown root:system /data/vendor/ramdump/remoteproc-adsp.elf
	INTENT_CMD="am broadcast -a com.sec.android.ISSUE_TRACKER_ACTION "
	INTENT_CMD+="--ei ERRCODE -126 "
	INTENT_CMD+="--es ERRNAME \"Sensor Silent dump\" "
	INTENT_CMD+="--es ERRPKG \"Sensor ADSP\" "
	INTENT_CMD+="--es ERRMSG \"Sensor SSR Dump after SSR\" "
	INTENT_CMD+="--es EXTLOG \"/data/vendor/ramdump/remoteproc-adsp.elf\""
	echo "$INTENT_CMD" && eval "$INTENT_CMD" 
fi
