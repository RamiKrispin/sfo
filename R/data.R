#' SFO Airport Air Traffic Passenger Statistics
#' @description Monthly summary of number of passengers in San Francisco International Airport (SFO)
#' @format A data frame with 12 variables.
#' \describe{
#'   \item{activity_period}{Activity year and month in YYYYMM format}
#'   \item{operating_airline}{Airline name for the operator of aircraft}
#'   \item{operating_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Operating Airline}
#'   \item{published_airline}{Airline name that issues the ticket and books revenue for passenger activity}
#'   \item{published_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Published Airline}
#'   \item{geo_summary}{Designates whether the passenger activity in relation to SFO arrived from or departed to a location within the United States (“domestic”), or outside the United States (“international”) without stops}
#'   \item{geo_region}{Provides a more detailed breakdown of the GEO Summary field to designate the region in the world where activity in relation to SFO arrived from or departed to without stops}
#'   \item{activity_type_code}{A description of the physical action a passenger took in relation to a flight, which includes boarding a flight (“enplanements”), getting off a flight (“deplanements”) and transiting to another location (“intransit”)}
#'   \item{price_category_code}{A categorization of whether a Published Airline is a low-cost carrier or not a low-cost carrier}
#'   \item{terminal}{The airport terminal designations at SFO where passenger activity took place}
#'   \item{boarding_area}{The airport boarding area designations at SFO where passenger activity took place}
#'   \item{passenger_count}{The number of monthly passengers associated with the above attribute fields}
#'
#'   }
#' @source San Francisco data portal (DataSF) \href{https://data.sfgov.org/Transportation/Air-Traffic-Passenger-Statistics/rkru-6vcg}{website}.
#' @keywords datasets timeseries airline SFO passengers
#' @details The dataset contains the monthly summary of number of passengers in San Francisco International Airport (SFO)
#' @examples
#' data(sfo_passengers)
#'
#' require(dplyr)
#'
#' # Get summary of total number of passengers by activity type
#' # in most recent month
#' sfo_passengers %>%
#'   filter(activity_period == max(activity_period)) %>%
#'   group_by(activity_type_code) %>%
#'   summarise(total = sum(passenger_count), .groups = "drop")
#'
#' # Get summary of total number of passengers by
#' # activity type and geo region in most recent month
#' sfo_passengers %>%
#' filter(activity_period == max(activity_period)) %>%
#'   group_by(activity_type_code, geo_region) %>%
#'   summarise(total = sum(passenger_count), .groups = "drop")
#'
"sfo_passengers"

#' SFO Airport Air Landings Statistics
#' @description Monthly statistics on San Francisco International Airport (SFO) landings
#' @format A data frame with 14 variables.
#' \describe{
#'   \item{activity_period}{Activity year and month in YYYYMM format}
#'   \item{operating_airline}{Airline name for the operator of aircraft}
#'   \item{operating_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Operating Airline}
#'   \item{published_airline}{Airline name that issues the ticket and books revenue for passenger activity}
#'   \item{published_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Published Airline}
#'   \item{geo_summary}{Designates whether the passenger activity in relation to SFO arrived from or departed to a location within the United States (“domestic”), or outside the United States (“international”) without stops}
#'   \item{geo_region}{Provides a more detailed breakdown of the GEO Summary field to designate the region in the world where activity in relation to SFO arrived from or departed to without stops}
#'   \item{landing_aircraft_type}{A designation for three types of aircraft that landed at SFO, which includes passenger aircraft, cargo only aircraft (“freighters”) or combination aircraft (“combi”)}
#'   \item{aircraft_body_type}{A designation that is independent from Landing Aircraft Type, which determines whether commercial aircraft landed at SFO is a wide body jet, narrow body jet, regional jet or a propeller operated aircraft}
#'   \item{aircraft_manufacturer}{Manufacturer name for the aircraft that landed at SFO}
#'   \item{aircraft_model}{Model designation of aircraft by the manufacturer}
#'   \item{aircraft_version}{Variations of the Aircraft Model, also known as the “dash number”, designated by the manufacturer to segregate unique versions of the same model}
#'   \item{landing_count}{The number of aircraft landings associated with General and Landings Statistics attribute fields}
#'   \item{total_landed_weight}{The aircraft landed weight (in pounds) associated with General and Landings Statistics attribute fields}
#'
#'   }
#' @source San Francisco data portal (DataSF) \href{https://data.sfgov.org/Transportation/Air-Traffic-Landings-Statistics/fpux-q53t}{website}.
#' @keywords datasets timeseries airline SFO passengers
#' @details The dataset contains the monthly statistics on the air traffic landings in San Francisco International Airport (SFO)
#' @examples
#' data(sfo_stats)
#'
#' require(dplyr)
#'
#' # Get summary of total landing and weight by geo region
#' # in most recent month
#' sfo_stats %>%
#'   filter(activity_period == max(activity_period)) %>%
#'   group_by(geo_region) %>%
#'   summarise(total_landing = sum(landing_count),
#'             total_weight = sum(total_landed_weight),
#'   .groups = "drop")
#'
#'
"sfo_stats"
