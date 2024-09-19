# We know Sante Fe river has siteID 2322500 

floods$region <- ifelse(floods$siteID == 2322500, 
                        "Northern Florida", 
                        "Central Florida")

# Say you also want to add a category of "Zolfo" for Peace River (siteID = 2295637)
floods$region <- ifelse(floods$siteID == 2322500, 
                        "Northern Florida", 
                        ifelse(floods$siteID == 2295637,
                               "Zolfo",
                               "Central Florida"))
