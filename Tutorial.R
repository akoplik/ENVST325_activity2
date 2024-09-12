### TUTORIAL

# install.packages(c("dplyr", "lubridate"))
library(dplyr)
library(lubridate)

streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")

# parse dates
streamH$dateF <- ymd_hm(streamH$datetime,
                           tz = "America/New_York")

# year(streamH$dateF ) -> get the year
# leap_year(streamH$dateF ) -> is it a leap year?
# yday(streamH$dateF ) -> which day of the year
# decimal_date(streamH$dateF ) -> the year as a decimal

# join site info and stream heights into a new data frame floods
floods <- full_join(streamH, # left table
                    siteInfo, # right table
                    by = "siteID") # common identifier

# full_join -> adds obs from each even if they're not in both
# left_join -> keeps structure of left table, doesn't add new obs if it's only in right
# inner_join -> only keeps obs in both

# basic subset: peace <- streamH[streamH$siteID == 2295637,]

# dplyr filtering

peace <- floods %>%
  filter(siteID == 2295637)

# dplyr grouping
max_ht <- floods %>%
  group_by(names) %>%
  summarise(max_height_ft = max(gheight.ft, na.rm = TRUE),
            flood_height_ft = min(flood.ft, na.rm = TRUE))
