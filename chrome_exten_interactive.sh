#!/bin/sh
$(osascript <<EOD
display alert "This is an alert" buttons {"No", "Yes"}
if button returned of result = "No" then
     display alert "No was clicked"
else
    if button returned of result = "Yes" then
         do shell script "pwd"
    end if
end if
EOD)
