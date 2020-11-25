#' Sankey Plot with Plotly
#' @details A customized function for plotting sankey plots with Plotly
#' @export
#' @param x A data.frame input
#' @param cols A vector of columns names
#' @param num_col The numeric column name


sankey_ly <- function(x, cols, num_col){
  map <- function(x, cols){
    unique_cat <- map_df <- NULL
    x <- as.data.frame(x)
    for(i in cols){
      unique_cat <- c(unique_cat, base::unique(x[, i]))
    }

    map_df <- base::data.frame(cat = unique_cat,
                               index = 0:(length(unique_cat) - 1),
                               stringsAsFactors = FALSE)
    return(map_df)
  }

  map <- map(x, cols)
  df <- lapply(1:(base::length(cols) - 1), function(i){
    df <- NULL
    df <- x %>%
      dplyr::group_by_(s = cols[i], t = cols[i + 1]) %>%
      dplyr::summarise_(.dots = setNames(paste("sum(", num_col, ",na.rm = TRUE)", sep = ""), "total")) %>%
      dplyr::left_join(map %>% dplyr::select(s = cat, source = index)) %>%
      dplyr::left_join(map %>% dplyr::select(t = cat, target = index))

    return(df)
  }) %>% dplyr::bind_rows()


  p <- plotly::plot_ly(
    type = "sankey",
    orientation = "h",
    valueformat = ".0f",
    valuesuffix = "TWh",
    node = list(
      label = map$cat,
      # color = c("blue", "green", "red", "purple", "yellow", "black"),
      pad = 15,
      thickness = 30,
      line = list(
        color = "black",
        width = 0.5
      )
    ),

    link = list(
      source = df$source,
      target = df$target,
      value =  df$total
    )
  )
  return(p)
}
