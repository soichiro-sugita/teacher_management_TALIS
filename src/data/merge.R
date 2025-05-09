# merge tables

# --- 有効サンプルだけ抽出 ---
# 教員データのフィルタ＆変数選択 --------------------
teacher_df_a <- teacher_a %>%
  filter(INTAL18 == 1) %>%
  select_var_teacher()

teacher_df_b <- teacher_b %>%
  filter(INTAL18 == 1) %>%
  select_var_teacher()


# 校長データのフィルタ＆変数選択 --------------------
# principal_df_a, principal_df_b　-> summary stat
principal_df_a <- principal_a %>%
  filter(INTAL18 == 1) %>%
  select_var_principal() %>% 
  clean_principal_data()

principal_df_b <- principal_b %>%
  filter(INTAL18 == 1) %>%
  select_var_principal() %>% 
  clean_principal_data()


# --- 教員データに校長データを学校ID単位で結合 ---
merged_df_a <- teacher_df_a %>%
  dplyr::left_join(principal_df_a,
                   by = c("IDSCHOOL")
  )

merged_df_b <- teacher_df_b %>% 
  dplyr::left_join(principal_df_b,
                   by = c("IDSCHOOL")
  )