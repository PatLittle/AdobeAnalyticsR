library(adobeanalyticsr)
library(httr)
get_me()

stuff<-aw_get_dimensions()

topSearchesEN<-aw_freeform_table(
  date_range = c("2021-04-01", "2021-04-30"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("prop65","prop12","prop39"),
  metrics = c("pageviews"),
  search = c("MATCH 'OG-GO'", "CONTAINS 'search.open.canada.ca/en/od'", "CONTAINS 'search_text='"),
  top = c(5000)
)

topSearchesFR<-aw_freeform_table(
  date_range = c("2021-04-01", "2021-04-30"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("prop65","prop12","prop39"),
  metrics = c("pageviews"),
  search = c("MATCH 'OG-GO'", "CONTAINS 'rechercher.ouvert.canada.ca/fr/od/'", "CONTAINS 'search_text='"),
  top = c(5000)
)

searchQEN<-data.frame()
names(searchQEN)<-"search_text_query"

for (i in 1:length(topSearchesEN$prop39)){
x<-parse_url(topSearchesEN$prop39[i])$query$search_text
searchQEN<-rbind(searchQEN,x)
}

topSearchesEN<-cbind(topSearchesEN,searchQEN)
names(topSearchesEN)<-c("AA_Service_Name","base_URL","query_path","page_views","search_text_query")

searchQFR<-data.frame()
names(searchQFR)<-"search_text_query_FR"

for (i in 1:length(topSearchesFR$prop39)){
  x<-parse_url(topSearchesFR$prop39[i])$query$search_text
  searchQFR<-rbind(searchQFR,x)
}

topSearchesFR<-cbind(topSearchesFR,searchQFR)
names(topSearchesFR)<-c("AA_Service_Name","base_URL","query_path","page_views","search_text_query")

write.table(topSearchesEN,file="topSearchesEN.csv",append = F, col.names = T, row.names = F, sep=",", qmethod = "double")
write.table(topSearchesFR,file="topsearchesFR.csv",append = F, col.names = T, row.names = F,sep=",", qmethod = "double")
