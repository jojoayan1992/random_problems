#!/bin/bash

echo "*** SELECT VIEW ***"
echo
user=`/usr/ucb/whoami`

#echo "Select own view or enter 'others' for other view or 'user' for other user component:"

#Taking user input
while [ 1 ]
do
    echo "Select choice -->"
    echo "1. Use own view"
    echo "2. Enter whole viewname"
    echo "3. Use view of other user"
    echo "What would you want?"
    read choice
    if [[ $choice -eq 1 ]]
    then
        echo "Showing own view-list -->"
        cleartool lsview | grep $user
        echo "Enter the view component: "
        read req
# FOLLOWING CODE CAN ALSO BE USED FOR SHORTER EXECUTION.....
#if ($req == "others") then
#   echo "Enter the whole viewname you want to choose: "
#   set viewname = $<
#else if ($req == "user") then
#   echo "Enter user-id: "
#   set usr1 = $<
#   echo "Listing views..."
#    cleartool lsview | grep $usr1
#    echo "Enter the view component: "
#    set comp = $<
#    set viewname = $usr1"."$comp
#else
        viewname=$user"."$req
        break
    elif [[ $choice -eq 2 ]]
    then
        echo "Enter the whole view-name that you want to use: "
        read viewname
        break
    elif [[ $choice == 3 ]]
    then
        echo "Enter user-id: "
        read usr1
        echo "Listing views..."
        cleartool lsview | grep $usr1
        echo "Enter view component:"
        read comp 
        viewname=$usr1"."$comp
        break
    else
        echo "Wrong option chosen..."
        #set viewname = "amajumda.main"
    fi
done
TERM=xterm
host=`hostname`
echo $host
echo $viewname
if [[ $host != "lake" ]] 
then
    cd /software/src/marlin
#setenv TERM xterm-256color
    export TERM="xterm-256color"
else
    cd /home/amajumda/cscope_92x
    echo
    echo "***Opening CSCOPE... Kindly use Ctrl+d to close CSCOPE instead of Ctrl+z...***"
    echo
    sleep 2
    cleartool setview -exec "cscope -d" $viewname 
fi
echo
echo "################################################"
echo -n "Config spec of view: "
#cleartool setview -exec "catcs | sed -n 3p | awk '{print substr($2,25)}'" $viewname
cleartool setview -exec "catcs | sed -n 3p| cut -d ' ' -f2" $viewname
# Above might not always work, as the cs may not be the 6th element of splitted shit all the time...
#cleartool setview -exec "catcs | sed -n 3p" $viewname
sv -f $viewname
