# make dataset

# library -----------------------------------------------

# functions ---------------------------------------------
source("./src/analysis/preprocess_function.R")



# import datasets ----------------------------------------
source("./src/data/import_data_Japan.R")



# merge data ---------------------------------------------
source("./src/data/merge.R")



# cleaning  ----------------------------------------------
source("./src/data/cleaning.R")



# save data  ---------------------------------------------
# data for the main analysis
readr::write_csv(df_a,"./data/processed/TALIS2018_Japan_cleaned_elementary.csv")
readr::write_csv(df_b,"./data/processed/TALIS2018_Japan_cleaned_middle.csv")

# principal data
readr::write_csv(principal_df_a,"./data/processed/TALIS2018_Japan_principal_elementary.csv")
readr::write_csv(principal_df_b,"./data/processed/TALIS2018_Japan_principal_middle.csv")

