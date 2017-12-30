debug <- FALSE

# FIX Windows :  use ssh included with RStudio
env <- Sys.getenv("PATH")
path_ssh_windows <- "C:\\Program Files\\RStudio\\bin\\msys-ssh-1000-18"

if (grepl("Windows",Sys.info()["sysname"]) & !grepl("msys-ssh-1000-18",env)) {
  Sys.setenv('PATH'= paste(env,";",path_ssh_windows, sep="") )
  Sys.setenv('RSTUDIO_SSH_PATH'= path_ssh_windows )
}

# add your config

# OVH API
# https://api.ovh.com/createToken/index.cgi?GET=/*&POST=/*&PUT=/*&DELETE=/*
endpoint='ovh-eu'
application_key='XXXXXXXXXXXXXX'
application_secret='XXXXXXXXXXXXXXXXXXXXX'
consumer_key='XXXXXXXXXXXXXXXXXXX'

# GOOGLE
googleAuthRClientId <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
googleAuthRclientSecret <- "xxxxxxxxxxxxxxxxxx"

# OVH CLOUD
regionVM <- "UK1"
typeVM <- "s1-4"
sshPubKeyPath  <- 'C:/Users/vterrasi/.ssh/id_rsa.pub'
sshPrivKeyPath <- 'C:/Users/vterrasi/.ssh/id_rsa'
