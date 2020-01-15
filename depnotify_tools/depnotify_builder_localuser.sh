  # Label for the popup
      REG_POPUP_LABEL_2="Do you want to create end-user account"

    # Array of options for the user to select
      REG_POPUP_LABEL_2_OPTIONS=(
        "Yes"
        "No"
        
      )

    # Help Bubble for Input. If title left blank, this will not appear
      REG_POPUP_LABEL_2_HELP_TITLE="Create local user"
      REG_POPUP_LABEL_2_HELP_TEXT="Pick if you want to create a local accout. Default password will be: ChangemeASAP"

    # Logic below was put in this section rather than in core code as folks may
    # want to change what the field does. This is a function that gets called
    # when needed later on. BE VERY CAREFUL IN CHANGING THE FUNCTION!
      REG_POPUP_LABEL_2_LOGIC (){
        REG_POPUP_LABEL_2_VALUE=$(defaults read "$DEP_NOTIFY_USER_INPUT_PLIST" "$REG_POPUP_LABEL_2")
        echo "Status: $REGISTRATION_BEGIN_WORD $REG_POPUP_LABEL_2 $REGISTRATION_MIDDLE_WORD $REG_POPUP_LABEL_2_VALUE" >> "$DEP_NOTIFY_LOG"
        new=$(echo "$REG_POPUP_LABEL_2_VALUE")
        echo $new
        
        if [ "$new" = "Yes" ]; then
          		echo "Status: Local user $username is being created with password: ChangemeASAP " >> "$DEP_NOTIFY_LOG"
                sleep 3
				sudo /usr/sbin/sysadminctl -addUser $username -fullName "$REG_TEXT_LABEL_1_VALUE" -admin -password "ChangemeASAP" 
				"$JAMF_BINARY" recon -assetTag "Password 4 user: $username:= ChangemeASAP"
        else
          echo "No local user account created"
          echo "Status: You picked to skip user account creation" >> "$DEP_NOTIFY_LOG"
          sleep 1
    
        fi
      }
