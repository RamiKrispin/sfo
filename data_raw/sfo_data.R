#' Pulling the Full SFO Passengers Dataset
#' @description Due to size limitation, the sfo_passengers dataset containes data
#' up to Dec 2020. The get_sfo_passengers functions enables to pull the full dataset
#' directly from the package repository.
#' @param type A character, the type of dataset - "passengers" (default) or "stats"
#' @return A data.frame objects with 12 columns
#' @export
#' @examples
#' library(dplyr)
#' library(plotly)
#'
#' passengers_df <- sfo_data(type = "passengers")
#'
#' head(passengers_df)
#'
#'
#' passengers_agg <- passengers_df %>%
#'   group_by(date, activity_type_code) %>%
#'   summarise(total = sum(passenger_count),
#'             .groups = "drop")
#'
#' head(passengers_agg)
#'
#' plot_ly(data = passengers_agg |> filter(activity_type_code == "Deplaned"),
#'         x = ~ date,
#'         y = ~ total,
#'         type = "scatter",
#'         mode = "lines") |>
#'   layout(title = "Total Air Passengers Landed in SFO",
#'          yaxis = list(title = "Number of Passengers"),
#'          xaxis = list(title = "Data source: San Francisco data portal (DataSF)"))

sfo_data <- function(type = "passengers"){
`%>%` <- magrittr::`%>%`
  df <- url <- NULL

  if(type != "passengers" && type != "stats"){
    stop("The type argument is not valid")
  }

  if(type == "passengers"){
    url <- "https://raw.githubusercontent.com/RamiKrispin/sfo/main/csv/sfo_passengers.csv"
    message("Trying to pull the sfo_passenger data...")
    tryCatch(
      expr = {
        df <- utils::read.csv(file = url)
      },
      error = function(e){
        message('Error!')
        print(e)
      },
      warning = function(w){
        message('Warning!')
        print(w)
      }
    )

    sfo_names <- c("activity_period", "operating_airline",
                   "operating_airline_iata_code", "published_airline",
                   "published_airline_iata_code", "geo_summary",
                   "geo_region", "activity_type_code",
                   "price_category_code", "terminal",
                   "boarding_area", "passenger_count")

    # Check the data
    if(is.null(df)){
      stop("Could not pull the 'sfo_passengers', please check the error message.")
    } else if(ncol(df) !=12){
      stop("The number of columns does not match the expected ones (12)")
    } else if(!all(names(df) %in% sfo_names)){
      stop("The columns names does not match the expected ones")
    } else if(nrow(df) < 20000){
      stop("The number of rows does not match the expected ones")
    }

    # Reformat the data
    output <- df %>%
      dplyr::mutate(activity_period = as.integer(activity_period),
                    passenger_count = as.integer(passenger_count),
                    date = as.Date(paste(substr(activity_period, 1,4), substr(activity_period, 5,6), "01", sep ="/"))) %>%
      dplyr::select(date, activity_period, dplyr::everything())


  } else if(type == "stats"){
    url <- "https://raw.githubusercontent.com/RamiKrispin/sfo/main/csv/sfo_stats.csv"
    message("Trying to pull the sfo_stats data...")
    tryCatch(
      expr = {
        df <- utils::read.csv(file = url)
      },
      error = function(e){
        message('Error!')
        print(e)
      },
      warning = function(w){
        message('Warning!')
        print(w)
      }
    )

    sfo_names <- c("activity_period", "operating_airline",
                   "operating_airline_iata_code", "published_airline",
                   "published_airline_iata_code", "geo_summary",
                   "geo_region", "landing_aircraft_type",
                   "aircraft_body_type", "aircraft_manufacturer",
                   "aircraft_model", "aircraft_version",
                   "landing_count","total_landed_weight")

    # Check the data
    if(is.null(df)){
      stop("Could not pull the 'sfo_stats', please check the error message.")
    } else if(ncol(df) !=14){
      stop("The number of columns does not match the expected ones (14)")
    } else if(!all(names(df) %in% sfo_names)){
      stop("The columns names does not match the expected ones")
    } else if(nrow(df) < 20000){
      stop("The number of rows does not match the expected ones")
    }

    # Reformat the data
    output <- df %>%
      dplyr::mutate(activity_period = as.integer(activity_period),
                    landing_count = as.integer(landing_count),
                    total_landed_weight = as.integer(total_landed_weight),
                    date = as.Date(paste(substr(activity_period, 1,4), substr(activity_period, 5,6), "01", sep ="/"))) %>%
      dplyr::select(date, activity_period, dplyr::everything())
  }

  message("Completed.")


  return(output)
}
