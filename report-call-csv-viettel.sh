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
                                ACTIVE_CALLS_COLLECTION_PRI=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-VIETTEL/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_BK=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-VIETTEL-BK/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_GSM_1=`asterisk -rx "core show channels" | grep "Dial(SIP/TRUNK-GSM171/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_GSM_2=`asterisk -rx "core show channels" | grep "Dial(SIP/TRUNK-GSM183/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_GSM_3=`asterisk -rx "core show channels" | grep "Dial(SIP/TRUNK-GSM181/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_GSM_4=`asterisk -rx "core show channels" | grep "Dial(SIP/TRUNK-GSM165/" | wc -l`
                                ACTIVE_CALLS_COLLECTION_GSM_5=`asterisk -rx "core show channels" | grep "Dial(SIP/TRUNK-GSMCH39/" | wc -l`
                                TOTAL_ACTIVE_CALLS_COLLECTION_GSM=$(($ACTIVE_CALLS_COLLECTION_GSM_1 + $ACTIVE_CALLS_COLLECTION_GSM_2 + $ACTIVE_CALLS_COLLECTION_GSM_3 + $ACTIVE_CALLS_COLLECTION_GSM_4 + $ACTIVE_CALLS_COLLECTION_GSM_5))
                                ACTIVE_CALLS_COLLECTION_E1=`asterisk -rx "core show channels" | grep "Dial(SIP/SIP-TRUNK-137/" | wc -l`

                                END_DATE_TIME_JOB=`date "+%Y-%m-%d %H:%M:%S"`

                                echo "$START_DATE_TIME_JOB,$ACTIVE_CALLS,$ACTIVE_CHANNELS,$CALLS_PROCESSED,$ACTIVE_CALLS_COLLECTION_PRI,$ACTIVE_CALLS_COLLECTION_BK,$TOTAL_ACTIVE_CALLS_COLLECTION_GSM,$ACTIVE_CALLS_COLLECTION_E1,$END_DATE_TIME_JOB" >> "$PATCH_FILE_REPOPRT"
                else
                        touch "$PATCH_FILE_REPOPRT"

                        echo "start_time,active_calls,ative_channels,calls_processed,calls_collection_pri,calls_collection_bk,calls_collection_gsm,calls_collection_e1,end_time" > "$PATCH_FILE_REPOPRT"
                fi

                sleep 5
        done &

                       
