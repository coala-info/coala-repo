Code

* Show All Code
* Hide All Code

# Rcollectl

Vince Carey1\* and Yubo Cheng2\*\*

1Harvard Medical School
2Roswell Park Comprehensive Cancer Center

\*stvjc@channing.harvard.edu
\*\*yubo.cheng@roswellpark.org

#### 30 October 2025

#### Package

Rcollectl 1.10.0

# 1 Quick start for `Rcollectl`

```
library("Rcollectl")
```

[Collectl](https://collectl.sourceforge.net/) is
a unix-based tool that will perform measurements on system resource
consumption of various types. We provide a demonstration
output with the package:

```
lk = cl_parse(system.file("demotab/demo_1123.tab.gz", package="Rcollectl"))
dim(lk)
#> [1] 478  71
attr(lk, "meta")
#>  [1] "################################################################################"
#>  [2] "# Collectl:   V4.3.1-1  HiRes: 1  Options: -scdnm -P -f./col2.txt "
#>  [3] "# Host:       stvjc-XPS-13-9300  DaemonOpts: "
#>  [4] "# Booted:     1606052236.57 [20201122-08:37:16]"
#>  [5] "# Distro:     debian bullseye/sid, Ubuntu 20.04.1 LTS  Platform: "
#>  [6] "# Date:       20201123-144054  Secs: 1606160454 TZ: -0500"
#>  [7] "# SubSys:     cdnm Options:  Interval: 1 NumCPUs: 8 [HYPER] NumBud: 0 Flags: i"
#>  [8] "# Filters:    NfsFilt:  EnvFilt:  TcpFilt: ituc"
#>  [9] "# HZ:         100  Arch: x86_64-linux-gnu-thread-multi PageSize: 4096"
#> [10] "# Cpu:        GenuineIntel Speed(MHz): 1745.513 Cores: 4  Siblings: 8 Nodes: 1"
#> [11] "# Kernel:     5.4.0-54-generic  Memory: 15969160 kB  Swap: 2097148 kB"
#> [12] "# NumDisks:   1 DiskNames: nvme0n1"
#> [13] "# NumNets:    4 NetNames: lo:?? enxc03ebaccccfd:100 docker0:?? wlp0s20f3:??"
#> [14] "################################################################################"
lk[1:5,1:5]
#>      #Date     Time CPU_User% CPU_Nice% CPU_Sys%
#> 1 20201123 14:40:56         2         0        1
#> 2 20201123 14:40:57         1         0        0
#> 3 20201123 14:40:58         1         0        0
#> 4 20201123 14:40:59         2         0        0
#> 5 20201123 14:41:00         3         0        1
```

```
plot_usage(lk)
```

![](data:image/png;base64...)

From this display, we can see that about a burst of network activity
around 14:43 is followed by consumption of CPU, memory, and disk resources.
The % CPU active never exceeds 30, memory consumption started relatively
high when sampling began, growing to about 15.5 GB. and 250MB were written
to disk over the entire interval.

To generate a display like this, we use commands shown below. You can
use an arbitrary string as `[target file prefix]`. Thus `cl_start("foo")`
will produce a file foo-[hostname]-[yyyymmdd].tab.gz, containing timing
and consumption data, where [hostname] is the value of `hostname` and
[yyyymmdd] is a representation of the current date. Use different target
file prefixes for runs you wish to distinguish.

```
id = cl_start([target file prefix])
[use R until task to be measured is complete]
cl_stop(id)
usage_df = cl_parse(dir(patt=[target file prefix]))
# analyze or filter the usage_df (for example, to trim away
# time related to task delay or delay of `cl_stop`
plot_usage(usage_df)
```

# 2 Timestamps

Yubo Cheng has added functionality allowing us to annotate
usage plots with labels related to task phases. Here is
the code from the example showing how to introduce annotations
in the time profile.

```
     id <- cl_start()
     Sys.sleep(2)
     #code
     cl_timestamp(id, "step1")
     Sys.sleep(2)
     # code
     Sys.sleep(2)
     cl_timestamp(id, "step2")
     Sys.sleep(2)
     # code
     Sys.sleep(2)
     cl_timestamp(id, "step3")
     Sys.sleep(2)
     # code
     cl_stop(id)
     path <- cl_result_path(id)

     plot_usage(cl_parse(path)) +
       cl_timestamp_layer(path) +
       cl_timestamp_label(path) +
       ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))
```

![](data:image/png;base64...)

# 3 Reproducibility

The *[Rcollectl](https://bioconductor.org/packages/3.22/Rcollectl)* package ([Carey and Cheng, 2025](https://bioconductor.org/packages/Rcollectl)) was made possible thanks to:

* R ([R Core Team, 2025](https://www.R-project.org/))
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* ([Oleś, 2025](https://bioconductor.org/packages/BiocStyle))
* *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2021](https://CRAN.R-project.org/package%3Dknitcitations))
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2025](https://yihui.org/knitr/))
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, Dervieux, McPherson et al., 2025](https://github.com/rstudio/rmarkdown))
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* ([Wickham, Chang, Flight, Müller et al., 2025](https://CRAN.R-project.org/package%3Dsessioninfo))
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* ([Wickham, 2011](https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf))

This package was developed using *[biocthis](https://github.com/lcolladotor/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("Rcollectl.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("Rcollectl.Rmd", tangle = TRUE)
```

```
## Clean up
file.remove("Rcollectl.bib")
#> [1] TRUE
```

Date the vignette was generated.

```
#> [1] "2025-10-30 01:58:02 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 15.273 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package       * version date (UTC) lib source
#>  backports       1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex          0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager     1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle     * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown        0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib           0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem          1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli             3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  dichromat       2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest          0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr           1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate        1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver          2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap         1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  generics        0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  ggplot2         4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  glue            1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable          0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools       0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr            1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  jquerylib       0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite        2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitcitations * 1.0.12  2021-01-10 [2] CRAN (R 4.5.1)
#>  knitr           1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling        0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lifecycle       1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate       1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr        2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  pillar          1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig       2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr            1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  processx        3.8.6   2025-02-21 [2] CRAN (R 4.5.1)
#>  ps              1.9.1   2025-04-12 [2] CRAN (R 4.5.1)
#>  R6              2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  Rcollectl     * 1.10.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  RColorBrewer    1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp            1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR      1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang           1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown       2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S7              0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass            0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales          1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  sessioninfo   * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi         1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr         1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  tibble          3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect      1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange      0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs           0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr           3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun            0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2            1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  yaml            2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpvurSkK/Rinst278fb07b512a2a
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* ([Oleś, 2025](https://bioconductor.org/packages/BiocStyle))
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2025](https://yihui.org/knitr/)) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, Dervieux, McPherson et al., 2025](https://github.com/rstudio/rmarkdown)) running behind the scenes.

Citations made with *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2021](https://CRAN.R-project.org/package%3Dknitcitations)).

[1] J. Allaire, Y. Xie, C. Dervieux, J. McPherson, et al. *rmarkdown: Dynamic Documents for R*. R package
version 2.30. 2025. <https://github.com/rstudio/rmarkdown>.

[2] C. Boettiger. *knitcitations: Citations for ‘Knitr’ Markdown Files*. R package version 1.0.12. 2021.
DOI: 10.32614/CRAN.package.knitcitations. [https://CRAN.R-project.org/package=knitcitations](https://CRAN.R-project.org/package%3Dknitcitations).

[3] V. Carey and Y. Cheng. *Rcollectl: Help use collectl with R in Linux, to measure resource consumption
in R processes*. R package version 1.10.0. 2025. DOI: 10.18129/B9.bioc.Rcollectl.
<https://bioconductor.org/packages/Rcollectl>.

[4] A. Oleś. *BiocStyle: Standard styles for vignettes and other Bioconductor documents*. R package version
2.38.0. 2025. DOI: 10.18129/B9.bioc.BiocStyle. <https://bioconductor.org/packages/BiocStyle>.

[5] R Core Team. *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical
Computing. Vienna, Austria, 2025. <https://www.R-project.org/>.

[6] H. Wickham. “testthat: Get Started with Testing”. In: *The R Journal* 3 (2011), pp. 5-10.
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[7] H. Wickham, W. Chang, R. Flight, K. Müller, et al. *sessioninfo: R Session Information*. R package
version 1.2.3. 2025. DOI: 10.32614/CRAN.package.sessioninfo.
[https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[8] Y. Xie. *knitr: A General-Purpose Package for Dynamic Report Generation in R*. R package version 1.50.
2025. <https://yihui.org/knitr/>.