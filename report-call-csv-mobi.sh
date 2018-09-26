#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

        while true
        do
                YEAR=$(date +"%Y")
        MONTH=$(date +"%m")
        DAY=$(date +"%d")
        YMD=$YEAR$MONTH$DAY

        NAME=$(hostname)

        PATCH_FILE_REPOPRT="$CURRENT_DIR/Report-Calls-$NAME-"$YMD".csv"

                START_DATE_TIME_JOB=`date "+%Y-%m-%d %H:%M:%S"`

                if [ -f $PATCH_FILE_REPOPRT ]
                        then

                                CALLS_PROCESSED=`asterisk -rx "core show channels" | grep "calls processed" | awk '{print $1}'`
                                ACTIVE_CALLS=`asterisk -rx "core show channels" | grep "active calls" | awk '{print $1}'`
                                ACTIVE_CHANNELS=`asterisk -rx "core show channels" | grep "active channels" | awk '{print $1}'`
                                ACTIVE_CALLS_LEGAL=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/29" | wc -l`
                                ACTIVE_CALLS_COLLECTION=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/27" | wc -l`
                                ACTIVE_CALLS_UNDERWRITING=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/25" | wc -l`
                                ACTIVE_CALLS_TSA_SALE=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/21" | wc -l`
                                ACTIVE_CALLS_CS_OUTBOUND=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/20" | wc -l`
                                ACTIVE_CALLS_BACKOFFICE=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/1" | wc -l`
                                ACTIVE_CALLS_TSA_SMART=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-MOBI/12" | wc -l`
                                END_DATE_TIME_JOB=`date "+%Y-%m-%d %H:%M:%S"`

                                echo "$START_DATE_TIME_JOB,$ACTIVE_CALLS,$ACTIVE_CHANNELS,$CALLS_PROCESSED,$ACTIVE_CALLS_LEGAL,$ACTIVE_CALLS_COLLECTION,$ACTIVE_CALLS_UNDERWRITING,$ACTIVE_CALLS_TSA_SALE,$ACTIVE_CALLS_CS_OUTBOUND,$ACTIVE_CALLS_BACKOFFICE,$ACTIVE_CALLS_TSA_SMART,$END_DATE_TIME_JOB" >> "$PATCH_FILE_REPOPRT"

                else
                        touch "$PATCH_FILE_REPOPRT"
                        echo "start_time,active_calls,ative_channels,calls_processed,calls_legal,calls_collection,calls_underwriting,calls_tsa_sale,calls_cs_outbound,calls_backoffice,calls_tsa_smart,end_time" > "$PATCH_FILE_REPOPRT"
                fi

                sleep 5
        done &

