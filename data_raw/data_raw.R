cmd <- "curl 'https://data.sfgov.org/resource/rkru-6vcg.json?$limit=25000' | jq -r '.[] |[.activity_period, .operating_airline, .operating_airline_iata_code,
.published_airline, .published_airline_iata_code, .geo_summary, .geo_region,
.activity_type_code, .price_category_code, .terminal, .boarding_area, .passenger_count] |  @tsv'"


sfo_passengers <- data.table::fread(cmd = cmd,
                                   na.strings= NULL,
                                   col.names = c("activity_period", "operating_airline",
                                                 "operating_airline_iata_code","published_airline",
                                                 "published_airline_iata_code", "geo_summary",
                                                 "geo_region", "activity_type_code",
                                                 "price_category_code", "terminal",
                                                 "boarding_area", "passenger_count")) %>%
  as.data.frame()

head(sfo_passengers)

write.csv(sfo_passengers, "csv/sfo_passengers.csv", row.names = FALSE)
usethis::use_data(sfo_passengers, overwrite = TRUE)