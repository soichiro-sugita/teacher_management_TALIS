# function:select variavles from teacher data

# select variables : teacher
select_var_teacher <- function(dfx){
  df <- dfx %>% 
    dplyr::select(TPART,
                  MODEA_TcQ,
                  TALIS13POP,
                  TALIS08POP,
                  CNTRY, IDCNTRY, IDTEACH, IDSCHOOL, IDCNTRY, IDPOP, IDCNTPOP, # 識別変数
                  INTAL18,                           # 標本代表性（有効サンプル=1）
                  
                  # teacher demographics
                  TT3G01,    # 性別
                  
                  TCHAGEGR,  # 年齢区分
                  TT3G03,    # 最終学歴（ISCED）
                  TT3G04,    # 教員免許の取得形態
                  TT3G05,    # 教員資格取得年
                  TT3G11A,   # 現職校での勤務年数
                  TT3G11B,   # 教員としての通算勤務年数
                  TT3G11C,   # 現学年での担当年数
                  TT3G12,    # 常勤／非常勤
                  TT3G13,    # 管理職経験の有無
                  
                  
                  # teacher self efficacy
                  T3SECLS,
                  T3SEINS,
                  T3SEENG,
                  T3SEFE,
                  
                  # teacher job satisfaction
                  T3JOBSA,
                  T3JSENV,
                  T3JSPRO,
                  
                  # teacher autonomy
                  TT3G40A,
                  TT3G40B,
                  TT3G40C,
                  TT3G40D,
                  
                  # teacher worktime
                  TT3G16,  # total
                  TT3G17, 
                  TT3G18A, 
                  TT3G18B, 
                  TT3G18C, 
                  TT3G18D, 
                  TT3G18E,
                  TT3G18F, 
                  TT3G18G, 
                  TT3G18H, 
                  TT3G18I,
                  TT3G18J
                  )
  return(df)
}


# select variables : principal
select_var_principal <- function(dfx){
  df <- dfx %>% 
    dplyr::select(IDSCHOOL,          # 識別変数
                  INTAL18,                           # 標本代表性（有効サンプル=1）
                  
                  # principal demographics
                  TC3G01,                            # 性別
                  # TC3G02,                            # 年齢（連続値）
                  PRAGEGR,                           # 年齢区分
                  TC3G03,                            # 最終学歴（ISCED準拠）
                  TC3G04A,                           # 現職校での校長経験年数
                  
                  TC3G04C,                           # 管理職経験年数
                  TC3G04D, TC3G04E,                  # 教員および他職種経験年数
                  TC3G05,                            # 雇用形態
                  TC3G06A, TC3G06B, TC3G06C,         # 校長研修、教員養成、リーダーシップ研修
                  
                  # principal autonomy
                  T3PAUTS, # 人員配置
                  
                  T3PAUTP, # 教育方針の決定
                  T3PAUTI, # 授業方針
                  T3PAUTC, # カリキュラム
                  
                  # principal leadership management
                  T3PCOM,  # ステークホルダー
                  T3PDELI, # 秩序維持
                  T3PACAD, # 学業成績
                  
                  # # principal leadership management questions
                  # TC3G06A, TC3G06B, TC3G06C,
                  # TC3G18, 
                  # TC3G19A, TC3G19B, TC3G19C, TC3G19D, TC3G19E, TC3G19F, TC3G19G, TC3G19H,
                  
                  # principal time allocation
                  TC3G21A, # management
                  TC3G21B, # leadership activity
                  TC3G21C  # curriculum
                  )
  
}





# cleaning ---------------------------------

clean_data <- function(dfx){
  merged_df_clean <- dfx %>%
    dplyr::select(-ends_with("_z") # 校長テーブルの標準化変数を落とす
                  ) %>% 
    dplyr::mutate(
      # 教員性別ダミー（1 = 女性）
      female_teacher = if_else(TT3G01 == 1,
                               1,
                               0),
      
      # 教員学歴ダミー（1 = 修士以上）
      grad_school_teacher = if_else(TT3G03 >= 7,
                                    1,
                                    0),
      
      # 教員常勤ダミー（1 = 常勤）
      fulltime_teacher = if_else(TT3G12 == 1,
                                 1,
                                 0),
      
      # 教員管理職経験ダミー（1 = あり）
      has_admin_exp_teacher = if_else(TT3G13 == 1,
                                      1,
                                      0),
      
      # 校長性別ダミー（1 = 女性）
      female_principal = if_else(TC3G01 == 1,
                                 1,
                                 0),
      
      # 校長学歴ダミー（1 = 修士以上）
      grad_school_principal = if_else(TC3G03 >= 7,
                                      1,
                                      0),
      
      # 校長常勤ダミー（1 = 常勤）
      fulltime_principal = if_else(TC3G05 == 1,
                                   1,
                                   0)
     
    ) %>% 
    # na.omit() %>% 
    # Z標準化(結合したテーブル(分析対象サンプル)に対して標準化する)
    dplyr::mutate(across(
      .cols = c(
        exp_mgmt_principal,
        #exp_total_principal,
        exp_admin_principal,
        exp_teach_principal,
        exp_other_principal,
        training_principal,
        training_teacher,
        training_leader
        ),
      .fns = ~ as.numeric(scale(.x)[, 1]),
      .names = "{.col}_z"
      )
      )
  
  # 変数の並び替え ---------------------------
  id_vars <- c("IDTEACH", 
               "IDSCHOOL"
               )
  
  renamed_vars <- c("female_teacher",
                    "grad_school_teacher",
                    "fulltime_teacher",
                    "has_admin_exp_teacher",
                    "female_principal", 
                    "grad_school_principal",
                    "fulltime_principal"
                    )
  
  t_vars <- names(merged_df_clean)[grepl("^T",
                                  names(merged_df_clean
                                        )
                                  )
                            ]
  
  # 順番に並べ替え
  merged_df_clean <- merged_df_clean %>%
    select(all_of(id_vars), 
           all_of(renamed_vars), 
           all_of(t_vars), 
           everything()
           )
  
  return(merged_df_clean)
}





# 校長データ(principal data)のクリーニング -------------
# 変数選択後

clean_principal_data <- function(dfx){
  df_cleaned <- dfx %>% 
    dplyr::mutate(
      # 校長性別ダミー（1 = 女性）
      female_principal = if_else(TC3G01 == 1,
                                 1,
                                 0),
      
      # 校長学歴ダミー（1 = 修士以上）
      grad_school_principal = if_else(TC3G03 >= 7,
                                      1,
                                      0),
      
      # 校長常勤ダミー（1 = 常勤）
      fulltime_principal = if_else(TC3G05 == 1,
                                   1,
                                   0),
      ) %>%
    
    # rename
    dplyr::rename(
      age_group_principal   = PRAGEGR,
      exp_mgmt_principal    = TC3G04A,
      #exp_total_principal   = TC3G04B,
      exp_admin_principal   = TC3G04C,
      exp_teach_principal   = TC3G04D,
      exp_other_principal   = TC3G04E,
      training_principal    = TC3G06A,
      training_teacher      = TC3G06B,
      training_leader       = TC3G06C
    ) %>%
    
    # Z標準化
    mutate(across(
      .cols = c(
        exp_mgmt_principal,
        #exp_total_principal,
        exp_admin_principal,
        exp_teach_principal,
        exp_other_principal,
        training_principal,
        training_teacher,
        training_leader
      ),
      .fns = ~ as.numeric(scale(.x)[, 1]),
      .names = "{.col}_z"
      )
    )
  
  # 変数の分類（並び替えのため）
  id_vars <- c("IDSCHOOL")
  dummy_vars <- c("female_principal",
                  "grad_school_principal",
                  "fulltime_principal")
  z_vars <- grep("_z$", 
                 names(df_cleaned),
                 value = TRUE)
  remaining_vars <- setdiff(names(df_cleaned), 
                            c(id_vars,
                              dummy_vars,
                              z_vars)
                            )
  # 並び替え
  df_cleaned <- df_cleaned %>%
    select(all_of(id_vars), 
           all_of(dummy_vars), 
           all_of(z_vars), 
           all_of(remaining_vars))
  
  return(df_cleaned)
}
