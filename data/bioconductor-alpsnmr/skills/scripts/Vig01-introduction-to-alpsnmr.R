# Code example from 'Vig01-introduction-to-alpsnmr' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(readxl)
library(BiocParallel)
library(AlpsNMR)

## -----------------------------------------------------------------------------
#register(SerialParam(), default = TRUE)  # disable parallellization
register(SnowParam(workers = 2, exportglobals = FALSE), default = TRUE)  # enable parallellization with 2 workers

## -----------------------------------------------------------------------------
MeOH_plasma_extraction_dir <- system.file("dataset-demo", package = "AlpsNMR")
MeOH_plasma_extraction_dir

## -----------------------------------------------------------------------------
list.files(MeOH_plasma_extraction_dir)

## -----------------------------------------------------------------------------
MeOH_plasma_extraction_xlsx <- file.path(MeOH_plasma_extraction_dir, "dummy_metadata.xlsx")
annotations <- readxl::read_excel(MeOH_plasma_extraction_xlsx)
annotations

## ----load-samples-------------------------------------------------------------
zip_files <- fs::dir_ls(MeOH_plasma_extraction_dir, glob = "*.zip")
zip_files
dataset <- nmr_read_samples(sample_names = zip_files)
dataset

## -----------------------------------------------------------------------------
dataset <- nmr_meta_add(dataset, metadata = annotations, by = "NMRExperiment")

## -----------------------------------------------------------------------------
nmr_meta_get(dataset, groups = "external")

## -----------------------------------------------------------------------------
#dataset <- nmr_autophase(dataset, method="MPC_DANM")

## -----------------------------------------------------------------------------
dataset <- nmr_interpolate_1D(dataset, axis = c(min = -0.5, max = 10))

## -----------------------------------------------------------------------------
plot(dataset, NMRExperiment = c("10", "30"), chemshift_range = c(2.2, 2.8))

## -----------------------------------------------------------------------------
regions_to_exclude <- list(water = c(4.6, 5), methanol = c(3.33, 3.39))
dataset <- nmr_exclude_region(dataset, exclude = regions_to_exclude)
plot(dataset, chemshift_range = c(4.2, 5.5))

## -----------------------------------------------------------------------------
samples_10_20 <- filter(dataset, SubjectID == "Ana")
nmr_meta_get(samples_10_20, groups = "external")

## -----------------------------------------------------------------------------
pca_outliers_rob <- nmr_pca_outliers_robust(dataset, ncomp = 3)
nmr_pca_outliers_plot(dataset, pca_outliers_rob)

## -----------------------------------------------------------------------------
plot(dataset, chemshift_range = c(1.37, 2.5))

## -----------------------------------------------------------------------------
plot(dataset, chemshift_range = c(3.5,3.8))

## -----------------------------------------------------------------------------
dataset <- nmr_baseline_estimation(dataset, lambda = 9, p = 0.01)

## ----fig.height=10, fig.width=10----------------------------------------------
# TODO: Simplify this plot
spectra_to_plot <- tidy(dataset, chemshift_range = c(1.37, 2.5))
baseline_to_plot <- tidy(dataset, chemshift_range = c(1.37, 2.5), matrix_name = "data_1r_baseline")

ggplot(mapping = aes(x = chemshift, y = intensity, color = NMRExperiment)) +
    geom_line(data = spectra_to_plot) +
    geom_line(data = baseline_to_plot, linetype = "dashed") + 
    facet_wrap(~NMRExperiment, ncol = 1)


## ----fig.height=10, fig.width=10----------------------------------------------
# TODO: Simplify this plot
spectra_to_plot <- tidy(dataset, chemshift_range = c(3.5, 3.8))
baseline_to_plot <- tidy(dataset, chemshift_range = c(3.5, 3.8), matrix_name = "data_1r_baseline")

ggplot(mapping = aes(x = chemshift, y = intensity, color = NMRExperiment)) +
    geom_line(data = spectra_to_plot) +
    geom_line(data = baseline_to_plot, linetype = "dashed") + 
    facet_wrap(~NMRExperiment, ncol = 1)


## -----------------------------------------------------------------------------
baselineThresh <- nmr_baseline_threshold(dataset, range_without_peaks = c(9.5, 10), method = "median3mad")
nmr_baseline_threshold_plot(dataset, baselineThresh)

## -----------------------------------------------------------------------------
peak_list_initial <- nmr_detect_peaks(
    dataset,
    nDivRange_ppm = 0.1,
    scales = seq(1, 16, 2),
    baselineThresh = baselineThresh,
    SNR.Th = 3,
    fit_lorentzians = TRUE
)

## -----------------------------------------------------------------------------
nmr_detect_peaks_plot_overview(peak_list_initial)

## -----------------------------------------------------------------------------
nmr_detect_peaks_plot(dataset, peak_list_initial, NMRExperiment = "10", chemshift_range = c(3, 3.3))

## -----------------------------------------------------------------------------
peak_list_in_range <- filter(peak_list_initial, ppm > 3.22, ppm < 3.24)
peak_list_in_range

## -----------------------------------------------------------------------------
plot(dataset, chemshift_range = c(3.22, 3.25))

## -----------------------------------------------------------------------------
nmr_detect_peaks_plot_peaks(
    dataset,
    peak_list_initial,
    peak_ids = peak_list_in_range$peak_id,
    caption = paste("{peak_id}",
                    "(NMRExp.\u00A0{NMRExperiment},",
                    "gamma(ppb)\u00a0=\u00a0{gamma_ppb},",
                    "\narea\u00a0=\u00a0{area},",
                    "nrmse\u00a0=\u00a0{norm_rmse})")
)


## -----------------------------------------------------------------------------
peak_list_initial_accepted <- peaklist_accept_peaks(
    peak_list_initial,
    dataset,
    area_min = 50, 
    keep_rejected = FALSE,
    verbose = TRUE
)

## -----------------------------------------------------------------------------
NMRExp_ref <- nmr_align_find_ref(dataset, peak_list_initial_accepted)
message("Your reference is NMRExperiment ", NMRExp_ref)

## -----------------------------------------------------------------------------
dataset_align <- nmr_align(
    nmr_dataset = dataset, 
    peak_data = peak_list_initial_accepted, 
    NMRExp_ref = NMRExp_ref, 
    maxShift_ppm = 0.0015, 
    acceptLostPeak = TRUE
)

## -----------------------------------------------------------------------------
plot(dataset, chemshift_range = c(3.025, 3.063))
plot(dataset_align, chemshift_range = c(3.025, 3.063))

## -----------------------------------------------------------------------------
cowplot::plot_grid(
    plot(dataset, chemshift_range = c(3.22, 3.25)) + theme(legend.position = "none"),
    plot(dataset_align, chemshift_range = c(3.22, 3.25)) + theme(legend.position = "none")
)

## -----------------------------------------------------------------------------
dataset_norm <- nmr_normalize(dataset_align, method = "pqn")

## -----------------------------------------------------------------------------
normalization_info <- nmr_normalize_extra_info(dataset_norm)
normalization_info$norm_factor
normalization_info$plot

## -----------------------------------------------------------------------------
to_plot <- dplyr::bind_rows(
    tidy(dataset_align, NMRExperiment = "20", chemshift_range = c(2,2.5)) %>%
        mutate(Normalized = "No"),
    tidy(dataset_norm, NMRExperiment = "20", chemshift_range = c(2,2.5)) %>%
        mutate(Normalized = "Yes"),
)
ggplot(data = to_plot, mapping = aes(x = chemshift, y = intensity, color = Normalized)) + 
    geom_line() +
    scale_x_reverse() +
    labs(y = "Intensity", x = "Chemical shift (ppm)",
         caption = "The normalization slightly diluted experiment 20")



## -----------------------------------------------------------------------------
cowplot::plot_grid(
    plot(dataset_align, chemshift_range = c(2, 2.5)) + labs(title="Before Normalization"),
    plot(dataset_norm, chemshift_range = c(2, 2.5)) + labs(title="After Normalization"),
    ncol = 1
)

## -----------------------------------------------------------------------------
baselineThresh <- nmr_baseline_threshold(dataset_norm, range_without_peaks = c(9.5, 10), method = "median3mad")
nmr_baseline_threshold_plot(dataset_norm, baselineThresh)

## -----------------------------------------------------------------------------
peak_list_for_clustering_unfiltered <- nmr_detect_peaks(
    dataset_norm,
    nDivRange_ppm = 0.1,
    scales = seq(1, 16, 2),
    baselineThresh = baselineThresh,
    SNR.Th = 3,
    fit_lorentzians = TRUE,
    verbose = TRUE
)

peak_list_for_clustering <- peaklist_accept_peaks(
    peak_list_for_clustering_unfiltered,
    dataset_norm,
    area_min = 50, 
    keep_rejected = FALSE,
    verbose = TRUE
)


## -----------------------------------------------------------------------------
clustering <- nmr_peak_clustering(peak_list_for_clustering, verbose = TRUE)

## -----------------------------------------------------------------------------
cowplot::plot_grid(
    clustering$num_cluster_estimation$plot + labs(title = "Full"),
    clustering$num_cluster_estimation$plot +
        xlim(clustering$num_cluster_estimation$num_clusters-50, clustering$num_cluster_estimation$num_clusters+50) +
        ylim(0, 10*clustering$num_cluster_estimation$max_dist_thresh_ppb) +
        labs(title = "Fine region")
)

## -----------------------------------------------------------------------------
peak_list_clustered <- clustering$peak_data


## -----------------------------------------------------------------------------
nmr_peak_clustering_plot(
    dataset = dataset_norm,
    peak_list_clustered = peak_list_clustered,
    NMRExperiments = c("10", "20"),
    chemshift_range = c(2.4, 3.0)
)

## -----------------------------------------------------------------------------
nmr_peak_clustering_plot(
    dataset_norm,
    peak_list_clustered, 
    NMRExperiments = c("10", "20"),
    chemshift_range = c(4.2, 4.6),
    baselineThresh = baselineThresh
)

## -----------------------------------------------------------------------------
peak_table <- nmr_build_peak_table(peak_list_clustered, dataset_norm)
peak_table

## -----------------------------------------------------------------------------
peak_matrix <- nmr_data(peak_table)
peak_matrix[1:3, 1:8]

## -----------------------------------------------------------------------------
peak_table_df <- as.data.frame(peak_table)
peak_table_df

## -----------------------------------------------------------------------------
saveRDS(peak_table, "demo_peak_table.rds")

## -----------------------------------------------------------------------------
sessionInfo()

