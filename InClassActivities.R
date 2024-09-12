library(dplyr)
library(lubridate)

streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")

# In-class prompts
# Prompt 1: Follow the steps in the tutorial to join streamH and siteInfo into a data frame called Floods. Check if the type of join makes a difference in the outcome.
floods <- full_join(streamH, # left table
                    siteInfo, # right table
                    by = "siteID") # common identifier

floods_left  <- left_join(streamH, # left table
                          siteInfo, # right table
                          by = "siteID") # common identifier

floods_inner <- inner_join(streamH, # left table
                          siteInfo, # right table
                          by = "siteID") # common identifier

floods_right <- right_join(streamH, # left table
                             siteInfo, # right table
                             by = "siteID") # common identifier

# All joins result in the same data frame because siteIDs are present in each of the two data frames, therefore no differences would be observed.

# Prompt 2: Parse the date for the Floods data frame.

floods$dateF <- ymd_hm(floods$datetime,
                       tz = "America/New_York")

# Prompt 3: What was the earliest date that each river reached the flood stage?

floods$doy <- yday(floods$dateF)
earliestFlood <- floods %>%
  filter(gheight.ft >= flood.ft) %>%
  group_by(names) %>%
  summarise(earliest = dateF[which.min(doy)])

# WITHLACOOCHEE RIVER AT US 301 AT TRILBY: 2017-09-11 08:15:00
# FISHEATING CREEK AT PALMDALE: 2017-09-11 03:00:00
# PEACE RIVER AT US 17 AT ZOLFO SPRINGS: 2017-09-08 00:00:00
# SANTA FE RIVER NEAR FORT WHITE: Never flooded