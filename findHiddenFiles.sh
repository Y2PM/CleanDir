#!/bin/sh
#Name: Joseph Samuel Bannert, Date: 11Jul2021, Purpose: find hidden files and hidden directories with option to delete.
#var1=(find . -iname ".?*" ! -iname "*DS_Store*"); $var1 > HiddenFileList.txt; echo "\033[1mFound hidden files:\033[0m"; $var1 - this works in terminal
#-----Block 1:
#$1 is path to run script.

#if [ $1 ]
#then
#  break
#else
#  (1=".")
#fi

findcmd1="find . -iname \".?*\" ! -iname \"*DS_Store*\"";

findcmd2="find . -iname \".?*\" ! -iname \"*DS_Store*\" -exec echo -n '\"{}\" ' \; | tr '\n' ' '";

linecountcmd1="( cat HiddenFileList.txt ) | ( wc -l )";

findResult2=$(eval $findcmd2);

findResult1=$(eval $findcmd1);

if test ! -z "$findResult1" #if findResult1 is not empty
then
  (
 echo "$findResult1" > HiddenFileList.txt;
 #echo "not empty";
  )
else
  (
  > HiddenFileList.txt;
 #echo "empty";
  )
fi

linecount1=$(eval $linecountcmd1);

output1="\033[1mFound $linecount1 hidden files.\033[0m";
output2="\033[1mFound $linecount1 hidden files:\033[0m";

if [ $linecount1 -gt 0 ]
then
	(echo $output2)
else
  (echo $output1)
fi
eval "$findcmd1";
#------Block 2:
if [ $linecount1 -gt 0 ]
then
	(echo "\033[1mdelete? y/n\033[0m")
fi

if [ $linecount1 -gt 0 ]
then
read deleteFilesDecision;
fi

if [ $linecount1 -gt 0 ] && [ $deleteFilesDecision == y ]
then
	(
#echo $findResult2; - if uncommented this prints all found files as one line, each path in double quotes.

eval "find . -iname \".?*\" ! -iname \"*DS_Store*\" | xargs -I{} rm -r \"{}\"";
echo "\033[1mdeleted.\033[0m"

  )
else
  (
  #echo "didn't delete."
  break;
  )
fi
