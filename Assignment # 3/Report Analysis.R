
matched_items <- read.csv(file = "Mapped Titles.csv", 
                          header = TRUE, sep = ",")


matched_items <- unique(matched_items)


most_viewed <- sort(matched_items$Views, decreasing = TRUE, 
                    na.last = TRUE)
most_viewed <- unique(most_viewed)
print(most_viewed[1:10])


hash <- function( keys ) {
  result <- new.env( hash = TRUE, parent = emptyenv(), size = length( keys ) )
  for( key in keys ) {
    result[[ key ]] <- 0
  }
  return( result )
}
read_new_mobile_data <- read.csv(file = "new_mobile_prices.csv",
                                 header = TRUE, sep = ",")
new_mob_hash <- hash(read_new_mobile_data$Title)
populate_occurences(read_new_mobile_data$Title, new_mob_hash)

populate_occurences <- function (some_data, hash) {
  for (key in some_data) {
    hash[[key]] <- hash[[key]] + 1
  }  
  return (hash)
}

get_top_most <- function (some_data, hash) {
  max = 0
  most_available = ""
  for (key in some_data) {
    if (max < hash[[key]]) {
      max = hash[[key]]
      most_available = key
    }
  }
  print(most_available)
}

# Getting Top Ten Mobiles

get_top_ten <- function (some_data, hash) {
  max = 0
  for (key in some_data) {
    if (max < hash[[key]]) {
      max = hash[[key]]
      most_available = key
      cat(key, max, "")
    }
  }  
}

# Getting user who has post most ads and Top Users
unique_users <- unique(matched_items$Username)
unique_users_hash <- hash(unique_users)
populate_occurences(matched_items$Username, unique_users_hash)
print (get_top_most(matched_items$Username, unique_users_hash))
get_top_ten(matched_items$Username, unique_users_hash)

# Getting the City that included most ads and Ranking them
unique_cities <- unique(matched_items$City)
unique_cities_hash <- hash(unique_cities)
populate_occurences(matched_items$City, unique_cities_hash)

print(typeof(matched_items$New_Price[1]))
# Getting change in Prices [New-Original]

for (i in 1 : length(matched_items$Title)) {
  
    if ((matched_items$New_Price[i]) != 0) {
      change_in_price <- as.numeric(gsub(",","", matched_items$Old_Price[i])) - 
        as.numeric(gsub(",","", matched_items$New_Price[i]))
     }
    else {
      change_in_price <- NA
    }
  dfrm <- data.frame(New_Old = change_in_price)
  if (i == 1) {
  write.table(dfrm, file="change_in_price.csv", sep = ",",
              row.names = FALSE, col.names = TRUE)
  } else write.table(dfrm, file="change_in_price.csv", append = TRUE, sep = ",",
                     row.names = FALSE, col.names = FALSE)
}

# Finding percent change in Prices of all Items  
#[formula: (Now - Original) / Original * 100]

for (i in 1 : length(matched_items$Title)) {
  
  if ((matched_items$New_Old[i]) != 0) {
    percent_change_in_price <- (as.numeric(gsub(",","", matched_items$New_Old[i])) / 
      (as.numeric(gsub(",","", matched_items$New_Price[i])) * 100))
  }
  else {
    percent_change_in_price <- 0
  }
  dfrm <- data.frame(Percent_Change_in_Price = percent_change_in_price)
  if (i == 1) {
    write.table(dfrm, file="change_in_price.csv", sep = ",",
                row.names = FALSE, col.names = TRUE)
  } else write.table(dfrm, file="change_in_price.csv", append = TRUE, sep = ",",
                     row.names = FALSE, col.names = FALSE)
}


sum_of_all_percentile = 0
for (i in 1 : length(matched_items$Title)) {
    sum_of_all_percentile =  sum_of_all_percentile +
      as.numeric(gsub(",","", matched_items$Percent_Change_in_Price[i]))
}
print(sum_of_all_percentile / length(matched_items$Olx_Title))



sort_change_in_price <- sort(matched_items$Percent_Change_in_Price, 
                             decreasing = FALSE, na.last = TRUE)
dfrm <- data.frame(Sort_wrt_Percent_Change_in_Price = sort_change_in_price)
write.table(dfrm, file = "change.csv", sep = ",", 
            row.names = FALSE, col.names = TRUE)



max = 0
max_views_percent = 0
for (i in 1 : length(matched_items$Olx_Title)) {
    if (max < as.numeric(gsub(",","", matched_items$Views[i]))) {
        max = matched_items$Views[i]
        max_views_percent = matched_items$Percent_Change_in_Price[i]
    }     
}





