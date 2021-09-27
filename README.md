# fuzzy_autoroot

### A simple multithreaded Linux root password Bruteforcer

fuzzy_autoroot is a Multithreaded UNIX-Like tool to brute-force local root through su using sucrack binary. You will need to compile your own sucrack binary and change the SUCRACK_NAME in VARIABLES.

Fuzzy_autoroot uses Sucrack to bruteforce in background so you can leave it running. When root is cracked it will email you using /bin/mail.

~ ./autoroot youremail@address.com  

If the password is cracked you will have a mail with the root password and the password will be stored into password.txt.

/!\ Still in developpement 
