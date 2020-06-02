  #######################################################################################
#Rename Mac
  #######################################################################################
RENAME_COMPUTER (){
  REG_TEXT_LABEL_1_VALUE=$(defaults read "$DEP_NOTIFY_USER_INPUT_PLIST" "$REG_TEXT_LABEL_1")

  product_name=$(ioreg -l | awk '/product-name/ { split($0, line, "\""); printf("%s\n", line[4]); }')
  CITY="$REG_POPUP_LABEL_1_VALUE"
  USER=$(echo $REG_TEXT_LABEL_1_VALUE |awk -F'@' '{print $1}')

  if echo "$product_name" | grep -q "MacBookAir*"
  then
      MAC="MBA"

  elif echo "$product_name" | grep -q "MacBookPro*"
  then
      MAC="MBP"

  elif echo "$product_name" | grep -q "iMac*"
  then
      MAC="iMAC"

  elif echo "$product_name" | grep -q "MacBook"
  then
      MAC="MB"

  elif echo "$product_name" | grep -q "Parallels*"
  then
      MAC="VM"

  elif echo "$product_name" | grep -q "Vmware*"
  then
      MAC="VM"

  else
      echo "No model identifier found."
      MAC=""

      if [ "$MAC" == "" ]; then
      echo "Error: No model identifier found."
      fi

  fi

  #curl apples machine db against last 4 of serial
  #get last four serial for year
  echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
      lastFourSerialForAPPL=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | grep -o '....$')
      echo "last four is" $lastFourSerialForAPPL
      #use that (serial) for actual year
      MNF_YEAR=$(curl "https://support-sp.apple.com/sp/product?cc=`echo $lastFourSerialForAPPL`" |grep -Eo '[0-9]{4}')
  else
      echo "Offline"
      MNF_YEAR="DEP"
  fi
  computer_name="$CITY-$MNF_YEAR-$MAC-$USER"
  # do all the things
  if [ -z "$computer_name" ]
  then
  echo "Please set \$computer_name"
  else
  $JAMF_BINARY setComputerName -name "$computer_name"
  echo "Status: Computername $computer_name is being set. " >> "$DEP_NOTIFY_LOG"	
  fi
}
