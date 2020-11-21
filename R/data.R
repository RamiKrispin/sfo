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
#' @details The dataset contains the monthly summary of number of passengers in San Francisco International Airport (SFO) by variety of categories
#' @examples
#' data(coronavirus)
#'
#' require(dplyr)
#'
#' # Get top confirmed cases by state
#' coronavirus %>%
#'   filter(type == "confirmed") %>%
#'   group_by(country) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total) %>%
#'   head(20)
#'
#' # Get the number of recovered cases in China by province
#' coronavirus %>%
#'   filter(type == "recovered", country == "China") %>%
#'   group_by(province) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total)
#'
"coronavirus"
