
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sfo

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/sfo)](https://cran.r-project.org/package=sfo)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/RamiKrispin/sfo)](https://github.com/RamiKrispin/sfo/commit/main)

<!-- badges: end -->

The **sfo** package provides summary statistics of the monthly
passengers and landing in San Francisco International Airport (SFO).

Data source: San Francisco data portal - [DataSF
API](https://datasf.org/opendata/)

<img src="man/figures/total.svg" width="90%"/>

## Installation

Install the stable version from CRAN:

``` r
install.packages("sfo")
```

or install the development version from Github:

``` r
# install.packages("devtools")
devtools::install_github("RamiKrispin/sfo", ref = "main")
```

### Datasets

The **sfo** package provides the following two datasets:

-   `sfo_passengers` - air traffic passengers statistics
-   `sfo_stats` - air traffic landing statistics

More information about the datasets available on the following
[vignette](https://ramikrispin.github.io/sfo/articles/v1_intro.html).

### Examples

The `sfo_passengers` dataset provides a monthly summary of the number of
passengers in SFO airport by different categories (such as terminal,
geo, type, etc.):

``` r
library(sfo)

data("sfo_passengers")

head(sfo_passengers)
#>   activity_period operating_airline operating_airline_iata_code published_airline published_airline_iata_code   geo_summary geo_region activity_type_code price_category_code      terminal
#> 1          202009   United Airlines                          UA   United Airlines                          UA International     Mexico           Enplaned               Other    Terminal 3
#> 2          202009   United Airlines                          UA   United Airlines                          UA International     Mexico           Enplaned               Other    Terminal 3
#> 3          202009   United Airlines                          UA   United Airlines                          UA International     Mexico           Enplaned               Other International
#> 4          202009   United Airlines                          UA   United Airlines                          UA International     Mexico           Deplaned               Other International
#> 5          202009   United Airlines                          UA   United Airlines                          UA International     Europe           Enplaned               Other International
#> 6          202009   United Airlines                          UA   United Airlines                          UA International     Europe           Deplaned               Other International
#>   boarding_area passenger_count
#> 1             F            6712
#> 2             E             396
#> 3             G             376
#> 4             G            6817
#> 5             G            3851
#> 6             G            3700
```

The `sfo_stats` dataset provides a monthly statistics on the air traffic
landing at SFO airport:

``` r
data("sfo_stats")

head(sfo_stats)
#>   activity_period operating_airline operating_airline_iata_code published_airline published_airline_iata_code   geo_summary geo_region landing_aircraft_type aircraft_body_type aircraft_manufacturer
#> 1          202009   United Airlines                          UA   United Airlines                          UA International     Mexico             Passenger        Narrow Body                Airbus
#> 2          202009   United Airlines                          UA   United Airlines                          UA      Domestic         US             Passenger        Narrow Body                Boeing
#> 3          202009   United Airlines                          UA   United Airlines                          UA International     Canada             Passenger        Narrow Body                Boeing
#> 4          202009   United Airlines                          UA   United Airlines                          UA      Domestic         US             Passenger        Narrow Body                Boeing
#> 5          202009   United Airlines                          UA   United Airlines                          UA International     Mexico             Passenger        Narrow Body                Boeing
#> 6          202009   United Airlines                          UA   United Airlines                          UA      Domestic         US             Passenger        Narrow Body                Boeing
#>   aircraft_model aircraft_version landing_count total_landed_weight
#> 1           A320                -            37             5261326
#> 2           B738                -            14             2048200
#> 3           B738                -             1              146300
#> 4           B738                -           251            36721300
#> 5           B738                -             3              438900
#> 6           B739                -           553            86986900
```

#### Total number of passngers

The total number of passengers in most recent month by
`activity_type_code` and `geo_region`:

``` r
library(dplyr)

sfo_passengers %>%
  filter(activity_period == max(activity_period)) %>%
  group_by(activity_type_code, geo_region) %>%
  summarise(total = sum(passenger_count), .groups = "drop")
#> # A tibble: 16 x 3
#>    activity_type_code geo_region           total
#>    <chr>              <chr>                <int>
#>  1 Deplaned           Asia                 15775
#>  2 Deplaned           Australia / Oceania   2942
#>  3 Deplaned           Canada                4021
#>  4 Deplaned           Central America        505
#>  5 Deplaned           Europe               12031
#>  6 Deplaned           Mexico               11642
#>  7 Deplaned           Middle East           1490
#>  8 Deplaned           US                  394036
#>  9 Enplaned           Asia                 20123
#> 10 Enplaned           Australia / Oceania   3347
#> 11 Enplaned           Canada                4291
#> 12 Enplaned           Central America        328
#> 13 Enplaned           Europe               12271
#> 14 Enplaned           Mexico               12430
#> 15 Enplaned           Middle East           1176
#> 16 Enplaned           US                  409584
```

The `sankey_ly` function enables us to plot the distribution of a
numeric variable by multiple categorical variables. The following
example shows the distribution of the total United Airlines passengers
during 2019 by terminal, travel type (domestic and international), geo,
and travel direction (deplaned, enplaned, and transit):

``` r
sfo_passengers %>% 
  filter(operating_airline == "United Airlines",
         activity_period >= 201901 & activity_period < 202001) %>%
  mutate(terminal = ifelse(terminal == "International", "international", terminal)) %>%
  group_by(operating_airline,activity_type_code, geo_summary, geo_region,  terminal) %>%
  summarise(total = sum(passenger_count), .groups = "drop") %>%
  sankey_ly(cat_cols = c("operating_airline", "terminal","geo_summary", "geo_region", "activity_type_code"), 
            num_col = "total",
            title = "Dist. of United Airlines Passengers at SFO During 2019")
```

<img src="man/figures/sankey.svg" width="100%"/>

#### Total number of landing

The total number of landing in most recent month by `activity_type_code`
and `aircraft_manufacturer`:

``` r
sfo_stats %>% 
  filter(activity_period == max(activity_period),
         aircraft_manufacturer != "") %>%
  group_by(aircraft_manufacturer) %>%
  summarise(total_landing = sum(landing_count),
            `.groups` = "drop") %>%
  arrange(-total_landing) %>%
  plot_ly(labels = ~ aircraft_manufacturer,
          values = ~ total_landing) %>%
  add_pie(hole = 0.6) %>%
  layout(title = "Landing Distribution by Aircraft Manufacturer during Sep 2020")
```

<img src="man/figures/manufacturer.svg" width="100%"/>

The following Sankey plot demonstrate the distribution of number of
landing in SFO by region and aircraft type, manufacturer, and body type
during Sep 2020:

``` r
sfo_stats %>%
  filter(activity_period == max(activity_period)) %>%
  group_by(geo_summary, geo_region, landing_aircraft_type, aircraft_manufacturer, aircraft_body_type) %>%
  summarise(total_landing = sum(landing_count),
  groups = "drop") %>%
  sankey_ly(cat_cols = c("geo_summary", "geo_region", 
                         "landing_aircraft_type", 
                         "aircraft_manufacturer",
                         "aircraft_body_type"),
            num_col = "total_landing",
            title = "Landing Summary by Geo Region and Aircraft Type During Sep 2020")
```

<img src="man/figures/landing_sankey.svg" width="100%"/>
