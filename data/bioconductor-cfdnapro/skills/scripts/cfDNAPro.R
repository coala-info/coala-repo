# Code example from 'cfDNAPro' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  tidy.opts = list(width.cutoff=80),
  tidy = FALSE,
  message = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----get path to example data-------------------------------------------------
library(cfDNAPro)
# Get the path to example data in cfDNAPro package library path.
data_path <- examplePath("groups_picard")

## ----single group plot--------------------------------------------------------
cohort1_plot <- cfDNAPro::callSize(path = data_path) %>%
  dplyr::filter(group == as.character("cohort_1")) %>%
  cfDNAPro::plotSingleGroup()


## ----fragment size distribution, fig.height=6.5, fig.width=10, warning=TRUE----
library(scales)
library(ggpubr)
library(ggplot2)
library(dplyr)


# Define a list for the groups/cohorts.
grp_list<-list("cohort_1"="cohort_1",
               "cohort_2"="cohort_2",
               "cohort_3"="cohort_3",
               "cohort_4"="cohort_4")

# Generating the plots and store them in a list.
result<-sapply(grp_list, function(x){
  result <-callSize(path = data_path) %>% 
    dplyr::filter(group==as.character(x)) %>% 
    plotSingleGroup()
}, simplify = FALSE)

# Multiplexing the plots in one figure
suppressWarnings(
  multiplex <-
    ggarrange(result$cohort_1$prop_plot + 
              theme(axis.title.x = element_blank()),
            result$cohort_4$prop_plot + 
              theme(axis.title = element_blank()),
            result$cohort_1$cdf_plot,
            result$cohort_4$cdf_plot + 
              theme(axis.title.y = element_blank()),
            labels = c("Cohort 1 (n=5)", "Cohort 4 (n=4)"),
            label.x = 0.2,
            ncol = 2,
            nrow = 2))

multiplex

## ----Median distribution, fig.height=6, fig.width=7.2, warning=TRUE-----------
# Set an order for those groups (i.e. the levels of factors).
order <- c("cohort_1", "cohort_2", "cohort_3", "cohort_4")
# Generate plots.
compare_grps<-callMetrics(data_path) %>% plotMetrics(order=order)

# Modify plots.
p1<-compare_grps$median_prop_plot +
  ylim(c(0, 0.028)) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) +
  theme(legend.position = c(0.7, 0.5),
        legend.text = element_text( size = 11),
        legend.title = element_blank())

p2<-compare_grps$median_cdf_plot +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.001)) +
  theme(axis.title=element_text(size=12,face="bold")) +
  theme(legend.position = c(0.7, 0.5),
        legend.text = element_text( size = 11),
        legend.title = element_blank())

# Finalize plots.
suppressWarnings(
  median_grps<-ggpubr::ggarrange(p1,
                       p2,
                       label.x = 0.3,
                       ncol = 1,
                       nrow = 2
                       ))


median_grps

## ----Modal size bar chart, fig.height=6, fig.width=7.2, warning=TRUE----------
# Set an order for your groups, it will affect the group order along x axis!
order <- c("cohort_1", "cohort_2", "cohort_3", "cohort_4")

# Generate mode bin chart.
mode_bin <- callMode(data_path) %>% plotMode(order=order,hline = c(167,111,81))

# Show the plot.
suppressWarnings(print(mode_bin))


## ----modal size stacked bar chart, fig.height=6, fig.width=7.2, warning=TRUE----
# Set an order for your groups, it will affect the group order along x axis.
order <- c("cohort_1", "cohort_2", "cohort_3", "cohort_4")

# Generate mode stacked bar chart. You could specify how to stratify the modes
# using 'mode_partition' arguments. If other modes exist other than you 
# specified, an 'other' group will be added to the plot.

mode_stacked <- 
  callMode(data_path) %>% 
  plotModeSummary(order=order,
                  mode_partition = list(c(166,167)))

# Modify the plot using ggplot syntax.
mode_stacked <- mode_stacked + theme(legend.position = "top")

# Show the plot.
suppressWarnings(print(mode_stacked))


## ----interpeak distance, fig.height=6, fig.width=7.2, warning=TRUE------------
# Set an order for your groups, it will affect the group order.
order <- c("cohort_1", "cohort_2", "cohort_4", "cohort_3")

# Plot and modify inter-peak distances.

  inter_peak_dist<-callPeakDistance(path = data_path,  limit = c(50, 135)) %>%
  plotPeakDistance(order = order) +
  labs(y="Fraction") +
  theme(axis.title =  element_text(size=12,face="bold"),
        legend.title = element_blank(),
        legend.position = c(0.91, 0.5),
        legend.text = element_text(size = 11))


# Show the plot.
suppressWarnings(print(inter_peak_dist))


## ----intervalley distance, fig.height=6, fig.width=7.2, warning=FALSE---------
# Set an order for your groups, it will affect the group order.
order <- c("cohort_1", "cohort_2", "cohort_4", "cohort_3")
# Plot and modify inter-peak distances.
inter_valley_dist<-callValleyDistance(path = data_path,  
                                      limit = c(50, 135)) %>%
  plotValleyDistance(order = order) +
  labs(y="Fraction") +
  theme(axis.title =  element_text(size=12,face="bold"),
        legend.title = element_blank(),
        legend.position = c(0.91, 0.5),
        legend.text = element_text(size = 11))

# Show the plot.
suppressWarnings(print(inter_valley_dist))


## ----what else,fig.height=6, fig.width=7.2, warning=FALSE---------------------
library(ggplot2)
library(cfDNAPro)
# Set the path to the example sample.
exam_path <- examplePath("step6")
# Calculate peaks and valleys.
peaks <- callPeakDistance(path = exam_path) 
valleys <- callValleyDistance(path = exam_path) 
# A line plot showing the fragmentation pattern of the example sample.
exam_plot_all <- callSize(path=exam_path) %>% plotSingleGroup(vline = NULL)
# Label peaks and valleys with dashed and solid lines.
exam_plot_prop <- exam_plot_all$prop + 
  coord_cartesian(xlim = c(90,135),ylim = c(0,0.0065)) +
  geom_vline(xintercept=peaks$insert_size, colour="red",linetype="dashed") +
  geom_vline(xintercept = valleys$insert_size,colour="blue")

# Show the plot.
suppressWarnings(print(exam_plot_prop))

# Label peaks and valleys with dots.
exam_plot_prop_dot<- exam_plot_all$prop + 
  coord_cartesian(xlim = c(90,135),ylim = c(0,0.0065)) +
  geom_point(data= peaks, 
             mapping = aes(x= insert_size, y= prop),
             color="blue",alpha=0.5,size=3) +
  geom_point(data= valleys, 
             mapping = aes(x= insert_size, y= prop),
             color="red",alpha=0.5,size=3) 
# Show the plot.
suppressWarnings(print(exam_plot_prop_dot))


## -----------------------------------------------------------------------------
sessionInfo()

