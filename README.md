# subroutines-and-delays
Assembly code mock exam.

Basic:
Create a subroutine that contains 4 NOPs, loops 71 times, and uses DECF to decrease the loop counter.  In simulator mode, use a stopwatch to determine how long the subroutine takes to execute.  Name the subroutine with that time to the nearest microsecond, e.g. _sub_350us.
Store the variable used in the subroutine in memory address 0x400. 
Hint: You will need to use the MOVLB command and the bank selection flag.  Remember to set the bank flag in MOVWF and DECF commands.

Medium:
Use the code you created in the Basic task.
The 7-segment displays should be off.
Create a second subroutine that has a delay of 40 ms. This new subroutine should call the subroutine from the Basic task.  Use the stopwatch to ensure the timing is within 5%.
Turn the right-most LED on for 40 ms, then off for 40 ms and repeat.

Advanced:
Nothing happens until PB2 is pressed.
Once PB2 is pressed, start the following sequence.
Use the code you created in the Medium task to turn the right-most LED on for 40 ms, then off for 40 ms and repeat.
However, if the PB1 is pressed, then instead pause for 400 ms LED on and 400 ms off.  
