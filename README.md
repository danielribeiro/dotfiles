# Using this
Docs for env variables: [http://git-scm.com/2010/04/11/environment.html](http://git-scm.com/2010/04/11/environment.html)

Do not put the dot files on the root folder, as it will mess with all other git folders. But using something like

    git --git-dir==tmp/dotfiles/.git

I can store my git in a safe place (tmp/dotfiles for instance). No need for symlinks or sync scripts (that is why we have git in the first place!).

