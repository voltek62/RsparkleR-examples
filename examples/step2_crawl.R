library(stringr)
library(RsparkleR)

# Load conf
source("conf.R")

# start Sparkler
sparkler.start(vm, debug)

# setup your website url
url <- "https://WWW.YOUR WEBSTE.com"
pattern <- "WWW.YOUR WEBSITE.com"

# number of URLs in each website.. ( top-n )
topN <- 1000
# Number of iterations to run
maxIter <- 100;
# number of hosts to fetch in parallel.
topGroups <- 2

# start crawl
crawlid <- sparkler.crawl(vm, url, topN, topGroups, maxIter, debug, mode="fast")

# read solr
crawlDF <- sparkler.read.csv(vm, pattern, crawlid, topN, extracted=FALSE)

# check if crawl is done
checkAll <- sparkler.check(vm,pattern,crawlid,topN)

#if finished ; delete VM
if (checkAll==TRUE) {

  # Test : no need to get all extracted text
  crawlDF <- sparkler.read.csv(vm, pattern, crawlid, topN, extracted=FALSE)

  # precalculated data
  # TODO : Response Time
  crawlDF <- mutate(crawlDF,'Word Count'=str_count(extracted_text,'\\w+')
                    ,'Title 1 Length'=nchar(title_t_md)
                    ,'Meta Description 1 Length'=nchar(description_t_md)
                    ,'Total Outlinks'= str_count(outlinks,',http')+1
  )

  # Destroy instance if it is not useful
  sparkler.stop(vm, debug)

  delete_instance(client, vm$projectId, vm$instanceId)

}

