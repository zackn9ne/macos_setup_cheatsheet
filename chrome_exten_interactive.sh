#!/bin/sh
open /Applications/Google\ Chrome.app/
sleep 5
$(osascript <<EOD
display alert "Did chrome load?" buttons {"No", "Yes"}
if button returned of result = "No" then
     display alert "No was clicked"
else
    if button returned of result = "Yes" then
        do shell script "open -a 'Google Chrome' https://chrome.google.com/webstore/detail/virtru-email-protection-f/nemmanchfojaehgkbgcfmdiidbopakpp?hl=en-US"

    end if
end if
EOD)
