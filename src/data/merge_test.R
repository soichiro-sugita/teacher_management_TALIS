library(dplyr)

# --- select variables ---
teacher_df <- select_var_teacher(teacher_raw)
principal_df <- select_var_principal(principal_raw)

# --- extract valid samples ---
teacher_df <- teacher_df %>% filter(INTAL18 == 1)
principal_df <- principal_df %>% filter(INTAL18 == 1)

# --- merge tables ---
merged_df <- teacher_df %>%
  left_join(principal_df, by = c("SCHOOLID"))
