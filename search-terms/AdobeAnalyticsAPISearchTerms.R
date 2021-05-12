library(adobeanalyticsr)
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

