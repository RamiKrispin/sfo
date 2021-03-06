% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{sfo_passengers}
\alias{sfo_passengers}
\title{SFO Airport Air Traffic Passenger Statistics}
\format{
A data frame with 12 variables.
\describe{
  \item{activity_period}{Activity year and month in YYYYMM format}
  \item{operating_airline}{Airline name for the operator of aircraft}
  \item{operating_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Operating Airline}
  \item{published_airline}{Airline name that issues the ticket and books revenue for passenger activity}
  \item{published_airline_iata_code}{The International Air Transport Association (IATA) two-letter designation for the Published Airline}
  \item{geo_summary}{Designates whether the passenger activity in relation to SFO arrived from or departed to a location within the United States (“domestic”), or outside the United States (“international”) without stops}
  \item{geo_region}{Provides a more detailed breakdown of the GEO Summary field to designate the region in the world where activity in relation to SFO arrived from or departed to without stops}
  \item{activity_type_code}{A description of the physical action a passenger took in relation to a flight, which includes boarding a flight (“enplanements”), getting off a flight (“deplanements”) and transiting to another location (“intransit”)}
  \item{price_category_code}{A categorization of whether a Published Airline is a low-cost carrier or not a low-cost carrier}
  \item{terminal}{The airport terminal designations at SFO where passenger activity took place}
  \item{boarding_area}{The airport boarding area designations at SFO where passenger activity took place}
  \item{passenger_count}{The number of monthly passengers associated with the above attribute fields}

  }
}
\source{
San Francisco data portal (DataSF) \href{https://data.sfgov.org/Transportation/Air-Traffic-Passenger-Statistics/rkru-6vcg}{website}.
}
\usage{
sfo_passengers
}
\description{
Monthly summary of number of passengers in San Francisco International Airport (SFO)
}
\details{
The dataset contains the monthly summary of number of passengers in San Francisco International Airport (SFO)
}
\examples{
data(sfo_passengers)

require(dplyr)

# Get summary of total number of passengers by activity type
# in most recent month
sfo_passengers \%>\%
  filter(activity_period == max(activity_period)) \%>\%
  group_by(activity_type_code) \%>\%
  summarise(total = sum(passenger_count), .groups = "drop")

# Get summary of total number of passengers by
# activity type and geo region in most recent month
sfo_passengers \%>\%
filter(activity_period == max(activity_period)) \%>\%
  group_by(activity_type_code, geo_region) \%>\%
  summarise(total = sum(passenger_count), .groups = "drop")

}
\keyword{SFO}
\keyword{airline}
\keyword{datasets}
\keyword{passengers}
\keyword{timeseries}
