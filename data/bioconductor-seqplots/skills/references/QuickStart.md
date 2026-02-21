# SeqPlots R workflow

Przemyslaw Setmpor

#### *04 January 2019*

#### Abstract

SeqPlots is a tool for plotting average track signals (e.g. read coverage) and sequence motif densities over user specified genomic features. The data can be visualized in linear plots with error estimates or as series of heatmaps that can be sorted and clustered. The software can be run locally on a desktop or deployed on a server and allows easy data sharing. SeqPlots pre-calculates and stores binary result matrices, allowing rapid plot generation. Plots can also be run in batch.

#### Package

SeqPlots 1.20.1

# Contents

* [1 Quick start demo](#quick-start-demo)
* [2 Session Information](#session-information)

# 1 Quick start demo

1. Start SeqPlots. Refer to **installation guides** for platform specific information. After successful initiation the web interface should automatically open in your default web browser. If you are using web server version just navigate your browser to the server address.

   ![The SeqPlots interface in web browser](data:image/png;base64...)

   The SeqPlots interface in web browser
2. Upload feature (BED or GFF) and track (BigWig or WIG) files. They can be gzip compressed (e.g. file1.bed.gz). Press green “Add files…” button or just drag and drop files into the window. The ready to upload files will show up in upload window, where you select user name, reference genome and optionally add some comments.

   ![File upload panel](data:image/png;base64...)

   File upload panel
3. When all is done press blue “Start upload” button. After upload and processing is done the green “SUCCESS” label should show. It means that file is on the registered and ready to use. Occasionally the file might be mot formatted properly or chromosome names might not agree with reference genome. In such case a verbose error will window appears and file as labeled as “ERROR”. For further information please refer to [**errors chapter**](Errors).

   ![File upload progress infoermation](data:image/png;base64...)

   File upload progress infoermation
4. Dismiss upload window and press blue “New plot set” button on side panel. This will bring up file management window. In file management window select at least one file from “Features” tab and at least one file from “Tracks” or sequence motif(s). The sequence motifs and tracks can be processed and plotted together. Select files by clicking on file name, selected files will be highlighted.

   ![File management panel](data:image/png;base64...)

   File management panel
5. After choosing files/motifs to plot, set up the processing options. You can find these in the button of plotting window.

   ![Plot set calculation options](data:image/png;base64...)

   Plot set calculation options
6. After options are set up press blue “Run calculation” button. This will dismiss the file management window and show processing message. Here you can observe the progress of the task and optionally cancel it if no longer required or you forgot to add some important file to the plot-set.

   ![Plot set calculation progress window](data:image/png;base64...)

   Plot set calculation progress window
7. After some time the calculation will finish (fingers crossed, without the error) and you will be able to see plot set array. In here you can choose which feature-track or feature-motif pairs to plot. Choose one or more checkboxes and press grey “Line plot” button (or hit RETURN from your keyboard).

   ![The plot selection grid](data:image/png;base64...)

   The plot selection grid
8. Congratulation! Your First plot is complete, you can see the preview of it on the side panel.

   ![The plot preview panel](data:image/png;base64...)

   The plot preview panel
9. You are able to set up labels, titles, font sizes, legends and many more on control panel tabs - please see **Plotting** chapter for details.

   ![Plot settings tabs](data:image/png;base64...)

   Plot settings tabs
10. By clicking the plot preview you can enlarge it for better view. When everything is ready you can get the plot as PDF by clicking green “Line plot” button just on the top of side panel.

    ![Average plot example](data:image/png;base64...)

    Average plot example
11. You can also visualize the signal as a heatmap. Please note that heatmap plotting is possible only for a single feature file.
    It is possible to sort heatmaps based on mean row signals and/or cluster them using k-means algorithm, hierarchical clustering or self organising maps.
    To learn more about heatmaps see **Heatmaps** chapter.

    ![Heatmap settings tab](data:image/png;base64...)

    Heatmap settings tab
12. Heatmaps can be downloaded sa PDFs using ‘Heatmap’ button just on the bottom of setup panel.
    The small button, at the right sied of ‘Heatmap’ button downloads cluster definition and sorting order.

    ![Heatmap example](data:image/png;base64...)

    Heatmap example

# 2 Session Information

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] BiocManager_1.30.4 compiler_3.5.2     magrittr_1.5
##  [4] bookdown_0.9       htmltools_0.3.6    tools_3.5.2
##  [7] yaml_2.2.0         Rcpp_1.0.0         stringi_1.2.4
## [10] rmarkdown_1.11     knitr_1.21         stringr_1.3.1
## [13] digest_0.6.18      xfun_0.4           evaluate_0.12
```