# rifiComparative

Loubna Youssar

#### 2025-10-30

## 0. Installation

Required dependencies are cited on README, please make sure they are properly
installed (README).
All functions should be located on the same folder and add them to your
path directory.

## I. Introduction

rifiComparative is a successor framework of *[rifi](https://bioconductor.org/packages/3.22/rifi)*
*(<https://github.com/CyanolabFreiburg/rifi>)*. Generated outputs from the same
organism with different treatments could be compared. Trying to combine segments
of the same gene from different conditions is not straight forward and makes the
data analysis nearly impossible. Therefore we developed a new workflow,
rifiComparative, with an easy strategy to make 2 conditions comparable.
The principle of rifiComparative consists on segmenting the half-life
(difference between half-life (condition1) and half-life (condition2)
at probe/bin level) and segmenting intensity using the log2FC(mRNA at time 0).
The workflow does not apply any hierarchy. Half-life (in some cases, HL) and
intensity segmentation are independent.
The fragments result of clustering from half-life and intensity are compared using
log2FC(log2FC(half-life)/log2FC(intensity)). These values are a pre-analysis for
transcription and post-transcription regulation. Events for each treatment are
depicted with the position on the genome (For more detail, refer to section visualization).
P-values from statistical tests are estimated. rifiComparative generates data frame summary, genome plot and several figures (refer to section Plots for more details).

## II. Workflow

### 1. Joining data

The first step is combining the data from two conditions. The data are combined
by row on one hand and combined by column on the other hand. Both objects are
saved and used as input for the next analysis.

The functions used are:

`loading_fun`: you need to load either `rifi_fit` or `rifi_stats` outputs from
each condition and place all in one directory. `rifi_fit` is sufficient to run the
workflow unless if you want to select more column from `rifi_stats` for more
analysis or plot. The “cdt” is added referring to the sample condition.

Very important:  you will need to run the
differential expression at probe/bin level. This is the log2FC(intensity) or
log2FC(mRNA at time 0). Pick-up the logFC, the p\_value adjusted, probe position
and strand columns. Save the first two as `logFC_int` and `P.Value`. You can use either `left_join` or `right_join` from the *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*
package to join both data by strand and position.

```
data(stats_se_cdt1)
data(stats_se_cdt2)
data(differential_expression)
inp_s <-
    loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[1]]
head(inp_s, 5)
```

```
##   strand position ID FLT intensity probe_TI flag position_segment     delay
## 1      +       67  1   0  1367.080       -1    _              S_1 1.4190839
## 2      +      153  2   0  3316.336       -1    _              S_1 1.9343216
## 3      +      199  3   0  1112.101       -1    _              S_1 0.6442441
## 4      +      259  4   0  2012.294        1    _              S_1 0.0010000
## 5      +      320  5   0  1627.467       -1    _              S_1 1.9506707
##    half_life TI_termination_factor delay_fragment velocity_fragment intercept
## 1 0.63658399                    NA            D_1          5381.643  1.707418
## 2 0.07033786                    NA            D_1          5381.643  1.707418
## 3 1.23339859                    NA          D_1_O          5381.643  1.707418
## 4 0.05594761                    NA          D_1_O          5381.643  1.707418
## 5 0.07012892                    NA            D_1          5381.643  1.707418
##          slope HL_fragment HL_mean_fragment intensity_fragment
## 1 0.0001858169        Dc_1        0.4851184                I_1
## 2 0.0001858169        Dc_1        0.4851184                I_1
## 3 0.0001858169        Dc_1        0.4851184                I_1
## 4 0.0001858169        Dc_1        0.4851184                I_1
## 5 0.0001858169        Dc_1        0.4851184                I_1
##   intensity_mean_fragment   TU TI_termination_fragment
## 1                1467.208 TU_1                    <NA>
## 2                1467.208 TU_1                    <NA>
## 3                1467.208 TU_1                    <NA>
## 4                1467.208 TU_1                    <NA>
## 5                1467.208 TU_1                    <NA>
##   TI_mean_termination_factor                seg_ID pausing_site iTSS_I
## 1                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 2                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 3                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 4                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 5                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
##   ps_ts_fragment event_duration event_ps_itss_p_value_Ttest p_value_slope
## 1           <NA>             NA                          NA            NA
## 2           <NA>             NA                          NA            NA
## 3           <NA>             NA                          NA            NA
## 4           <NA>             NA                          NA            NA
## 5           <NA>             NA                          NA            NA
##   delay_frg_slope velocity_ratio event_position FC_fragment_HL FC_HL p_value_HL
## 1            <NA>             NA             NA           <NA>    NA         NA
## 2            <NA>             NA             NA           <NA>    NA         NA
## 3            <NA>             NA             NA           <NA>    NA         NA
## 4            <NA>             NA             NA           <NA>    NA         NA
## 5            <NA>             NA             NA           <NA>    NA         NA
##   FC_fragment_intensity FC_intensity p_value_intensity FC_HL_intensity
## 1                  <NA>           NA                NA              NA
## 2                  <NA>           NA                NA              NA
## 3                  <NA>           NA                NA              NA
## 4                  <NA>           NA                NA              NA
## 5                  <NA>           NA                NA              NA
##   FC_HL_intensity_fragment FC_HL_adapted synthesis_ratio synthesis_ratio_event
## 1                     <NA>            NA              NA                  <NA>
## 2                     <NA>            NA              NA                  <NA>
## 3                     <NA>            NA              NA                  <NA>
## 4                     <NA>            NA              NA                  <NA>
## 5                     <NA>            NA              NA                  <NA>
##   p_value_Manova p_value_TI TI_fragments_p_value  cdt   logFC_int     P.Value
## 1             NA         NA                 <NA> cdt1 -0.20137817 0.033395012
## 2             NA         NA                 <NA> cdt1  0.07306854 0.674892028
## 3             NA         NA                 <NA> cdt1 -0.04264460 0.512469947
## 4             NA         NA                 <NA> cdt1 -0.37075316 0.002843646
## 5             NA         NA                 <NA> cdt1 -0.14561154 0.280129057
```

```
inp_f <-
    loading_fun(stats_se_cdt1, stats_se_cdt2, differential_expression)[[2]]
head(inp_f, 5)
```

```
##   strand position ID FLT intensity probe_TI  flag position_segment       delay
## 1      +       67  1   0  1885.621       -1     _              S_1   1.8146852
## 2      +      153  2   0  4311.070        1     _              S_1   7.0634447
## 3      +      199  3   0  1285.397       -1     _              S_1   0.7950453
## 4      +      259  4   0  3393.836        1 _ABG_              S_1 126.7149209
## 5      +      320  5   0  2245.636       -1     _              S_1   1.4386446
##     half_life TI_termination_factor delay_fragment velocity_fragment intercept
## 1  0.08018944                    NA            D_1               Inf  1.794761
## 2  0.29227109                    NA            D_1               Inf  1.794761
## 3  0.77429388                    NA            D_1               Inf  1.794761
## 4 23.34891958                    NA          D_1_O               Inf  1.794761
## 5  0.41681710                    NA            D_1               Inf  1.794761
##   slope HL_fragment HL_mean_fragment intensity_fragment intensity_mean_fragment
## 1     0        Dc_1        0.3598576                I_1                2371.559
## 2     0        Dc_1        0.3598576                I_1                2371.559
## 3     0        Dc_1        0.3598576                I_1                2371.559
## 4     0      Dc_1_O        0.3598576                I_1                2371.559
## 5     0        Dc_1        0.3598576                I_1                2371.559
##     TU TI_termination_fragment TI_mean_termination_factor                seg_ID
## 1 TU_1                    <NA>                         NA S_1|TU_1|D_1|Dc_1|I_1
## 2 TU_1                    <NA>                         NA S_1|TU_1|D_1|Dc_1|I_1
## 3 TU_1                    <NA>                         NA S_1|TU_1|D_1|Dc_1|I_1
## 4 TU_1                    <NA>                         NA S_1|TU_1|D_1|Dc_1|I_1
## 5 TU_1                    <NA>                         NA S_1|TU_1|D_1|Dc_1|I_1
##   pausing_site iTSS_I ps_ts_fragment event_duration event_ps_itss_p_value_Ttest
## 1            -      -           <NA>             NA                          NA
## 2            -      -           <NA>             NA                          NA
## 3            -      -           <NA>             NA                          NA
## 4            -      -           <NA>             NA                          NA
## 5            -      -           <NA>             NA                          NA
##   p_value_slope delay_frg_slope velocity_ratio event_position FC_fragment_HL
## 1            NA            <NA>             NA             NA           <NA>
## 2            NA            <NA>             NA             NA           <NA>
## 3            NA            <NA>             NA             NA           <NA>
## 4            NA            <NA>             NA             NA           <NA>
## 5            NA            <NA>             NA             NA           <NA>
##   FC_HL p_value_HL FC_fragment_intensity FC_intensity p_value_intensity
## 1    NA         NA               I_1:I_2   -0.7701639        0.04602176
## 2    NA         NA               I_1:I_2   -0.7701639        0.04602176
## 3    NA         NA               I_1:I_2   -0.7701639        0.04602176
## 4    NA         NA               I_1:I_2   -0.7701639        0.04602176
## 5    NA         NA               I_1:I_2   -0.7701639        0.04602176
##   FC_HL_intensity FC_HL_intensity_fragment FC_HL_adapted synthesis_ratio
## 1              NA        Dc_1:Dc_1;I_1:I_2    -0.7410098       -0.034867
## 2              NA        Dc_1:Dc_1;I_1:I_2    -0.7410098       -0.034867
## 3              NA        Dc_1:Dc_1;I_1:I_2    -0.7410098       -0.034867
## 4              NA        Dc_1:Dc_1;I_1:I_2    -0.7410098       -0.034867
## 5              NA        Dc_1:Dc_1;I_1:I_2    -0.7410098       -0.034867
##   synthesis_ratio_event p_value_Manova p_value_TI TI_fragments_p_value  cdt
## 1           Termination      0.1569589         NA                 <NA> cdt2
## 2           Termination      0.1569589         NA                 <NA> cdt2
## 3           Termination      0.1569589         NA                 <NA> cdt2
## 4           Termination      0.1569589         NA                 <NA> cdt2
## 5           Termination      0.1569589         NA                 <NA> cdt2
##     logFC_int     P.Value
## 1 -0.20137817 0.033395012
## 2  0.07306854 0.674892028
## 3 -0.04264460 0.512469947
## 4 -0.37075316 0.002843646
## 5 -0.14561154 0.280129057
```

`joining_data_row`: contains `joining_data_row` function. It gathers data frame
from both conditions in one by rows. The object is called data\_combined\_se.rda

```
data(inp_s)
data(inp_f)
data_combined_minimal <-
joining_data_row(input1 = inp_s, input2 = inp_f)
head(data_combined_minimal, 5)
```

```
##   strand position ID FLT intensity probe_TI flag position_segment     delay
## 1      +       67  1   0  1367.080       -1    _              S_1 1.4190839
## 2      +      153  2   0  3316.336       -1    _              S_1 1.9343216
## 3      +      199  3   0  1112.101       -1    _              S_1 0.6442441
## 4      +      259  4   0  2012.294        1    _              S_1 0.0010000
## 5      +      320  5   0  1627.467       -1    _              S_1 1.9506707
##    half_life TI_termination_factor delay_fragment velocity_fragment intercept
## 1 0.63658399                    NA            D_1          5381.643  1.707418
## 2 0.07033786                    NA            D_1          5381.643  1.707418
## 3 1.23339859                    NA          D_1_O          5381.643  1.707418
## 4 0.05594761                    NA          D_1_O          5381.643  1.707418
## 5 0.07012892                    NA            D_1          5381.643  1.707418
##          slope HL_fragment HL_mean_fragment intensity_fragment
## 1 0.0001858169        Dc_1        0.4851184                I_1
## 2 0.0001858169        Dc_1        0.4851184                I_1
## 3 0.0001858169        Dc_1        0.4851184                I_1
## 4 0.0001858169        Dc_1        0.4851184                I_1
## 5 0.0001858169        Dc_1        0.4851184                I_1
##   intensity_mean_fragment   TU TI_termination_fragment
## 1                1467.208 TU_1                    <NA>
## 2                1467.208 TU_1                    <NA>
## 3                1467.208 TU_1                    <NA>
## 4                1467.208 TU_1                    <NA>
## 5                1467.208 TU_1                    <NA>
##   TI_mean_termination_factor                seg_ID pausing_site iTSS_I
## 1                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 2                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 3                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 4                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
## 5                         NA S_1|TU_1|D_1|Dc_1|I_1            -      -
##   ps_ts_fragment event_duration event_ps_itss_p_value_Ttest p_value_slope
## 1           <NA>             NA                          NA            NA
## 2           <NA>             NA                          NA            NA
## 3           <NA>             NA                          NA            NA
## 4           <NA>             NA                          NA            NA
## 5           <NA>             NA                          NA            NA
##   delay_frg_slope velocity_ratio event_position FC_fragment_HL FC_HL p_value_HL
## 1            <NA>             NA             NA           <NA>    NA         NA
## 2            <NA>             NA             NA           <NA>    NA         NA
## 3            <NA>             NA             NA           <NA>    NA         NA
## 4            <NA>             NA             NA           <NA>    NA         NA
## 5            <NA>             NA             NA           <NA>    NA         NA
##   FC_fragment_intensity FC_intensity p_value_intensity FC_HL_intensity
## 1                  <NA>           NA                NA              NA
## 2                  <NA>           NA                NA              NA
## 3                  <NA>           NA                NA              NA
## 4                  <NA>           NA                NA              NA
## 5                  <NA>           NA                NA              NA
##   FC_HL_intensity_fragment FC_HL_adapted synthesis_ratio synthesis_ratio_event
## 1                     <NA>            NA              NA                  <NA>
## 2                     <NA>            NA              NA                  <NA>
## 3                     <NA>            NA              NA                  <NA>
## 4                     <NA>            NA              NA                  <NA>
## 5                     <NA>            NA              NA                  <NA>
##   p_value_Manova p_value_TI TI_fragments_p_value  cdt   logFC_int     P.Value
## 1             NA         NA                 <NA> cdt1 -0.20137817 0.033395012
## 2             NA         NA                 <NA> cdt1  0.07306854 0.674892028
## 3             NA         NA                 <NA> cdt1 -0.04264460 0.512469947
## 4             NA         NA                 <NA> cdt1 -0.37075316 0.002843646
## 5             NA         NA                 <NA> cdt1 -0.14561154 0.280129057
```

`joining_data_column`: contains `joining_data_column` function. It gathers
data frame from both conditions in one by columns. The object is called
df\_comb\_se.rda

```
data(data_combined_minimal)
df_comb_minimal <- joining_data_column(data = data_combined_minimal)
head(df_comb_minimal, 5)
```

```
##   strand position ID intensity.cdt1 position_segment half_life.cdt1
## 1      +       67  1       1367.080              S_1     0.63658399
## 2      +      153  2       3316.336              S_1     0.07033786
## 3      +      199  3       1112.101              S_1     1.23339859
## 4      +      259  4       2012.294              S_1     0.05594761
## 5      +      320  5       1627.467              S_1     0.07012892
##   TI_termination_factor.cdt1 HL_fragment.cdt1 intensity_fragment.cdt1
## 1                         NA             Dc_1                     I_1
## 2                         NA             Dc_1                     I_1
## 3                         NA             Dc_1                     I_1
## 4                         NA             Dc_1                     I_1
## 5                         NA             Dc_1                     I_1
##   TI_termination_fragment.cdt1   logFC_int     P.Value intensity.cdt2
## 1                         <NA> -0.20137817 0.033395012       1885.621
## 2                         <NA>  0.07306854 0.674892028       4311.070
## 3                         <NA> -0.04264460 0.512469947       1285.397
## 4                         <NA> -0.37075316 0.002843646       3393.836
## 5                         <NA> -0.14561154 0.280129057       2245.636
##   half_life.cdt2 TI_termination_factor.cdt2 HL_fragment.cdt2
## 1     0.08018944                         NA             Dc_1
## 2     0.29227109                         NA             Dc_1
## 3     0.77429388                         NA             Dc_1
## 4    23.34891958                         NA           Dc_1_O
## 5     0.41681710                         NA             Dc_1
##   intensity_fragment.cdt2 TI_termination_fragment.cdt2
## 1                     I_1                         <NA>
## 2                     I_1                         <NA>
## 3                     I_1                         <NA>
## 4                     I_1                         <NA>
## 5                     I_1                         <NA>
```

### 2. Penalties

Same as *[rifi](https://bioconductor.org/packages/3.22/rifi)* workflow, to get the best segmentation we
need the optimal penalties.
To calculate half-life penalty, the difference between half-life from both conditions is calculated and added as `distance_HL` variable to `df_comb_minimal`
data frame.
On other hand the `logFC_int` is used to assign penalties for intensity values
and added as distance\_int variable. `df_comb_minimal` with the additional variables
is named `penalties_df`.

The functions needed for penalty are:

`make_pen` calls one of two available penalty functions to automatically assign
penalties for the dynamic programming. Four functions are called:

* `make_pen`
* `fragment_HL_pen`
* `fragment_inty_pen`
* `score_fun_ave`

#### 1. `make_pen`

`make_pen` calls one of two available penalty functions to automatically
assign penalties for the dynamic programming. the function iterates over many
penalty pairs and picks the most suitable pair based on the difference between
wrong and correct splits. The sample size, penalty range and resolution as well
as the number of cycles can be customized. The primary start parameters create
a matrix with n = `rez_pen` rows and n = `rez_pen_out` columns with values between
sta\_pen/sta\_pen\_out and end\_pen/end\_pen\_out. The best penalty pair is
picked. If dept is bigger than 1 the same process is repeated with a new matrix
of the same size based on the result of the previous cycle. Only position
segments with length within the sample size range are considered for the
penalties to increase run time. Also, outlier penalties cannot be smaller
than 40% of the respective penalty. For more detail check vignette from *[rifi](https://bioconductor.org/packages/3.22/rifi)* package.

#### 2. `fragment_HL_pen`

`fragment_HL_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of half-life fragments. The function used
for `fragment_HL_pen` is `score_fun_ave`. `score_fun_ave` scores the values of
y on how close they are to the mean. for more details, see below.

```
df_comb_minimal[,"distance_HL"] <-
    df_comb_minimal[, "half_life.cdt1"] - df_comb_minimal[, "half_life.cdt2"]

pen_HL <- make_pen(
    probe = df_comb_minimal,
    FUN = rifiComparative:::fragment_HL_pen,
    cores = 2,
    logs = as.numeric(rep(NA, 8))
)
```

#### 3. `fragment_inty_pen`

`fragment_inty_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of intensity fragments.
The function used is `score_fun_ave`.

```
df_comb_minimal[,"distance_int"] <- df_comb_minimal[,"logFC_int"]

pen_int <- make_pen(
    probe = df_comb_minimal,
    FUN = rifiComparative:::fragment_inty_pen,
    cores = 2,
    logs = as.numeric(rep(NA, 8))
)
```

```
data(df_comb_minimal)
penalties_df <- penalties(df_comb_minimal)[[1]]
pen_HL <- penalties(df_comb_minimal)[[2]]
pen_int <- penalties(df_comb_minimal)[[3]]
head(penalties_df, 5)
```

```
##   strand position ID intensity.cdt1 position_segment half_life.cdt1
## 1      +       67  1       1367.080              S_1     0.63658399
## 2      +      153  2       3316.336              S_1     0.07033786
## 3      +      199  3       1112.101              S_1     1.23339859
## 4      +      259  4       2012.294              S_1     0.05594761
## 5      +      320  5       1627.467              S_1     0.07012892
##   TI_termination_factor.cdt1 HL_fragment.cdt1 intensity_fragment.cdt1
## 1                         NA             Dc_1                     I_1
## 2                         NA             Dc_1                     I_1
## 3                         NA             Dc_1                     I_1
## 4                         NA             Dc_1                     I_1
## 5                         NA             Dc_1                     I_1
##   TI_termination_fragment.cdt1   logFC_int     P.Value intensity.cdt2
## 1                         <NA> -0.20137817 0.033395012       1885.621
## 2                         <NA>  0.07306854 0.674892028       4311.070
## 3                         <NA> -0.04264460 0.512469947       1285.397
## 4                         <NA> -0.37075316 0.002843646       3393.836
## 5                         <NA> -0.14561154 0.280129057       2245.636
##   half_life.cdt2 TI_termination_factor.cdt2 HL_fragment.cdt2
## 1     0.08018944                         NA             Dc_1
## 2     0.29227109                         NA             Dc_1
## 3     0.77429388                         NA             Dc_1
## 4    23.34891958                         NA           Dc_1_O
## 5     0.41681710                         NA             Dc_1
##   intensity_fragment.cdt2 TI_termination_fragment.cdt2 distance_HL distance_int
## 1                     I_1                         <NA>   0.5563945  -0.20137817
## 2                     I_1                         <NA>  -0.2219332   0.07306854
## 3                     I_1                         <NA>   0.4591047  -0.04264460
## 4                     I_1                         <NA> -23.2929720  -0.37075316
## 5                     I_1                         <NA>  -0.3466882  -0.14561154
```

#### 4. `score_fun_ave`

`score_fun_ave` scores the values of y on how close they are to the mean.
for more details, see below.

### 3. Fragmentation

After finding the optimal set of penalties, fragmentation process could be applied.
The functions used are:

`fragment_HL`
`fragment_inty`
`score_fun_ave`

#### 1. `fragment_HL`

`fragment_HL` performs the half\_life fragmentation and assigns all gathered
information to the probe based data frame. The columns `HL_comb_fragment` and
`HL_mean_comb_fragment` are added to data frame. `fragment_HL` makes
half-life\_fragments and assigns the mean of each fragment.

```
penalties_df <-
    fragment_HL(
    probe = penalties_df,
    cores = 2,
    pen = pen_HL[[1]][[9]],
    pen_out = pen_HL[[1]][[10]]
)
```

#### 2. `fragment_inty`

`fragment_inty` performs the intensity fragmentation and assigns all gathered
information to the probe based data frame. The columns `intensity_comb_fragment`
and `intensity_mean_comb_fragment` are added to the data frame. `fragment_inty`
makes `intensity_fragments` and assigns the mean of each fragment.
The hierarchy is not followed, fragments from different size could be generated
independently of half-life fragments.

```
fragment_int <-
    fragment_inty(
        probe = penalties_df,
        cores = 2,
        pen = pen_int[[1]][[9]],
        pen_out = pen_int[[1]][[10]]
    )
head(fragment_int, 5)
```

```
##   strand position ID intensity.cdt1 position_segment half_life.cdt1
## 1      +       67  1       1367.080              S_1     0.63658399
## 2      +      153  2       3316.336              S_1     0.07033786
## 3      +      199  3       1112.101              S_1     1.23339859
## 4      +      259  4       2012.294              S_1     0.05594761
## 5      +      320  5       1627.467              S_1     0.07012892
##   TI_termination_factor.cdt1 HL_fragment.cdt1 intensity_fragment.cdt1
## 1                         NA             Dc_1                     I_1
## 2                         NA             Dc_1                     I_1
## 3                         NA             Dc_1                     I_1
## 4                         NA             Dc_1                     I_1
## 5                         NA             Dc_1                     I_1
##   TI_termination_fragment.cdt1   logFC_int     P.Value intensity.cdt2
## 1                         <NA> -0.20137817 0.033395012       1885.621
## 2                         <NA>  0.07306854 0.674892028       4311.070
## 3                         <NA> -0.04264460 0.512469947       1285.397
## 4                         <NA> -0.37075316 0.002843646       3393.836
## 5                         <NA> -0.14561154 0.280129057       2245.636
##   half_life.cdt2 TI_termination_factor.cdt2 HL_fragment.cdt2
## 1     0.08018944                         NA             Dc_1
## 2     0.29227109                         NA             Dc_1
## 3     0.77429388                         NA             Dc_1
## 4    23.34891958                         NA           Dc_1_O
## 5     0.41681710                         NA             Dc_1
##   intensity_fragment.cdt2 TI_termination_fragment.cdt2 distance_HL distance_int
## 1                     I_1                         <NA>   0.5563945  -0.20137817
## 2                     I_1                         <NA>  -0.2219332   0.07306854
## 3                     I_1                         <NA>   0.4591047  -0.04264460
## 4                     I_1                         <NA> -23.2929720  -0.37075316
## 5                     I_1                         <NA>  -0.3466882  -0.14561154
##   HL_comb_fragment HL_mean_comb_fragment intensity_comb_fragment
## 1             Dc_1             0.2202841                     I_1
## 2             Dc_1             0.2202841                     I_1
## 3             Dc_1             0.2202841                     I_1
## 4           Dc_1_O             0.2202841                     I_1
## 5             Dc_1             0.2202841                     I_1
##   intensity_mean_comb_fragment
## 1                  -0.08128129
## 2                  -0.08128129
## 3                  -0.08128129
## 4                  -0.08128129
## 5                  -0.08128129
```

#### 3. `score_fun_ave`

`score_fun_ave` is the score function used by dynamic programming for intensity
fragmentation, for more details, see below.

### 4. Statistics

To check segment significance, t-test with two.sided was used. Each fragment was
tested for the number of probes involved in each condition.

```
data(fragment_int)
stats_df_comb_minimal <- statistics(data= fragment_int)[[1]]
df_comb_uniq_minimal <- statistics(data= fragment_int)[[2]]
```

### 5. Visualization

The visualization depicts half-life and intensity slots of the fragments. Since
hierarchy is not applied, the fragments from half-life and intensity are
independent.

```
data(data_combined_minimal)
data(stats_df_comb_minimal)
data(annot_g)
rifi_visualization_comparison(
     data = data_combined_minimal,
     data_c = stats_df_comb_minimal,
     genomeLength = annot_g[[2]],
     annot = annot_g[[1]]
     )
```

Three objects are required:

`data_combined_minimal` : data frame from joined data by row.
`df_comb_minimal` : data frame from joined data by column
`annot` : ggf3 preprocessed (for more information, see below)

The plot is located on vignette “genome\_fragments\_comparison.pdf” and shows 3 sections: `annotation`, half-life difference and log2FC (mRNA=time0 or intensity).
Either half\_life difference or log2FC(intensity), the line 0 indicates no changes between both conditions. Conditions 1 and 2 are indicated by blue and lilac color respectively. Fragments result of dynamic programming are indicated by different colors.
The annotation englobes genome annotation preprocessed by gff3\_preprocessing function included on the package and a superposed TU annotation of both conditions from
*[rifi](https://bioconductor.org/packages/3.22/rifi)* output.

![**genome fragments visualization of both conditions**](data:image/png;base64...)

Figure 1: **genome fragments visualization of both conditions**

## III. Outputs

### 1. `adjusting_HLToInt`

`adjusting_HLToInt` function combines half-life and intensity fragments generated
without hierarchy on one hand and the genome annotation on other hand. The first
step is adjusting the fragments from half-life to intensity and vise-versa and join
them to the genome annotation. To make half-life and intensity segments comparable,
`log2FC(HL)` is used instead of `distance_HL`. At least one fragment should have
a significant p\_value from t-test, either half-life or intensity.

To generate the data frame, two objects are required:

`df_comb_minimal` : data frame from joined data by column.
`annot` : ggf3 preprocessed (for more information, see below).

The functions used are:

`p_value_function` extracts and return the p\_values of half-life and intensity segments respectively.

`eliminate_outlier_hl` eliminates outliers from half-life fragments.

`eliminate_outlier_int` eliminates outliers from intensity fragments.

`mean_length_int` extracts the mean of the log2FC(intensity) fragments adapted
to HL\_fragments and their lengths.

`mean_length_hl` extracts the mean of log2FC(HL) fragments adapted to the
intensity fragments and their lengths.

`calculating_rate` calculates decay rate and log2FC(intensity). Both are used to
calculate synthesis rate.

The output data frame contains the corresponding columns:

**position**: position of the first fragment
**region**: region annotation covering the fragments
**gene**: gene annotation covering the fragments
**locus\_tag**: locus\_tag annotation covering the fragments
**strand**: The bin/probe specific strand (+/-)
**fragment\_HL**: Half-life fragments
**fragment\_int**: intensity fragments
**position\_frg\_int**: position of the first fragment and the last position of
the last fragment.
**mean\_HL\_fragment**: mean of the HL of the fragments involved.
**mean\_int\_fragment**: mean of the intensity of the fragments involved.
**log2FC(decay\_rate)**: log2FC(decay(condition1)/decay(condition2)).
**log2FC(synthesis\_rate)**: sum of log2FC(decay\_rate) and log2FC(intensity).
**Log2FC(HL)-Log2FC(int)**: sum of log2FC(decay\_rate) and log2FC(intensity).
**intensity\_FC**: log2FC(mean(intensity(condition1))/mean(intensity(condition2))).
**Log2FC(HL)-Log2FC(int)**: sum of log2FC(decay\_rate) and log2FC(intensity).
**p\_value**: indicated by "\*" means at least one fragment either half-life fragment or intensity fragment has a significant p\_value.

```
data(stats_df_comb_minimal)
data(annot_g)
df_adjusting_HLToInt <- adjusting_HLToInt(data = stats_df_comb_minimal,
                                          annotation = annot_g[[1]])
head(df_adjusting_HLToInt, 5)
```

```
##   Position    Region                Gene                 Locus_tag STrand
## 1       67 CDS|5'UTR slr0612|slr0613|sds slr0612|slr0613|slr0611-2      +
## 2     7228 CDS|5'UTR       psbA2|slr1311                   slr1311      +
## 3     8574       CDS                speA                   slr1312      +
## 4    12826       CDS   fecC|fecD|slr1315   slr1316|slr1317|slr1315      +
## 5    12826       CDS   fecC|fecD|slr1315   slr1316|slr1317|slr1315      +
##   Fragment_HL Fragment_int position_frg_int Mean_HL_fragment Mean_int_fragment
## 1        <NA>          I_1          67:2604        0.8798527       -0.09571587
## 2        <NA>          I_2        7228:8311        0.5484517       -0.41072266
## 3        <NA>          I_3       8574:10736        0.6870409       -0.02241187
## 4        Dc_4          I_4      12826:13363        0.3837561       -0.02872339
## 5        Dc_4          I_5      13473:13970       -0.0304837       -0.96316418
##    Decay_rate Synthesis_rate intensity_FC p_value
## 1 -0.38918785     -0.8310518   -0.4418639       *
## 2 -0.52376161     -0.9201845   -0.3964229       *
## 3 -0.25668854     -0.5292553   -0.2725668       *
## 4 -0.03047461     -0.4145714   -0.3840968    <NA>
## 5 -0.08398353     -1.3048974   -1.2209139       *
```

## IV. Plots

A serie of plots could be generated using the `figures_fun`. The functions
included are:

`plot_decay_synt`

`plot_heatscatter`

`plot_density`

`plot_histogram`

`plot_scatter`

`plot_volcano`

```
 data(data_combined_minimal)
 data(df_comb_minimal)
 data(differential_expression)
 data(df_mean_minimal)
 figures_fun(data.1 = df_mean_minimal, data.2 = data_combined_minimal,
 input.1 = df_comb_minimal, input.2 = differential_expression, cdt1 = "sc",
 cdt2 = "fe")
```

### 1. `plot_decay_synt`

The generated data frame `df_mean_minimal` could be used to plot changes in RNA
decay rates (log fold, x-axis) versus the changes in RNA synthesis rates (log fold, y-axis) in the condition 1 versus condition 2. The black lines horizontal, vertical and diagonal are the median of synthesis\_rate, decay\_rate and mRNA at time 0 respectively. Dashed gray lines indicate 0.5-fold changes from 0 (gray lines) referring to unchanged fold.
Coloration could be adjusted upon the parameter selected. In this case decay rate
above 0.5 and synthesis rate below -0.5 are highlighted in yellow.
Segments could be labeled using `geom_text_repel` function, they are commented on
the function.

![**\label{fig:figs}Decay rate vs. Synthesis rate**](data:image/png;base64...)

Figure 2: **Decay rate vs. Synthesis rate**

### 2. `plot_heatscatter`

Heatscatter plot could be generated using “df\_mean\_minimal” data frame. It plots
the changes in RNA decay rates (log fold, x-axis) versus the changes in RNA
synthesis rates (log fold, y-axis) in the condition 1 versus condition 2.
The coloring indicates the local point density.

![**\label{fig:figs}Heatscatter Decay rate vs. Synthesis rate**](data:image/png;base64...)

Figure 3: **Heatscatter Decay rate vs. Synthesis rate**

### 3. `plot_density`

The function uses the `data_combined_minimal` to plot the probe/bin half-life
density in both conditions. Condition 1 and 2 could be indicated.

![**\label{fig:figs}Half-life Density**](data:image/png;base64...)

Figure 4: **Half-life Density**

### 4. `plot_histogram`

The function uses `df_comb_minimal` to plot a histogram of probe/bin half-life
categories from 2 to 20 minutes in both conditions. Condition 1 and 2 could be
indicated.

![**\label{fig:figs}Half-life Classification**](data:image/png;base64...)

Figure 5: **Half-life Classification**

### 5. `plot_scatter`

A scatter plot of the bin/probe half-life in condition 1 vs. condition 2.

![**\label{fig:figs}Half-life Scatter Plot **](data:image/png;base64...)

Figure 6: **Half-life Scatter Plot**

### 6. `plot_volcano`

A volcano plot of statistical significance (P value) versus magnitude of change
(fold change).

![**\label{fig:figs}Volcano Plot**](data:image/png;base64...)

Figure 7: **Volcano Plot**

## III. Additional functions

### 1. `score_fun_ave`

`score_fun_ave` scores the difference of the values from their mean.
`score_fun_ave` calculates the mean of a minimum 2 values **y** and substrates
the difference from their mean. The IDs **z** and the sum of differences from
the mean are stored. A new value y is added, the mean is calculated and the new
IDs and sum of differences are stored. After several rounds, the minimum score
and the corresponding IDs is selected and stored as the best fragment.
`score_fun_ave` selects simultaneously for outliers, the maximum number is fixed
previously. Outliers are those values with high difference from the mean, they
are stored but excluded from the next calculation. The output of the function is
a vector of IDs separated by “,”, a vector of mean separated by "\_" and a
vector of outliers separated by “,”.

### 2. `gff3_preprocess`

`gff3_preprocess` processes gff3 file from database, extracting gene names and
locus\_tag from all coding regions (CDS). Other features like UTRs, ncRNA, asRNA
ect.. if available and the genome length are extracted. The output is a list of
2 elements.

The output data frame from `gff3_preprocess` function contains the following
columns:

1. *region*: CDS or any other available like UTRs, ncRNA, asRNA
2. *start*: start position of the gene
3. *end*: end position of the gene
4. *strand*: +/-
5. *gene*: gene annotation if available otherwise locus\_tag annotation replaces
   it
6. *locus\_tag*: locus\_tag annotation

```
gff3_preprocess(path = gzfile(
   system.file("extdata", "gff_synechocystis_6803.gff.gz", package = "rifiComparative")
 ))
```

```
## [[1]]
## DataFrame with 5853 rows and 6 columns
##        region     start       end      strand        gene   locus_tag
##      <factor> <integer> <integer> <character> <character> <character>
## 1       CDS           1       772           +         sds   slr0611-2
## 2       asRNA       689       909           -  slr0612-as  slr0612-as
## 3       CDS         802      1494           +     slr0612     slr0612
## 4       5'UTR      1532      1576           +     slr0613     slr0613
## 5       CDS        1577      2098           +     slr0613     slr0613
## ...       ...       ...       ...         ...         ...         ...
## 5849    CDS     3571612   3572403           +     slr0610     slr0610
## 5850    ncRNA   3572945   3573067           -       SyR52     ncl1790
## 5851    ncRNA   3573080   3573200           -     ncl1800     ncl1800
## 5852    5'UTR   3573218   3573270           +     slr0611     slr0611
## 5853    CDS     3573271   3573470           +         sds     slr0611
##
## [[2]]
## [1] 3573470
```

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] rifiComparative_1.10.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] writexl_1.5.4            tidyselect_1.2.1         dplyr_1.1.4
##  [4] farver_2.1.2             Biostrings_2.78.0        S7_0.2.0
##  [7] bitops_1.0-9             fastmap_1.2.0            RCurl_1.98-1.17
## [10] GenomicAlignments_1.46.0 egg_0.4.5                XML_3.99-0.19
## [13] digest_0.6.37            lifecycle_1.0.4          ellipsis_0.3.2
## [16] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
## [19] doMC_1.3.8               sass_0.4.10              tools_4.5.1
## [22] yaml_2.3.10              rtracklayer_1.70.0       knitr_1.50
## [25] S4Arrays_1.10.0          scatterplot3d_0.3-44     pkgbuild_1.4.8
## [28] curl_7.0.0               DelayedArray_0.36.0      plyr_1.8.9
## [31] RColorBrewer_1.1-3       pkgload_1.4.1            abind_1.4-8
## [34] BiocParallel_1.44.0      purrr_1.1.0              desc_1.4.3
## [37] nnet_7.3-20              grid_4.5.1               ggplot2_4.0.0
## [40] scales_1.4.0             iterators_1.0.14         dichromat_2.0-0.1
## [43] cli_3.6.5                rmarkdown_2.30           crayon_1.5.3
## [46] remotes_2.5.0            rstudioapi_0.17.1        reshape2_1.4.4
## [49] httr_1.4.7               rjson_0.2.23             sessioninfo_1.2.3
## [52] cachem_1.1.0             stringr_1.5.2            parallel_4.5.1
## [55] DTA_2.56.0               BiocManager_1.30.26      XVector_0.50.0
## [58] restfulr_0.0.16          vctrs_0.6.5              devtools_2.4.6
## [61] Matrix_1.7-4             jsonlite_2.0.0           bookdown_0.45
## [64] ggrepel_0.9.6            LSD_4.1-0                foreach_1.5.2
## [67] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
## [70] cowplot_1.2.0            stringi_1.8.7            gtable_0.3.6
## [73] BiocIO_1.20.0            tibble_3.3.0             pillar_1.11.1
## [76] htmltools_0.5.8.1        R6_2.6.1                 rprojroot_2.1.1
## [79] lattice_0.22-7           evaluate_1.0.5           cigarillo_1.0.0
## [82] Rsamtools_2.26.0         memoise_2.0.1            bslib_0.9.0
## [85] Rcpp_1.1.0               SparseArray_1.10.0       gridExtra_2.3
## [88] xfun_0.53                fs_1.6.6                 usethis_3.2.1
## [91] pkgconfig_2.0.3
```