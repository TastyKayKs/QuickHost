# QuickHost
Host text as plaintext on port 42069, sort of like python simple http server, but only one and done, no multiple clients.

You could definitely do this smarter with the HTTPListener class in C#/POSH, HOWEVER, when using plaintext like this for the header and specifying a random high port, you can circumvent a lot of antivirus/security policies. I don't recommend leaving a listening port open, which is why this is one and done, it's more for admins/users who need to get files (like apt source lists) onto boxes that have weird access issues (like linux VMs with no copy paste and don't have openssh-server installed) 
