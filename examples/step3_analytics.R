# some example to merge your previous dataset with your GA data

packages <- c("devtools","digest","googleAnalyticsR", "doBy", "dplyr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}


library(googleAnalyticsR)
library(lubridate)

# Load conf
source("conf.R")

url <- "https://WWW.YOUR WEBSITE.COM"

# create API
# add https://console.developers.google.com/apis/credentials?project=bigquerydatase
# add localhost:1410
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/analytics",
                                        "https://www.googleapis.com/auth/analytics.readonly"
                                        ),
        googleAuthR.client_id = googleAuthRClientId,
        googleAuthR.client_secret = googleAuthRclientSecret)


## Authenticate in Google OAuth2
## this also sets options
ga_auth()
#googleAuthR::gar_auth()

## if you need to re-authenticate use ga_auth(new_user=TRUE)

## if you have your own Google Dev console project keys,
## then don't run ga_auth() as that will set the authentication project to the defaults.
## instead put your options here, and run googleAuthR::gar_auth()

## get account info, including View Ids
account_list <- ga_account_list()

# get current website
siteGA <- account_list[which(grepl(url,account_list$websiteUrl)),]

# get current month
date_previous_month_begin <- floor_date(Sys.Date(), "month") - months(1)
date_previous_month_end <- ceiling_date(Sys.Date(), "month") - months(1)

ga_id <- siteGA$viewId

# we keep only organic visits from Google
ga_req1 <- make_ga_4_req(ga_id,
                         date_range = c(date_previous_month_begin,date_previous_month_end),
                         dimensions=c('pagePath'),
                         filters = c('ga:medium=@organic;ga:source=@google'),
                         metrics = c('sessions','pageViews','timeOnPage'))


gaDF <- fetch_google_analytics_4(list(ga_req1))

#Adapt URLs for matching
gaDF$pagePath <- paste(url,gaDF$pagePath,sep="")

#Fix Home
gaDF$pagePath[which(gaDF$pagePath==paste(url,"/",sep=""))] <- url

# Merge two datasets
seoDF <- merge(x = crawlDF, y = gaDF, by.x = "url", by.y = "pagePath", all.x = TRUE)


