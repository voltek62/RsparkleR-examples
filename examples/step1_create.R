
packages <- c("dplyr","reticulate")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}

library(dplyr)
library(reticulate)
library(RsparkleR)

# Load conf
source("conf.R")

ovh <- import_ovh()

client <- load_client(ovh,endpoint,application_key,application_secret,consumer_key)

regionVM <- "UK1"
typeVM <- "s1-4"
sshPubKeyPath  <- 'C:/Users/vterrasi/.ssh/nopassphrase/id_rsa.pub'
sshPrivKeyPath <- 'C:/Users/vterrasi/.ssh/nopassphrase/id_rsa'

# Create one VM with OVH Public Cloud
vm <- sparkler.create(client, regionVM, typeVM, sshPubKeyPath, sshPrivKeyPath)

# Test your VM with pwd command
cloud_ssh(vm, "pwd")
# /home/debian/
