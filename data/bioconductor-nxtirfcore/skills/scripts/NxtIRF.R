# Code example from 'NxtIRF' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("NxtIRFcore")

## -----------------------------------------------------------------------------
library(NxtIRFcore)

## -----------------------------------------------------------------------------
# Provides the path to the example genome:
chrZ_genome()

# Provides the path to the example gene annotation:
chrZ_gtf()

## ---- results='hide', message = FALSE, warning = FALSE------------------------
ref_path = file.path(tempdir(), "Reference")
BuildReference(
    reference_path = ref_path,
    fasta = chrZ_genome(),
    gtf = chrZ_gtf()
)

## -----------------------------------------------------------------------------
bams = NxtIRF_example_bams()
bams

## ---- results='hide', message = FALSE, warning = FALSE------------------------
irf_path = file.path(tempdir(), "IRFinder_output")
IRFinder(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = irf_path
)

## -----------------------------------------------------------------------------
expr = Find_IRFinder_Output(irf_path)

## ---- results='hide', message = FALSE, warning = FALSE------------------------
nxtirf_path = file.path(tempdir(), "NxtIRF_output")
CollateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtirf_path
)

## ---- results='hide', message = FALSE, warning = FALSE------------------------
se = MakeSE(nxtirf_path)

## -----------------------------------------------------------------------------
colData(se)$condition = rep(c("A", "B"), each = 3)
colData(se)$batch = rep(c("K", "L", "M"), 2)

## ---- results='hide', message = FALSE, warning = FALSE------------------------
# Requires limma to be installed:
require("limma")
res_limma = limma_ASE(
    se = se,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
)

# Requires DESeq2 to be installed:
require("DESeq2")
res_deseq = DESeq_ASE(
    se = se,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
)

# Requires DoubleExpSeq to be installed:
require("DoubleExpSeq")
res_DES = DoubleExpSeq_ASE(
    se = se,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
)

## -----------------------------------------------------------------------------
res_limma.filtered = subset(res_limma, abs(AvgPSI_A - AvgPSI_B) > 0.05)

## ---- fig.width = 8, fig.height = 6-------------------------------------------
p = Plot_Coverage(
    se = se,
    Event = res_limma.filtered$EventName[1],
    tracks = colnames(se)[c(1,2,4,5)],
)
as_egg_ggplot(p)

## ----eval = FALSE-------------------------------------------------------------
#  # Running this will display an interactive plot
#  p$final_plot

## ---- fig.width = 8, fig.height = 6-------------------------------------------
p = Plot_Coverage(
    se = se,
    Event = res_limma.filtered$EventName[1],
    tracks = c("A", "B"),
    condition = "condition",
    stack_tracks = TRUE,
    t_test = TRUE,
)
as_egg_ggplot(p)

## ----include = FALSE----------------------------------------------------------
# Reset to prevent interfering with next section
colData(se)$condition = NULL
colData(se)$batch = NULL

## ---- eval = FALSE------------------------------------------------------------
#  library(NxtIRFcore)

## ---- eval = FALSE------------------------------------------------------------
#  ref_path = file.path(tempdir(), "Reference")
#  
#  GetReferenceResource(
#      reference_path = ref_path,
#      fasta = chrZ_genome(),
#      gtf = chrZ_gtf()
#  )
#  
#  BuildReference(reference_path = ref_path)
#  
#  # or equivalently, in a one-step process:
#  
#  BuildReference(
#      reference_path = ref_path,
#      fasta = chrZ_genome(),
#      gtf = chrZ_gtf()
#  )
#  

## ---- eval = FALSE------------------------------------------------------------
#  bam_path = file.path(tempdir(), "bams")
#  
#  # Copies NxtIRF example BAM files to `bam_path` subdirectory; returns BAM paths
#  example_bams(path = bam_path)

## ----  eval = FALSE-----------------------------------------------------------
#  # as BAM file names denote their sample names
#  bams = Find_Bams(bam_path, level = 0)
#  
#  # In the case where BAM files are labelled using sample names as parent
#  # directory names (which oftens happens with the STAR aligner), use level = 1

## ---- eval = FALSE------------------------------------------------------------
#  irf_path = file.path(tempdir(), "IRFinder_output")
#  IRFinder(
#      bamfiles = bams$path,
#      sample_names = bams$sample,
#      reference_path = ref_path,
#      output_path = irf_path,
#      n_threads = 2,
#      overwrite = FALSE,
#      run_featureCounts = FALSE
#  )

## ---- eval = FALSE------------------------------------------------------------
#  # Re-run IRFinder without overwrite, and run featureCounts
#  require(Rsubread)
#  
#  IRFinder(
#      bamfiles = bams$path,
#      sample_names = bams$sample,
#      reference_path = ref_path,
#      output_path = irf_path,
#      n_threads = 2,
#      overwrite = FALSE,
#      run_featureCounts = TRUE
#  )
#  
#  # Load gene counts
#  gene_counts <- readRDS(file.path(irf_path, "main.FC.Rds"))
#  
#  # Access gene counts:
#  gene_counts$counts

## ---- eval = FALSE------------------------------------------------------------
#  expr <- Find_IRFinder_Output(irf_path)

## ---- eval = FALSE------------------------------------------------------------
#  nxtirf_path = file.path(tempdir(), "NxtIRF_output")
#  
#  CollateData(
#      Experiment = expr,
#      reference_path = ref_path,
#      output_path = nxtirf_path,
#      IRMode = "SpliceOverMax",
#      n_threads = 1
#  )

## ---- eval = FALSE------------------------------------------------------------
#  se = MakeSE(nxtirf_path, RemoveOverlapping = TRUE)

## ---- eval = FALSE------------------------------------------------------------
#  subset_samples = colnames(se)[1:4]
#  df = data.frame(sample = subset_samples)
#  se_small = MakeSE(nxtirf_path, colData = df, RemoveOverlapping = TRUE)

## ---- results = FALSE, message = FALSE, warning = FALSE-----------------------
expressed_events <- apply_filters(se, get_default_filters())

se.filtered = se[expressed_events,]

## -----------------------------------------------------------------------------
get_default_filters()

## -----------------------------------------------------------------------------
f1 = NxtFilter(filterClass = "Data", filterType = "Depth", minimum = 20)
f1

## ----eval=FALSE---------------------------------------------------------------
#  ?NxtFilter

## -----------------------------------------------------------------------------
colData(se.filtered)

## -----------------------------------------------------------------------------
colData(se.filtered)$condition = rep(c("A", "B"), each = 3)
colData(se.filtered)$batch = rep(c("K", "L", "M"), 2)

# To display what colData is:
as.data.frame(colData(se.filtered))

## -----------------------------------------------------------------------------
require("limma")

# Compare by condition-B vs condition-A

res_limma_condition <- limma_ASE(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
)

# Compare by condition-B vs condition-A, batch-corrected by "batch"

res_limma_treatment_batchcorrected <- limma_ASE(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    batch1 = "batch"
)

## ---- fig.width = 7, fig.height = 5-------------------------------------------
library(ggplot2)

ggplot(res_limma_condition, aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) + 
    geom_point() + xlim(0, 100) + ylim(0, 100) +
    labs(title = "PSI values across conditions",
         x = "PSI of condition B", y = "PSI of condition A")

## ---- fig.width = 7, fig.height = 5-------------------------------------------
ggplot(subset(res_limma_condition, EventType == "IR"), 
        aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) + 
    geom_point() + xlim(0, 100) + ylim(0, 100) +
    labs(title = "PIR values across conditions (IR Only)",
         x = "PIR of condition B", y = "PIR of condition A")

## ---- fig.width = 7, fig.height = 5-------------------------------------------
ggplot(res_limma_condition,
        aes(x = logFC, y = -log10(adj.P.Val))) + 
    geom_point() +
    labs(title = "Differential analysis - B vs A",
         x = "Log2-fold change", y = "BH-adjusted P values (-log10)")

## -----------------------------------------------------------------------------
mat = make_matrix(
    se.filtered,
    event_list = res_limma_condition$EventName[1:10],
    method = "PSI"
)

## ---- fig.width = 8, fig.height = 6-------------------------------------------
library(pheatmap)

pheatmap(mat, annotation_col = as.data.frame(colData(se.filtered)))

## ---- fig.width = 8, fig.height = 6-------------------------------------------
res = Plot_Coverage(
    se = se.filtered, 
    Gene = "TP53", 
    tracks = colnames(se.filtered)[1]
)

as_egg_ggplot(res)

## ----eval = FALSE-------------------------------------------------------------
#  # Running this will display an interactive plot
#  res$final_plot

## ---- fig.width = 8, fig.height = 6-------------------------------------------
res = Plot_Coverage(
    se = se.filtered, 
    Gene = "TP53",
    tracks = colnames(se.filtered)[1],
    condense_tracks = TRUE
)
as_egg_ggplot(res)

## ---- fig.width = 8, fig.height = 6-------------------------------------------
res = Plot_Coverage(
    se = se.filtered, 
    Gene = "TP53",
    tracks = colnames(se.filtered)[1],
    selected_transcripts = c("TP53-201", "TP53-204")
)
as_egg_ggplot(res)

## -----------------------------------------------------------------------------
colData(se.filtered)$NSUN5_IR = c(rep("High", 2), rep("Low", 4))

## -----------------------------------------------------------------------------
require("limma")

res_limma_NSUN5 <- limma_ASE(
    se = se.filtered,
    test_factor = "NSUN5_IR",
    test_nom = "High",
    test_denom = "Low",
)

head(res_limma_NSUN5$EventName)

## ---- fig.width = 8, fig.height = 6-------------------------------------------
res = Plot_Coverage(
    se = se.filtered, 
    Event = res_limma_NSUN5$EventName[1],
    condition = "NSUN5_IR",
    tracks = c("High", "Low"),
)
as_egg_ggplot(res)

## ---- fig.width = 8, fig.height = 6-------------------------------------------
res = Plot_Coverage(
    se = se.filtered, 
    Event = "NSUN5/ENST00000252594_Intron2/clean",
    condition = "NSUN5_IR",
    tracks = c("High", "Low"),
    stack_tracks = TRUE,
    t_test = TRUE
)
as_egg_ggplot(res)

## ----eval = FALSE-------------------------------------------------------------
#  library(NxtIRFcore)

## ----eval = FALSE-------------------------------------------------------------
#  ref_path = "./Reference"

## ----eval=FALSE---------------------------------------------------------------
#  BuildReference(
#      reference_path = ref_path,
#      fasta = "genome.fa", gtf = "transcripts.gtf",
#      genome_type = "hg38"
#  )

## ----eval=FALSE---------------------------------------------------------------
#  FTP = "ftp://ftp.ensembl.org/pub/release-94/"
#  
#  BuildReference(
#      reference_path = ref_path,
#      fasta = paste0(FTP, "fasta/homo_sapiens/dna/",
#          "Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"),
#      gtf = paste0(FTP, "gtf/homo_sapiens/",
#          "Homo_sapiens.GRCh38.94.chr.gtf.gz"),
#      genome_type = "hg38"
#  )

## -----------------------------------------------------------------------------
require(AnnotationHub)

ah = AnnotationHub()
query(ah, "Ensembl")

## -----------------------------------------------------------------------------
query(ah, c("Homo Sapiens", "release-94"))

## ----eval=FALSE---------------------------------------------------------------
#  BuildReference(
#      reference_path = ref_path,
#      fasta = "AH65745",
#      gtf = "AH64631",
#      genome_type = "hg38"
#  )

## ----eval=FALSE---------------------------------------------------------------
#  BuildReference(
#      reference_path = ref_path,
#      fasta = "genome.fa", gtf = "transcripts.gtf",
#      genome_type = ""
#  )

## ----eval=FALSE---------------------------------------------------------------
#  BuildReference_Full(
#      reference_path = ref_path,
#      fasta = "genome.fa", gtf = "transcripts.gtf",
#      genome_type = "",
#      use_STAR_mappability = TRUE,
#      n_threads = 4
#  )

## ----eval = FALSE-------------------------------------------------------------
#  # (1a) Creates genome resource files
#  
#  ref_path = file.path(tempdir(), "Reference")
#  
#  GetReferenceResource(
#      reference_path = ref_path,
#      fasta = chrZ_genome(),
#      gtf = chrZ_gtf()
#  )
#  
#  # (1b) Systematically generate reads based on the NxtIRF example genome:
#  
#  Mappability_GenReads(
#      reference_path = ref_path
#  )
#  
#  # (2) Align the generated reads using Rsubread:
#  
#  # (2a) Build the Rsubread genome index:
#  
#  setwd(ref_path)
#  Rsubread::buildindex(basename = "./reference_index",
#      reference = chrZ_genome())
#  
#  # (2b) Align the synthetic reads using Rsubread::subjunc()
#  
#  Rsubread::subjunc(
#      index = "./reference_index",
#      readfile1 = file.path(ref_path, "Mappability", "Reads.fa"),
#      output_file = file.path(ref_path, "Mappability", "AlignedReads.bam"),
#      useAnnotation = TRUE,
#      annot.ext = chrZ_gtf(),
#      isGTF = TRUE
#  )
#  
#  # (3) Analyse the aligned reads in the BAM file for low-mappability regions:
#  
#  Mappability_CalculateExclusions(
#      reference_path = ref_path,
#      aligned_bam = file.path(ref_path, "Mappability", "AlignedReads.bam")
#  )
#  
#  # (4) Build the NxtIRF reference using the calculated Mappability Exclusions
#  
#  BuildReference(ref_path)
#  

## -----------------------------------------------------------------------------
STAR_version()

## ----eval = FALSE-------------------------------------------------------------
#  
#  ref_path = "./Reference"
#  
#  # Ensure genome resources are prepared from genome FASTA and GTF file:
#  
#  if(!file.exists(file.path(ref_path, "resources"))) {
#      GetReferenceResource(
#          reference_path = ref_path,
#          fasta = "genome.fa",
#          gtf = "transcripts.gtf"
#      )
#  }
#  
#  # Generate a STAR genome reference:
#  STAR_BuildRef(
#      reference_path = ref_path,
#      n_threads = 8
#  )
#  

## ----eval = FALSE-------------------------------------------------------------
#  STAR_align_fastq(
#      STAR_ref_path = file.path(ref_path, "STAR"),
#      BAM_output_path = "./bams/sample1",
#      fastq_1 = "sample1_1.fastq", fastq_2 = "sample1_2.fastq",
#      n_threads = 8
#  )

## ----eval = FALSE-------------------------------------------------------------
#  Experiment = data.frame(
#      sample = c("sample_A", "sample_B"),
#      forward = file.path("raw_data", c("sample_A", "sample_B"),
#          c("sample_A_1.fastq", "sample_B_1.fastq")),
#      reverse = file.path("raw_data", c("sample_A", "sample_B"),
#          c("sample_A_2.fastq", "sample_B_2.fastq"))
#  )
#  
#  STAR_align_experiment(
#      Experiment = Experiment,
#      STAR_ref_path = file.path("Reference_FTP", "STAR"),
#      BAM_output_path = "./bams",
#      n_threads = 8,
#      two_pass = FALSE
#  )

## ----eval=FALSE---------------------------------------------------------------
#  bams = Find_Bams("./bams", level = 1)

## ----eval=FALSE---------------------------------------------------------------
#  # assume NxtIRF reference has been generated in `ref_path`
#  
#  IRFinder(
#      bamfiles = bams$path,
#      sample_names = bams$sample,
#      reference_path = ref_path,
#      output_path = "./IRFinder_output",
#      n_threads = 4,
#      Use_OpenMP = TRUE
#  )

## ----eval=FALSE---------------------------------------------------------------
#  
#  BAM2COV(
#      bamfiles = bams$path,
#      sample_names = bams$sample,
#      output_path = "./IRFinder_output",
#      n_threads = 4,
#      Use_OpenMP = TRUE
#  )

## ----eval=FALSE---------------------------------------------------------------
#  expr = Find_IRFinder_Output("./IRFinder_output")

## ----eval = FALSE-------------------------------------------------------------
#  CollateData(
#      Experiment = expr,
#      reference_path = ref_path,
#      output_path = "./NxtIRF_output"
#  )

## ----eval = FALSE-------------------------------------------------------------
#  se = MakeSE("./NxtIRF_output")

## -----------------------------------------------------------------------------
sessionInfo()

