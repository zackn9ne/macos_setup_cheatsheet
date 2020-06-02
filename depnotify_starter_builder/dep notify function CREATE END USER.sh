  #######################################################################################
#Create End User
  #######################################################################################
CREATE_END_USER () {
  #REG_TEXT_LABEL_1_VALUE=$(defaults read "$DEP_NOTIFY_USER_INPUT_PLIST" "$REG_TEXT_LABEL_1")
  echo "Status: Local user $REG_TEXT_LABEL_1_VALUE is being created with password: ChangemeASAP " >> "$DEP_NOTIFY_LOG"	

  USER=$(echo $REG_TEXT_LABEL_1_VALUE |awk -F'@' '{print $1}')
  /usr/sbin/sysadminctl -addUser $USER -fullName "$REG_TEXT_LABEL_1_VALUE" -password "ChangemeASAP"
}
  
