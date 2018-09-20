# pass-git-helper
pass-git-helper is a simple shell script to store git credentials in a pass storage (https://www.passwordstore.org).

## Installation
 - Put the script in any location you like
 - Run `git config credentials.helper /path/of/the/script/pass-git-helper.sh` inside the repository you want to set up
   or run `git config --global credentials.helper /path/of/the/script/pass-git-helper.sh` to set it up for all repos.
 
 ## Usage
 Just use git like normal. Once you have used your credentials for the first time, they will be stored in your password storage with the prefix git- prepended to the hostname (this is of course easy to change in the script).
 If authentication fails, the credentials will automatically be deleted. Just run the command again and put in your new credentials.
