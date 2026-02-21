# SDY180: Abundance of Plasmablasts Measured by Multiparameter Flow Cytometry

#### Renan Sauteraud

#### 2019-03-27

* [1 Summary](#summary)
* [2 Load ImmuneSpaceR and other libraries](#load-immunespacer-and-other-libraries)
* [3 Connect to the study and get the flow cytometry results](#connect-to-the-study-and-get-the-flow-cytometry-results)
* [4 Subset the population of interest](#subset-the-population-of-interest)
* [5 Compute the median](#compute-the-median)
* [6 Flow cytometry vs. ELISPOT](#flow-cytometry-vs.elispot)

`ImmuneSpaceR` code produces consistent results, regardless of whether it is being executed from a module or a UI based report on the server or on a local machine. This vignette reproduces a report available on [the ImmuneSpace portal](https://www.immunespace.org/reports/Studies/SDY180/runReport.view?reportId=module %3ASDY180%2Freports%2Fschemas%2Fstudy%2Fdemographics%2Fplasmablast_abundance.Rmd) using the same code.

# 1 Summary

This report investigate the abundance of plasmablast (and other B cell subsets) over time after vaccination with Pneumovax, Fluzone, or no vaccination (saline control group).

It can be seen on the three figures below that the plasmablast subset peaks at day 7 in both vaccine groups, with a stronger and more durable response with Pneumovax.

As expected, there is no clear peak in the saline group. These results are similar to those reported in Figure 6B of [Obermoser et al. (2013)](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3681204/) published as part of the original study.

# 2 Load ImmuneSpaceR and other libraries

```
library(ImmuneSpaceR)
library(ggplot2)
library(data.table)
```

# 3 Connect to the study and get the flow cytometry results

```
study <- CreateConnection(c("SDY180"))
dt_fcs <- study$getDataset("fcs_analyzed_result")
```

# 4 Subset the population of interest

```
dt_fcs19 <- dt_fcs[population_name_reported %like% "Plasma"]
dt_fcs19 <- dt_fcs19[, cohort := gsub("Study g", "G", cohort), ]
```

# 5 Compute the median

```
dt_fcs19_median <- dt_fcs19[, .(median_cell_reported = median(as.double(population_cell_number) + 1,
na.rm = TRUE)), by = .(cohort,study_time_collected,population_name_reported)]
```

# 6 Flow cytometry vs. ELISPOT

```
ggplot(dt_fcs19, aes(x = as.factor(study_time_collected), y = as.double(population_cell_number) + 1)) +
geom_boxplot() +
geom_jitter() +
scale_y_log10() +
facet_grid(cohort~population_name_reported, scale = "free") +
xlab("Time") +
ylab(expression(paste("Number of cells/", mu, "l"))) +
geom_line(data = dt_fcs19_median, aes(x = as.factor(study_time_collected), y = as.double(median_cell_reported),
group = 1), color = "black", size = 1.2) +
labs(title = "Plasma cell abundance after vaccination") +
theme_IS()
```

![](data:image/png;base64...)