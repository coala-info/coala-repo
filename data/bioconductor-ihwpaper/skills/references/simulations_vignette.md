# Simulation Results

Nikos Ignatiadis

#### 4 November 2025

#### Package

IHWpaper 1.38.0

# Contents

* [1 Panels a,b](#panels-ab)
  + [1.1 Data for panels a,b](#data-for-panels-ab)
  + [1.2 Panel a)](#panel-a)
  + [1.3 Panel b)](#panel-b)
  + [1.4 Panels a, b)](#panels-a-b)
* [2 Panels c, d)](#panels-c-d)
  + [2.1 Data for panels c,d)](#data-for-panels-cd)
  + [2.2 Panel c)](#panel-c)
  + [2.3 Panel d)](#panel-d)
  + [2.4 Put panels c), d) together:](#put-panels-c-d-together)
* [3 Panels e),f)](#panels-ef)
  + [3.1 Load data for panels e),f)](#load-data-for-panels-ef)
  + [3.2 Panel e)](#panel-e)
  + [3.3 Panel f)](#panel-f)
  + [3.4 Combine main panels for size investing](#combine-main-panels-for-size-investing)
* [4 Combine everything into main text simulation figure](#combine-everything-into-main-text-simulation-figure)
* [5 New main fig sim. figures without borders:](#new-main-fig-sim.-figures-without-borders)
  + [5.1 Supplementary panel b)](#supplementary-panel-b)
  + [5.2 Combine supplementary effect size simulations](#combine-supplementary-effect-size-simulations)
* [6 Supplementary Size Investing](#supplementary-size-investing)
  + [6.1 Supplementary Panel c), FDR in size investing simulations](#supplementary-panel-c-fdr-in-size-investing-simulations)
  + [6.2 Supplementary Panel d), Power in size investing simulations](#supplementary-panel-d-power-in-size-investing-simulations)
  + [6.3 Combine supplemental size investing panels](#combine-supplemental-size-investing-panels)
* [7 Full supplementary simulations figure](#full-supplementary-simulations-figure)
  + [7.1 New supplementary simulations figure](#new-supplementary-simulations-figure)

```
library("ggplot2")
library("grid")
library("dplyr")
library("cowplot")
library("IHWpaper")
theme_set(theme_cowplot())
```

Some general preliminary work, define factors, colours, which methods should we consider conservative, which anticonservative.

```
methods_pretty <- c("BH", "Clfdr", "Greedy Indep. Filt.", "IHW", "IHW naive", "FDRreg", "LSL GBH", "SBH", "TST GBH")
colors <- scales::hue_pal(h = c(0, 360) + 15, c = 100, l = 65, h.start = 0,direction = 1)(10)

conservative_methods <- c("BH", "Clfdr", "IHW", "FDRreg", "LSL GBH")
conservative_idx <- match(conservative_methods, methods_pretty)

anticonservative_methods <- c("Greedy Indep. Filt.", "IHW naive", "SBH", "TST GBH")
anticonservative_idx     <- match(anticonservative_methods, methods_pretty)
```

# 1 Panels a,b

## 1.1 Data for panels a,b

```
null_grb_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_null_simulation_benchmark_grb.Rds", package = "IHWpaper")
null_e3_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_null_simulation_benchmark_E3.Rds", package = "IHWpaper")
null_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_null_simulation_benchmark.Rds", package = "IHWpaper")
null_df <- rbind(readRDS(null_grb_file),
                 readRDS(null_e3_file),
                 readRDS(null_file)) %>%
                 filter(fdr_method != "IHW") %>% # just show IHW with E1-E3
                 mutate(fdr_method = ifelse(fdr_method=="IHW E3", "IHW", fdr_method),
                           fdr_method = sapply(strsplit(fdr_method," 20"), "[",1),
                           fdr_method = factor(fdr_method, levels= methods_pretty))
```

## 1.2 Panel a)

```
panel_a_df <-  filter(null_df, fdr_method %in% anticonservative_methods)
last_vals_a <- group_by(panel_a_df, fdr_method) %>% summarize(last_vals = max(FDR)) %>%
               mutate(last_vals = last_vals + c(0, 0,0.05, -0.03),
                    label = fdr_method,
                    colour = colors[anticonservative_idx])

panel_a <- ggplot(panel_a_df, aes(x=alpha, y=FDR, col=fdr_method)) +
                         geom_line(size=1.2) +
                         geom_abline(linetype="dashed") +
                         xlab(expression(bold(paste("Nominal ",alpha)))) +
                         scale_x_continuous(limits= c(0.01,0.1), breaks=seq(0.01,0.09,length=5)) +
                         ylim(0,0.9) +
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[anticonservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_a <- pretty_legend(panel_a, last_vals_a, 0.102)
panel_a
```

![](data:image/png;base64...)

## 1.3 Panel b)

```
panel_b_df <- filter(null_df, fdr_method %in% conservative_methods)

last_vals_b <- group_by(panel_b_df, fdr_method) %>% summarize(last_vals = max(FDR)) %>%
             mutate(last_vals = last_vals +  c(0.005,0.005,-0.005, 0 ,-0.005 ),
                    label = fdr_method,
                    colour = colors[conservative_idx])

panel_b <- ggplot(panel_b_df, aes(x=alpha, y=FDR, col=fdr_method)) +
                         geom_abline(linetype="dashed") +
                         geom_line(size=1.2) +
                         xlab(expression(bold(paste("Nominal ",alpha)))) +
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[conservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_b <- pretty_legend(panel_b, last_vals_b, 0.102 )
panel_b
```

![](data:image/png;base64...)

## 1.4 Panels a, b)

```
panel_ab <- plot_grid(panel_a, panel_b, labels=c("a)","b)"), vjust=4.5)

panel_ab <- ggdraw(panel_ab) +
          geom_rect(aes(xmin=0,xmax=1,ymin=0,ymax=0.95),
                            color="black",alpha=0.0) +
          draw_label("Nulls only", x = 1, y = 1,
            vjust = 1, hjust = 1, size = 15, fontface = 'bold') +
          theme(plot.margin=unit(c(.2,.2,.2,.2),"cm"))

panel_ab

#ggsave(panel_ab, "null_all.pdf",width=11,height=5.5)
```

# 2 Panels c, d)

## 2.1 Data for panels c,d)

```
effsize_grb_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_du_ttest_inform_simulation_benchmark_grb.Rds", package = "IHWpaper")
effsize_e3_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_du_ttest_inform_simulation_benchmark_E3.Rds", package = "IHWpaper")
effsize_file <- system.file("simulation_benchmarks/result_files",
                         "ihw_du_ttest_inform_simulation_benchmark.Rds", package = "IHWpaper")
effsize_df <- rbind(readRDS(effsize_grb_file),
                    readRDS(effsize_file),
                    readRDS(effsize_e3_file)) %>%
              filter(fdr_method != "IHW") %>% # just show IHW with E1-E3
              mutate(fdr_method = ifelse(fdr_method=="IHW E3", "IHW", fdr_method),
                           fdr_method = sapply(strsplit(fdr_method," 20"), "[",1),
                           fdr_method = factor(fdr_method, levels= methods_pretty))
```

## 2.2 Panel c)

```
panel_c_df <- filter(effsize_df, fdr_method %in% conservative_methods)

last_vals_c <- group_by(panel_c_df, fdr_method) %>% summarize(last_vals =  FDR[which.max(eff_size)]) %>%
               mutate(last_vals = last_vals + c(0,0.005,-0.005, 0 ,-0.01 ),
                      label = fdr_method,
                      colour = colors[conservative_idx])

panel_c <- ggplot(panel_c_df, aes(x=eff_size, y=FDR, col=fdr_method)) +
                         geom_hline(yintercept=0.1, linetype="dashed") +
                         geom_line(size=1.2) +
                         xlab("Effect size") +
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[conservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_c <- pretty_legend(panel_c, last_vals_c, 2.52 )
panel_c
```

![](data:image/png;base64...)

## 2.3 Panel d)

```
panel_d_df <- filter(effsize_df, fdr_method %in% conservative_methods)

last_vals_d <- group_by(panel_d_df, fdr_method) %>% summarize(last_vals = power[which.max(eff_size)]) %>%
               mutate(last_vals = last_vals + c(0,-0.015,-0.035, 0.035 ,+0.005 ),
                      label = fdr_method,
                      colour = colors[conservative_idx])

panel_d <- ggplot(panel_c_df, aes(x=eff_size, y=power, col=fdr_method)) +
                         geom_line(size=1.2) +
                         xlab("Effect size") +
                         ylab("Power")+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[conservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_d <- pretty_legend(panel_d, last_vals_d, 2.52 )
panel_d
```

![](data:image/png;base64...)

## 2.4 Put panels c), d) together:

```
panel_cd <- plot_grid(panel_c, panel_d, labels=c("c)","d)"), vjust=4.5)

#ggsave(panel_cd, "t_test_full.pdf",width=11,height=5.5)
panel_cd <- ggdraw(panel_cd) +
          geom_rect(aes(xmin=0,xmax=1,ymin=0,ymax=0.95),
                            color="black",alpha=0.0) +
          draw_label("effect size", x = 1, y = 1,
            vjust = 1, hjust = 1, size = 15, fontface = 'bold') +
          theme(plot.margin=unit(c(.2,.2,.2,.2),"cm"))

panel_cd
```

# 3 Panels e),f)

## 3.1 Load data for panels e),f)

```
sizeinvesting_grb_file <- system.file("simulation_benchmarks/result_files",
                        "ihw_wasserman_normal_simulation_benchmark_grb.Rds", package = "IHWpaper")
sizeinvesting_e3_file <-  system.file("simulation_benchmarks/result_files",
                        "ihw_wasserman_normal_simulation_benchmark_E3.Rds", package = "IHWpaper")
sizeinvesting_file <- system.file("simulation_benchmarks/result_files",
                         "ihw_wasserman_normal_simulation_benchmark.Rds", package = "IHWpaper")
sizeinvesting_df <- bind_rows(lapply(c(sizeinvesting_file,
                                       sizeinvesting_e3_file,
                                       sizeinvesting_grb_file), readRDS)) %>%
                    filter(fdr_method != "IHW") %>% # just show IHW with E1-E3
                    # make names prettier and make sure we use same factor for everything
                    mutate(fdr_method = ifelse(fdr_method=="IHW E3", "IHW", fdr_method),
                           fdr_method = sapply(strsplit(fdr_method," 20"), "[",1),
                           fdr_method = factor(fdr_method, levels= methods_pretty)) %>%
                    # add log2 relative to BH
                    group_by(xi_max) %>%
                    mutate(normalized = log2(power/max(power*(fdr_method=="BH"))))
```

## 3.2 Panel e)

```
panel_e_df <- filter(sizeinvesting_df, fdr_method %in% conservative_methods)

last_vals_e <- group_by(panel_e_df, fdr_method) %>% summarize(last_vals = FDR[which.max(xi_max)]) %>%
               mutate(last_vals = last_vals + c(0.0009,0,-0.0009, 0 ,0 ),
                      label = fdr_method,
                      colour = colors[conservative_idx])

panel_e <- ggplot(panel_e_df, aes(x=xi_max, y=FDR, col=fdr_method)) +
                         geom_hline(yintercept=0.1, linetype="dashed") +
                         geom_line(size=1.2) +
                         xlab(expression(bold(xi[max])))+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[conservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_e <- pretty_legend(panel_e, last_vals_e, 6.02 )
panel_e
```

![](data:image/png;base64...)

## 3.3 Panel f)

```
panel_f_df <- filter(sizeinvesting_df, fdr_method %in% conservative_methods)

last_vals_f <- group_by(panel_f_df, fdr_method) %>% summarize(last_vals = normalized[which.max(xi_max)]) %>%
               mutate(last_vals = last_vals +  c(0, 0, 0, +0.008 ,-0.002 ),
                      label = fdr_method,
                      colour = colors[conservative_idx])

panel_f <- ggplot(panel_f_df, aes(x=xi_max, y=normalized, col=fdr_method)) +
                         geom_line(size=1.2) +
                         ylab(expression(bold(log[2](Power/Power[BH]))))+
                         xlab(expression(bold(xi[max])))+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[conservative_idx])+
                         theme(axis.title = element_text(face="bold") )

panel_f <- pretty_legend(panel_f, last_vals_f, 6.02 )
panel_f
```

![](data:image/png;base64...)

## 3.4 Combine main panels for size investing

```
panel_ef <- plot_grid(panel_e, panel_f, labels=c("e)","f)"), vjust=4.5)

#plot_grid(panel_c, panel_d)
#ggsave("t_test_full.pdf",width=11,height=5.5)
panel_ef <- ggdraw(panel_ef) +
          geom_rect(aes(xmin=0,xmax=1,ymin=0,ymax=0.95),
                            color="black",alpha=0.0) +
          draw_label("size investing", x = 1, y = 1,
            vjust = 1, hjust = 1, size = 15, fontface = 'bold') +
          theme(plot.margin=unit(c(.2,.2,.2,.2),"cm"))

panel_ef
```

# 4 Combine everything into main text simulation figure

```
main_sim_fig <- plot_grid(panel_ab,panel_cd, panel_ef, nrow=3)
main_sim_fig
```

```
ggsave(plot=main_sim_fig, file="main_simulations.pdf", width=12, height=16)
```

# 5 New main fig sim. figures without borders:

```
main_sim_fig <- plot_grid(panel_a,panel_b,
                          panel_c,panel_d,
                          panel_e, panel_f,
                          nrow=3,
                          labels= c("a)", "b)", "c)",
                              "d)","e)","f)"))

main_sim_fig
```

```
ggsave(plot=main_sim_fig, file="main_simulations.pdf", width=12, height=16)
```

```
# Supplementary Effect Size Simulation

## Supplementary panel a)
```

```
sup_panel_a_df <- filter(effsize_df, fdr_method %in% anticonservative_methods)

sup_last_vals_a <- group_by(sup_panel_a_df, fdr_method) %>%
                   summarize(last_vals =  FDR[which.max(eff_size)]) %>%
                   mutate(last_vals = last_vals + c(-0.001 ,+0.011,0, -0.003 ),
                      label = fdr_method,
                      colour = colors[anticonservative_idx])

sup_panel_a <- ggplot(sup_panel_a_df, aes(x=eff_size, y=FDR, col=fdr_method)) +
                         geom_hline(yintercept=0.1, linetype="dashed") +
                         geom_line(size=1.2) +
                         xlab("Effect size") +
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[anticonservative_idx])+
                         theme(axis.title = element_text(face="bold") )

sup_panel_a <- pretty_legend(sup_panel_a, sup_last_vals_a, 2.52 )
sup_panel_a
```

![](data:image/png;base64...)

## 5.1 Supplementary panel b)

```
sup_panel_b_df <- filter(effsize_df, fdr_method %in% anticonservative_methods)

sup_last_vals_b <- group_by(sup_panel_b_df, fdr_method) %>%
                   summarize(last_vals = power[which.max(eff_size)]) %>%
                   mutate(last_vals = last_vals + c(+0.015,+0.03,-0.03, -0.015 ),
                      label = fdr_method,
                      colour = colors[anticonservative_idx])

sup_panel_b <- ggplot(sup_panel_b_df, aes(x=eff_size, y=power, col=fdr_method)) +
                         geom_line(size=1.2) +
                         xlab("Effect size") +
                         ylab("Power")+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[anticonservative_idx])+
                         theme(axis.title = element_text(face="bold") )

sup_panel_b <- pretty_legend(sup_panel_b, sup_last_vals_b, 2.52 )
sup_panel_b
```

![](data:image/png;base64...)

## 5.2 Combine supplementary effect size simulations

```
sup_panel_ab<- plot_grid(sup_panel_a, sup_panel_b, labels=c("a)","b)"), vjust=4.5)

sup_panel_ab <- ggdraw(sup_panel_ab) +
          geom_rect(aes(xmin=0,xmax=1,ymin=0,ymax=0.95),
                            color="black",alpha=0.0) +
          draw_label("effect size", x = 1, y = 1,
            vjust = 1, hjust = 1, size = 15, fontface = 'bold') +
          theme(plot.margin=unit(c(.2,.2,.2,.2),"cm"))

sup_panel_ab
```

# 6 Supplementary Size Investing

## 6.1 Supplementary Panel c), FDR in size investing simulations

```
sup_panel_c_df <- filter(sizeinvesting_df, fdr_method %in% anticonservative_methods)

sup_last_vals_c <- group_by(sup_panel_c_df, fdr_method) %>%
                   summarize(last_vals = FDR[which.max(xi_max)]) %>%
                   mutate(last_vals = last_vals +  c(0.00005,0, 0.001,-0.001),
                      label = fdr_method,
                      colour = colors[anticonservative_idx])

sup_panel_c <- ggplot(sup_panel_c_df, aes(x=xi_max, y=FDR, col=fdr_method)) +
                         geom_hline(yintercept=0.1, linetype="dashed") +
                         geom_line(size=1.2) +
                         xlim(3,6)+
                         xlab(expression(bold(xi[max])))+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[anticonservative_idx])+
                         theme(axis.title = element_text(face="bold") )

sup_panel_c <- pretty_legend(sup_panel_c, sup_last_vals_c, 6.02 )
sup_panel_c
```

![](data:image/png;base64...)

## 6.2 Supplementary Panel d), Power in size investing simulations

```
sup_panel_d_df <- filter(sizeinvesting_df, fdr_method %in% anticonservative_methods)

sup_last_vals_d <- group_by(sup_panel_d_df, fdr_method) %>%
                  summarize(last_vals = normalized[which.max(xi_max)]) %>%
                  mutate(last_vals = last_vals + c(0.00,0.0, +0.005, -0.005),
                      label = fdr_method,
                      colour = colors[anticonservative_idx])

sup_panel_d <- ggplot(sup_panel_d_df, aes(x=xi_max, y=normalized, col=fdr_method)) +
                         geom_line(size=1.2) +
                         ylab(expression(bold(log[2](Power/Power[BH]))))+
                         xlab(expression(bold(xi[max])))+
                         xlim(3,6)+
                         ylim(-0.1,+0.3)+
                         theme(plot.margin = unit(c(3, 7.5, .2, .2), "lines"))+
                         scale_color_manual(values=colors[anticonservative_idx])+
                         theme(axis.title = element_text(face="bold") )

sup_panel_d <- pretty_legend(sup_panel_d, sup_last_vals_d, 6.02 )
sup_panel_d
```

![](data:image/png;base64...)

## 6.3 Combine supplemental size investing panels

```
sup_panel_cd <- plot_grid(sup_panel_c, sup_panel_d, labels=c("c)","d)"), vjust=4.5)

#plot_grid(panel_c, panel_d)
#ggsave("t_test_full.pdf",width=11,height=5.5)
sup_panel_cd <- ggdraw(sup_panel_cd) +
          geom_rect(aes(xmin=0,xmax=1,ymin=0,ymax=0.95),
                            color="black",alpha=0.0) +
          draw_label("size investing", x = 1, y = 1,
            vjust = 1, hjust = 1, size = 15, fontface = 'bold') +
          theme(plot.margin=unit(c(.2,.2,.2,.2),"cm"))

sup_panel_cd
```

# 7 Full supplementary simulations figure

```
sup_sim_fig <- plot_grid(sup_panel_ab,sup_panel_cd, nrow=2)
sup_sim_fig
```

```
cowplot::ggsave(plot=sup_sim_fig, file="suppl_simulations.pdf", width=12, height=12)
```

## 7.1 New supplementary simulations figure

```
sup_sim_fig <- plot_grid(sup_panel_a,sup_panel_b,
                          sup_panel_c,sup_panel_d,
                          nrow=2,
                          labels= c("a)", "b)", "c)",
                              "d)"))
  sup_sim_fig
```

```
cowplot::ggsave(plot=sup_sim_fig, file="suppl_simulations.pdf", width=12, height=12)
```