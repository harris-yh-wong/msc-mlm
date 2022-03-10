
count_cat_features <- function(df, var, group_by) {
    counts <-
        df %>% 
        group_by(.data[[all_of(group_by)]]) %>% 
        count(.data[[var]]) %>% 
        rename(level = .data[[var]]) %>% 
        ungroup()
    return(counts)
}


summarise_num_features <- function(df, var, group_by, fun_list) {
    summary_stats_by_group <- df %>% 
        group_by(.data[[all_of(group_by)]]) %>% 
        summarise(across(
            .cols = c(var), # only use one variable
            fun_list,
            .names="{.fn}" # suppress variable name
        ))
    
    # repeat without group_by
    summary_stats_grouped <- df %>% 
        summarise(across(
            .cols = c(var),
            fun_list,
            .names="{.fn}"
        )) %>% 
        mutate("{group_by}" := "Total")
    
    out <- bind_rows(summary_stats_by_group, summary_stats_grouped)
    return(out)
}


generate_table_1 <- function(df, cat_features, num_features, group_by, fun_list_categorical) {
    
    cat_counts <- cat_features %>%
        setNames(nm=.) %>% 
        map(count_cat_features, df=df, group_by=group_by) %>% 
        bind_rows(.id='variable') %>% 
        pivot_wider(names_from = group_by, values_from = n) %>% 
        # replace NAs with zeros
        mutate(across(.cols=-c(variable, level), ~replace_na(.x, 0))) %>% 
        mutate(Total = rowSums(across(.cols=-c(variable, level))))
    
    num_summaries <- num_features %>%
        setNames(nm=.) %>% 
        map(summarise_num_features, df=df, group_by=group_by, fun_list=fun_list_categorical) %>% 
        bind_rows(.id='variable') %>% 
        pivot_wider(names_from = group_by, values_from = -c(variable, all_of(group_by)))
    
    
    out <- bind_rows(
        cat_counts %>% mutate(across(everything(), as.character)), 
        num_summaries %>% mutate(level = "") %>% mutate(across(everything(), as.character))
    ) %>% 
        select(-variable, everything())
    
    return(out)
}
