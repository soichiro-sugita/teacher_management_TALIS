# function: descriptive analysis

# summary stat(overall) -------------------------
summarise_descriptive_stats <- function(df,
                                        exclude_prefix = c("ID", 
                                                           "TT",
                                                           "TC",
                                                           "IN", 
                                                           "MODEA"))
  {
  
  # 分析対象変数
  desc_vars <- df %>%
    select(-matches(paste0("^(", 
                           paste(exclude_prefix, 
                                 collapse = "|"), 
                           ")")
                    )
           ) %>%
    select(where(is.numeric)) %>%
    names()
  
  df %>%
    select(all_of(desc_vars)) %>%
    summarise(across(
      everything(),
      list(
        mean = ~mean(., na.rm = TRUE),
        sd   = ~sd(., na.rm = TRUE),
        min  = ~min(., na.rm = TRUE),
        max  = ~max(., na.rm = TRUE),
        n    = ~sum(!is.na(.))
      ),
      .names = "{.col}_{.fn}"
    )) %>%
    pivot_longer(cols = everything(),
                 names_to = c("variable",
                              "stat"
                              ),
                 names_sep = "_",
                 values_to = "value") %>%
    pivot_wider(names_from = stat,
                values_from = value)
}


# summary stat(for principal table)) ---------------------------------------


# summary stat(by group) ---------------------------------------
analyze_by_group <- function(df, 
                             group_var,
                             exclude_prefix = c("ID",
                                                "TT",
                                                "TC",
                                                "IN", 
                                                "MODEA")) 
  {
  group_var <- rlang::ensym(group_var)
  
  # 分析対象変数
  desc_vars <- df %>%
    select(-matches(paste0("^(", paste(exclude_prefix, collapse = "|"), ")"))) %>%
    select(where(is.numeric)) %>%
    names()
  
  # グループ別統計量
  group_summary <- df %>%
    filter(!is.na(!!group_var)) %>%
    group_by(!!group_var) %>%
    summarise(across(
      all_of(desc_vars),
      list(
        mean = ~mean(.x, na.rm = TRUE),
        sd   = ~sd(.x, na.rm = TRUE),
        n    = ~sum(!is.na(.x))
      ),
      .names = "{.col}_{.fn}"
    ), .groups = "drop")
  
  # t検定
  t_test_results <- purrr::map_dfr(desc_vars, function(var) {
    formula <- as.formula(paste0(var, " ~ ", rlang::as_string(group_var)))
    res <- t.test(formula, data = df)
    broom::tidy(res) %>% mutate(variable = var)
  })
  
  # 可視化（箱ひげ図）
  p <- df %>%
    filter(!is.na(!!group_var)) %>%
    select(!!group_var, all_of(desc_vars)) %>%
    pivot_longer(-!!group_var, names_to = "variable",
                 values_to = "value") %>%
    ggplot(aes(x = factor(!!group_var), y = value)) +
    geom_boxplot(fill = "lightblue") +
    facet_wrap(~ variable, scales = "free", ncol = 3) +
    labs(x = rlang::as_string(group_var), y = "Value", title = paste("Boxplots by", rlang::as_string(group_var)))
  
  list(summary = group_summary,
       t_test = t_test_results,
       plot = p)
}
