# descriptive analysis
library(tidyverse)

skimr::skim(df_a)

# # summary stat(all)
# summary_all_a <- summarise_descriptive_stats(df_a)
# summary_all_b <- summarise_descriptive_stats(df_b)
# 
# print(summary_all_a[g])
# print(summary_all_b)
# 
# # summary stat(by group)
# 
# result_principal_a <- analyze_by_group(df_a,
#                                        female_principal)
# 
# result_principal_b <- analyze_by_group(df_b,
#                                        female_principal)
# print(result_principal_a)
# print(result_principal_b)
