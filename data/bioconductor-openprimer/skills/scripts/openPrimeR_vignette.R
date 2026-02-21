# Code example from 'openPrimeR_vignette' vignette. See references/ for full tutorial.

## ----vignette_options, echo = FALSE, message = FALSE, warning = FALSE---------
options(rmarkdown.html_vignette.check_title = FALSE)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(openPrimeR)
ggplot2::theme_set(ggplot2::theme_grey(base_size = 12)) 

## ----check_dependencies, message = FALSE, warning = FALSE, eval = FALSE-------
# library(openPrimeR)

## ----loading_data_table, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'----
tabl <- "
| Task             | Templates | Primers      | Input file format  |
|------------------|-----------|--------------|--------------------|
| Design primers   | &#10003;  |              | FASTA, CSV         |
| Analyze primers  | &#10003;  | &#10003;     | FASTA, CSV         |
| Compare primers  | &#10003;  | &#10003;     | FASTA, CSV         |
"
cat(tabl) # output the table in a format good for HTML/PDF/docx conversion

## ----simple_load_templates, message = FALSE, warning = FALSE------------------
# Specify a FASTA file containing the templates:
fasta.file <- system.file("extdata", "IMGT_data", "templates", 
                "Homo_sapiens_IGH_functional_exon.fasta", package = "openPrimeR")
# Load the template sequences from 'fasta.file'
seq.df.simple <- read_templates(fasta.file)

## ----header_structure, message = FALSE, warning = FALSE-----------------------
seq.df.simple$Header[1]

## ----load_templates, message = FALSE, warning = FALSE-------------------------
hdr.structure <- c("ACCESSION", "GROUP", "SPECIES", "FUNCTION")
seq.df <- read_templates(fasta.file, hdr.structure, delim = "|", id.column = "GROUP")

## ----loaded_header_structure, message = FALSE, warning = FALSE----------------
# Show the loaded metadata for the first template
c(seq.df$Accession[1], seq.df$Group[1], seq.df$Species[1], seq.df$Function[1])
# Show the ID (group) of the first template
seq.df$ID[1]

## ----default_binding_regions, message = FALSE, warning = FALSE----------------
# Show the binding region of the first template for forward primers
seq.df$Allowed_fw[1]
# Show the corresponding interval in the templates
c(seq.df$Allowed_Start_fw[1], seq.df$Allowed_End_fw[1])
# Show the binding region of the first template for reverse primers
seq.df$Allowed_rev[1]
# Show the corresponding interval in the templates
c(seq.df$Allowed_Start_rev[1], seq.df$Allowed_End_rev[1])

## ----assign_uniform_binding, message = FALSE, warning = FALSE-----------------
template.df.uni <- assign_binding_regions(seq.df, fw = c(1,50), rev = c(1,40))

## ----uniform_binding_regions, message = FALSE, warning = FALSE----------------
# Show the new forward binding region (first 50 bases)
template.df.uni$Allowed_fw[1]
# Show the new reverse binding region (last 40 bases)
template.df.uni$Allowed_rev[1]

## ----assign_individual_binding, message = FALSE, warning = FALSE--------------
l.fasta.file <- system.file("extdata", "IMGT_data", "templates", 
                "Homo_sapiens_IGH_functional_leader.fasta", package = "openPrimeR")
template.df <- assign_binding_regions(seq.df, fw = l.fasta.file, rev = NULL)

## ----assign_individual_binding_out, message = FALSE, warning = FALSE----------
# An example of two templates with different binding regions
c(template.df$Allowed_Start_fw[1], template.df$Allowed_End_fw[1])
c(template.df$Allowed_Start_fw[150], template.df$Allowed_End_fw[150])

## ----assign_individual_binding_example_rev, message = FALSE, warning = FALSE----
# Verify that the binding region for reverse primers did not change for the first template:
template.df$Allowed_rev[1]

## ----available_settings, message = FALSE, warning = FALSE---------------------
list.files(system.file("extdata", "settings", package = "openPrimeR"), pattern = "*\\.xml")

## ----load_settings, message = FALSE, warning = FALSE--------------------------
settings.xml <- system.file("extdata", "settings", 
                    "C_Taq_PCR_high_stringency.xml", package = "openPrimeR")
settings <- read_settings(settings.xml)

## ----settings_slots, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'----
tabl <- "
| Slot             | Getter/Setter |  Purpose |
|------------------|---------------|----------|
| `Input_Constraints` | `constraints()` | Desired values for primer properties |
| `Input_Constraint_Boundaries` | `constraintLimits()`  | Limits for relaxing constraints during primer design |
| `Coverage_Constraints` | `cvg_constraints()` | Constraints for estimating the coverage |
| `PCR_conditions` | `PCR()`  | Experimental PCR conditions |
| `constraint_settings` | `conOptions()` | Settings for evaluating the constraints |

"
cat(tabl) # output the table in a format good for HTML/PDF/docx conversion

## ----cvg_constraint_setup, message = FALSE, warning = FALSE-------------------
# No constraints on primer coverage (not recommended!)
cvg_constraints(settings) <- list()
# Instead consider all primers binding with up to 3 mismatches to cover the corresponding templates
conOptions(settings)$allowed_mismatches <- 3

## ----change_settings1, message = FALSE, warning = FALSE-----------------------
design.settings <- settings
constraints(design.settings) <- constraints(design.settings)[!grepl(
                            "gc_clamp", names(constraints(design.settings)))]

## ----change_settings2, message = FALSE, warning = FALSE-----------------------
constraints(design.settings)[["primer_length"]] <- c("min" = 25, "max" = 25)

## ----change_settings3, message = FALSE, warning = FALSE-----------------------
conOptions(design.settings)[["allowed_mismatches"]] <- 0

## ----write_settings, message = FALSE, warning = FALSE, eval = FALSE-----------
# out.file <- tempfile("settings", fileext = ".xml")
# write_settings(design.settings, out.file)

## ----design_primers, message = FALSE, warning = FALSE, eval = TRUE------------
# Design forward primers for the first two templates
optimal.primers <- design_primers(template.df[1:2,], mode.directionality = "fw",
                                  settings = design.settings)

## ----store_primers, message = FALSE, warning = FALSE, eval = FALSE------------
# out.file <- tempfile("my_primers", fileext = ".fasta")
# write_primers(optimal.primers$opti, out.file)

## ----read_primers, message = FALSE, warning = FALSE---------------------------
# Define the FASTA primer file to load
primer.location <- system.file("extdata", "IMGT_data", "primers", "IGHV", 
                               "Ippolito2012.fasta", package = "openPrimeR")
# Load the primers
primer.df <- read_primers(primer.location, fw.id = "_fw")

## ----view_primers, message = FALSE, warning = FALSE---------------------------
print(primer.df[, c("ID", "Forward")]) 

## ----check_constraints, message = FALSE, warning = FALSE----------------------
# Allow off-target coverage
conOptions(settings)$allowed_other_binding_ratio <- c("max" = 1.0)
# Evaluate all constraints found in 'settings'
constraint.df <- check_constraints(primer.df, template.df, 
                 settings, active.constraints = names(constraints(settings)))

## ----view_primer_coverage, message = FALSE, warning = FALSE-------------------
constraint.df$primer_coverage

## ----update_template_cvg, message = FALSE, warning = FALSE--------------------
template.df <- update_template_cvg(template.df, constraint.df)

## ----template_coverage, message = FALSE, warning = FALSE----------------------
template.df$primer_coverage[1:5]

## ----cvg_ratio, message = FALSE, warning = FALSE------------------------------
as.numeric(get_cvg_ratio(constraint.df, template.df))

## ----cvg_stats, message = FALSE, warning = FALSE------------------------------
cvg.stats <- get_cvg_stats(constraint.df, template.df, for.viewing = TRUE)

## ----cvg_table, echo=FALSE, results='asis'------------------------------------
knitr::kable(cvg.stats[, !(grepl("_fw", colnames(cvg.stats)) | grepl("_rev", colnames(cvg.stats)))], row.names = FALSE)

## ----template_cvg_plot, fig.show='hold', fig.width=5, fig.height=5------------
plot_template_cvg(constraint.df, template.df)

## ----primer_subsets, message = FALSE, warning = FALSE-------------------------
primer.subsets <- subset_primer_set(constraint.df, template.df)

## ----cvg_subsets, fig.show='hold', fig.width=5, fig.height=5------------------
plot_primer_subsets(primer.subsets, template.df)

## ----optimal_subsets, message = FALSE, warning = FALSE------------------------
my.primer.subset <- primer.subsets[[3]]

## ----verify_optimal_subset, message = FALSE, warning = FALSE------------------
original.cvg <- as.character(get_cvg_ratio(constraint.df, template.df, as.char = TRUE))
subset.cvg <- as.character(get_cvg_ratio(my.primer.subset, template.df, as.char = TRUE))
print(paste0("Coverage (n=", nrow(constraint.df), "): ", original.cvg, "; Subset Coverage (n=", nrow(my.primer.subset), "): ", subset.cvg))

## ----binding_regions, message = FALSE, warning = FALSE, fig.show='hold', fig.width=5, fig.height=5----
plot_primer_binding_regions(constraint.df, template.df)

## ----cvg_primer_view, message = FALSE, warning = FALSE, fig.show='hold', fig.width=8, fig.height=8----
plot_primer(constraint.df[1,], template.df[1:10,])

## ----plot_constraints, fig.show='hold', fig.width=7, fig.height=7, message = FALSE, warning = FALSE----
plot_constraint_fulfillment(constraint.df, settings)

## ----constraint_eval_gc, message = FALSE, warning = FALSE---------------------
# View the number of terminal GCs for primers failing the GC constraint
constraint.df$gc_clamp_fw[!constraint.df$EVAL_gc_clamp]
# View the desired number of terminal GCs:
constraints(settings)$gc_clamp

## ----plot_constraint_qualitative, fig.show='hold', fig.width=5, fig.height=5, message = FALSE, warning = FALSE----
plot_constraint(constraint.df, settings, "gc_clamp")

## ----primer_filtering, message = FALSE, warning = FALSE-----------------------
filtered.df <- filter_primers(constraint.df, template.df, settings,
               active.constraints = c("gc_clamp", "gc_ratio"))

## ----eval_report, message = FALSE, warning = FALSE, eval = FALSE--------------
# # Define the path to the output file
# my.file <- tempfile(fileext = ".pdf")
# # Store a PDF report for 'constraint.df' in 'my.file'
# create_report(constraint.df, template.df, my.file,
#               settings, sample.name = "My analysis")

## ----writing_comparison_data, message = FALSE, warning = FALSE----------------
primer.xml <- tempfile("my_primers", fileext =".csv")
write_primers(constraint.df, primer.xml, "CSV")
template.xml <- tempfile("my_templates", fileext = ".csv")
write_templates(constraint.df, template.xml, "CSV")

## ----loading_comparison_data, message = FALSE, warning = FALSE----------------
# Define the primer sets we want to load
sel.sets <- c("Glas1999", "Rubinstein1998", "Cardona1995", "Persson1991", "Ippolito2012", "Scheid2011")
# List all available IGH primer sets
primer.files <- list.files(path = system.file("extdata", "IMGT_data", "comparison", 
                           "primer_sets", "IGH", package = "openPrimeR"),
                pattern = "*\\.csv", full.names = TRUE)
# Load all available primer sets
primer.data <- read_primers(primer.files)
# Select only the sets defined via 'sel.sets'
sel.idx <- which(names(primer.data) %in% sel.sets)
primer.data <- primer.data[sel.idx]
# Provide a set of templates for every primer set
template.files <- rep(system.file("extdata", "IMGT_data", "comparison", "templates", 
                              "IGH_templates.csv", package = "openPrimeR"), 
                              length(primer.data))
template.data <- read_templates(template.files)

## ----comparison_plots_overview, fig.show='hold', fig.width=7, fig.height=7, message = FALSE----
plot_constraint_fulfillment(primer.data, settings, plot.p.vals = FALSE)

## ----comparison_plots_details, fig.show='hold', fig.width=7, fig.height=7, message = FALSE----
plot_constraint(primer.data, settings, active.constraints = c("gc_ratio", "melting_temp_range"))

## ----comparison_primer_binding, fig.show='hold', fig.width=7, fig.height=7, message = FALSE----
plot_primer_binding_regions(primer.data, template.data)

