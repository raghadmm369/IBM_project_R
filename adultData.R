library(tidyverse)
# Read data from a file
adult <- read.table("adult.data", sep=",")

colnames(adult)<- c("age","workclass","fnlwgt","education","education_num","marital_status","occupation","relationship","race","sex","capital_gain"
                    ,"capital_loss","hours_per_week","native_country","prediction")

