autocommit
==========

I lost code a few times and this felt like a good idea.

Script to auto commit repositories to a branch called 'autocommit'. Just set it up as a cron job to run however often you want it to. 

## Using autocommit

Modify find command on line 2 by setting the directroy. Mine is '~/Development', Maybe yours is just '~', who knows. 
Just change it to wherever you whant your search to start.

Now in ary repo that you want to autocommit, just add a file called '.autocommit'. Put it right next to your '.git' file.
You should be good! 


**Cron does not run as the current user, so you have to modify the push command to give correct permissions**

If any code is lost, it isn't my fault, but I have not lost any yet. 

