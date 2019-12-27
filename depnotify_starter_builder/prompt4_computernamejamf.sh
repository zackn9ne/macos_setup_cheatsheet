  #######################################################################################
 # First Text Field
  #######################################################################################
    # Text Field Label
      REG_TEXT_LABEL_1="First & Last Name"

    # Place Holder Text
      REG_TEXT_LABEL_1_PLACEHOLDER="John Smith"

    # Optional flag for making the field an optional input for end user
      REG_TEXT_LABEL_1_OPTIONAL="false" # Set variable to true or false

    # Help Bubble for Input. If title left blank, this will not appear
      REG_TEXT_LABEL_1_HELP_TITLE="Name Field"
      REG_TEXT_LABEL_1_HELP_TEXT="Type in your First Name and Last Name. This is important for inventory purposes."

    # Logic below was put in this section rather than in core code as folks may
    # want to change what the field does. This is a function that gets called
    # when needed later on. BE VERY CAREFUL IN CHANGING THE FUNCTION!
      REG_TEXT_LABEL_1_LOGIC (){
        REG_TEXT_LABEL_1_VALUE=$(defaults read "$DEP_NOTIFY_USER_INPUT_PLIST" "$REG_TEXT_LABEL_1")
        if [ "$REG_TEXT_LABEL_1_OPTIONAL" = true ] && [ "$REG_TEXT_LABEL_1_VALUE" = "" ]; then
          echo "Status: $REG_TEXT_LABEL_1 was left empty. Skipping..." >> "$DEP_NOTIFY_LOG"
          echo "$(date "+%a %h %d %H:%M:%S"): $REG_TEXT_LABEL_1 was set to optional and was left empty. Skipping..." >> "$DEP_NOTIFY_DEBUG"
          sleep 5
        else
          echo "Status: $REGISTRATION_BEGIN_WORD $REG_TEXT_LABEL_1 $REGISTRATION_MIDDLE_WORD $REG_TEXT_LABEL_1_VALUE" >> "$DEP_NOTIFY_LOG"
          if [ "$TESTING_MODE" = true ]; then
            sleep 10
          else
            "$JAMF_BINARY" recon -realname "$REG_TEXT_LABEL_1_VALUE"
            username=$(echo "$REG_TEXT_LABEL_1_VALUE" | sed -e 's/ /./g')
            echo "$username"
            "$JAMF_BINARY" recon -endUsername "$username"
            sleep 5
          fi
        fi
      }

