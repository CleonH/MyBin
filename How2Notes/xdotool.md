https://stackoverflow.com/questions/8480073/how-would-i-get-the-current-mouse-coordinates-in-bash



To avoid all the sed/awk/cut stuff, you can use

xdotool getmouselocation --shell

In particular,

eval $(xdotool getmouselocation --shell)

will put the position into shell variables X, Y and SCREEN. After that,

echo $X $Y

will give a snippet ready for a later xdotool mousemove or any other use.

My extra for sequential clicking into a few positions is a file positions.txt (given by a few eval/echo runs):

123 13
423 243
232 989

And the code that uses it is:

while read line; do
     X=`echo $line| cut -c1-3`; 
     Y=`echo $line| cut -c4-7`;
     xdotool mousemove --sync $((  0.5 + $X )) $(( 0.5 + $Y ));
     xdotool click 1
done < positions.txt

If there is no need to scale pixels (unlike my case), it could be a simple

while read line; do
     xdotool click 1
done < positions.txt

