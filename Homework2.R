library(ggplot2)

# Question 1: Make a separate plot of the stream stage data for each river. 
#   In 3-4 sentences compare general patterns in the stream stage between sites 
#   around Hurricane Irma.

floods <- floods %>% mutate(stage = case_when(
  gheight.ft < action.ft ~ "None",
  gheight.ft < flood.ft ~ "Action",
  gheight.ft < moderate.ft ~ "Flood",
  gheight.ft < major.ft ~ "Moderate", 
  .default = "Major"
)
)

fisheating <- floods %>% filter(siteID == 2256500)
peace <- floods %>% filter(siteID == 2295637)
santafe <- floods %>% filter(siteID == 2322500)
withlacoochee <- floods %>% filter(siteID == 2312000)

fe.plot <- ggplot(data = fisheating, aes(x = dateF, y = gheight.ft)) +
           geom_line() + 
           geom_point(aes(color = stage), size = 0.05) +
           labs(title = "Fisheating Creek",
                x = "Date",
                y = "Water Level (ft)") +
  ylim(0, 25)

pce.plot <- ggplot(data = peace, aes(x = dateF, y = gheight.ft)) +
  geom_line() + 
  geom_point(aes(color = stage), size = 0.05) +
  labs(title = "Peace River",
       x = "Date",
       y = "Water Level (ft)") +
  ylim(0, 25)

sf.plot <- ggplot(data = santafe, aes(x = dateF, y = gheight.ft)) +
  geom_line() + 
  geom_point(aes(color = stage), size = 0.05) +
  labs(title = "Santa Fe River",
       x = "Date",
       y = "Water Level (ft)") +
  ylim(0, 25)

wlc.plot <- ggplot(data = withlacoochee, aes(x = dateF, y = gheight.ft)) +
  geom_line() + 
  geom_point(aes(color = stage), size = 0.05) +
  labs(title = "Withlacoochee River",
       x = "Date",
       y = "Water Level (ft)") +
  ylim(0, 25)

library(ggpubr)
ggarrange(fe.plot, pce.plot, sf.plot, wlc.plot)

# Question 2: What was the earliest date of occurrence for each flood category in each river? 
#   How quickly did changes in flood category occur for each river? 
#   Do you think there was enough time for advanced warning before a flood category changed?
  
earliest_each <- floods %>%
  group_by(names, stage) %>%
  summarise(earliest_date = min(dateF)) %>%
  arrange(names, earliest_date)
View(earliest_each)
# Question 3: Which river had the highest stream stage above its listed height in the major 
#   flood category?
max_heights <- floods %>%
  group_by(names) %>%
  summarise(max_height = max(gheight.ft),
            diff = max_height - max(major.ft))

biggest_diff <- max_heights$names[which.max(max_heights$diff)]
biggest_diff
# Question 4: Copy the url for your R script from GitHub and paste it here.