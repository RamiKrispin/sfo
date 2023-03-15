# SFO Air Traffic Passengers
cmd <- "curl 'https://data.sfgov.org/resource/rkru-6vcg.json?$limit=100000' | jq -r '.[] |[.activity_period, .operating_airline, .operating_airline_iata_code,
.published_airline, .published_airline_iata_code, .geo_summary, .geo_region,
.activity_type_code, .price_category_code, .terminal, .boarding_area, .passenger_count] |  @tsv'"


sfo_passengers_raw <- data.table::fread(cmd = cmd,
                                   na.strings= NULL,
                                   col.names = c("activity_period", "operating_airline",
                                                 "operating_airline_iata_code","published_airline",
                                                 "published_airline_iata_code", "geo_summary",
                                                 "geo_region", "activity_type_code",
                                                 "price_category_code", "terminal",
                                                 "boarding_area", "passenger_count")) |>
  as.data.frame()

head(sfo_passengers_raw)

write.csv(sfo_passengers_raw, "csv/sfo_passengers.csv", row.names = FALSE)

# Saving data up to Dec 2020
sfo_passengers <- sfo_passengers_raw #|>
  # dplyr::filter(activity_period <= 202012)
usethis::use_data(sfo_passengers, overwrite = TRUE)

# SFO Landing
cmd_stats <- "curl 'https://data.sfgov.org/resource/fpux-q53t.json?$limit=100000' | jq -r '.[] |[.activity_period, .operating_airline, .operating_airline_iata_code,
.published_airline, .published_airline_iata_code, .geo_summary, .geo_region,
.landing_aircraft_type, .aircraft_body_type, .aircraft_manufacturer, .aircraft_model, .aircraft_version,
.landing_count, .total_landed_weight] |  @tsv'"


sfo_stats_raw <- data.table::fread(cmd = cmd_stats,
                                    na.strings= NULL,
                                    col.names = c("activity_period", "operating_airline",
                                                  "operating_airline_iata_code","published_airline",
                                                  "published_airline_iata_code", "geo_summary",
                                                  "geo_region", "landing_aircraft_type",
                                                  "aircraft_body_type", "aircraft_manufacturer",
                                                  "aircraft_model", "aircraft_version",
                                                  "landing_count", "total_landed_weight")) |>
  as.data.frame()

head(sfo_stats_raw)

write.csv(sfo_stats_raw, "csv/sfo_stats.csv", row.names = FALSE)

# Save subset up to Dec 2020
sfo_stats <- sfo_stats_raw #|>
  # dplyr::filter(activity_period <= 202012)

usethis::use_data(sfo_stats, overwrite = TRUE)
