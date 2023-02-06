# backup-directory
# Overview

this is code that make backup for certain folder every interval of time with max number of backups you decide.

## How To Run ?

1. Here I just send the directory that contain all my scripts and makefiles and it called **tmp**  so you should put it in the home directory and use ***`cd /tmp`***  command before you run  the makefile with this command  ***`make -f Makefile.nor`*** or you could open the terminal from inside the directory that hold the scripts . 
2. Screenshot from 2022-10-18 18-02-28.png

in command in line 10 is representation of ***script_name  path_to_directory  path_to_backup_directory  interval-secs  max-backups***.  if you wish to change the name of the directory please change the path in **Makefile.nor**  that shown above.  As you should change **tmp** into your directory name in all the lines. Also if you want to backup certain directory that is not in **tmp** directory you should modify the whole path to that directory example: if you want to backup the **Desktop** directory which is in **home** directory you should modify the 1st argument in  line 10 to ***`~/Desktop`***. 

# Code :

1. in **Makefile.nor**  first i check if the backup directory is created or not and if not i will create it in **tmp** directory then i run my bash script and set the arguments

2. in bash script

  Screenshot from 2022-10-18 18-46-21.png

first we put the arguments in variables then we put the directory info in **directory_info.last** file and make the initial directory backup.


Then we make infinite while loop and inside it we first make the script sleep by interval of time then we put the directory information again but  in **directory_info.new** file. and compare the last and new file if they are similar then we will not make backup for the directory while if they are different that's mean that the directory is modified and we will create new backup for it.

Last but not least, we check if number of backups exceed maximum number of backups or not ,if yes we will delete the oldest backup.

# Cron job

- ### How To Run ?

  first you should make sure that you have **crontab** in you Linux and if it doesn't exist you should install it by this two commands in **home** directory 

  ```bash
  sudo apt-get update
  sudo apt-get install cron
  ```

  then you could check **crontab** files you have by this command

  ```bash
  crontab -l
  ```

 ![alt text] Screenshot from 2022-10-18 21-35-07.png

  thats mean there is no files so you should create one by this command
  
  ```bash
  crontab -e
  ```
  
   then you will write this command 
  
  ```bash
  * * * * * (cd ~/Desktop/6854-lab2 && make -f Makefile.withcron)
  ```
  
Screenshot from 2022-10-18 21-39-06.png
  
  then choose exit then press enter.
  
   this command represent **minute  hours  day_of_month  month  day_of_week  command to be executed** . the '*' means every thats mean that this command will be executed every 1 minute and the command is telling it to change directory to **tmp** directory where **Makefile.withcron** is exist.
  
  if you want to run your command every 3rd Friday of the month at 12:31 am you should write command as the following :
  
  ```bash
  31 0 15-21 * * [ "$(date '+\%a')" = "fri" ] && (cd ~/Desktop/6854-lab2 && make -f Makefile.withcron)
  ```
  
  

- ### Code :

Screenshot from 2022-10-18 20-11-20.png

in **Makefile.withcron** nothing changed except that we change the name of bash script and removed the **interval** argument as we don't need to specify it as **crontab** will execute it every min 

Screenshot from 2022-10-18 20-16-09.png



in **bakup_cron.sh** script the only difference is that we just removed the infinite loop and sleep for interval of time as crontab make this automatically and we put if statement that ask if the backup directory is empty we make the initial backup of our directory . As line 8,9  were before infinite loop in **backupd.sh** so they were executed only once so we didn't need to do this if statement while here the whole script will be executed every minute so we should constrain those 2 lines.  







