# ReUseData: Reusable and Reproducible Data Management

Qian Liu, Qiang Hu, Song Liu, Alan Hutson, Martin Morgan1

1Roswell Park Comprehensive Cancer Center

#### 2025-10-30

`ReUseData` provides functionalities to construct workflow-based data
recipes for fully tracked and reproducible data processing. Evaluation
of data recipes generates curated data resources in their generic
formats (e.g., VCF, bed), as well as a YAML manifest file recording
the recipe parameters, data annotations, and data file paths for
subsequent reuse. The datasets are locally cached using a database
infrastructure, where updating and searching of specific data is made easy.

The data reusability is assured through cloud hosting and enhanced
interoperability with downstream software tools or analysis
workflows. The workflow strategy enables cross platform
reproducibility of curated data resources.

# 1 Installation

1. Install the package from *Bioconductor*.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ReUseData")
```

Use the development version:

```
BiocManager::install("ReUseData", version = "devel")
```

2. Load the package and other packages used in this vignette into the
   R session.

```
suppressPackageStartupMessages(library(Rcwl))
library(ReUseData)
```

# 2 `ReUseData` core functions for data management

Here we introduce the core functions of `ReUseData` for data
management and reuse: `getData` for reproducible data generation,
`dataUpdate` for syncing and updating data cache, and `dataSearch` for
multi-keywords searching of dataset of interest.

## 2.1 Data generation

First, we can construct data recipes by transforming shell or other ad
hoc data preprocessing scripts into workflow-based data recipes. Some
prebuilt data recipes for public data resources (e.g., downloading,
unzipping and indexing) are available for direct use through
`recipeSearch` and `recipeLoad` functions. Then we will assign values
to the input parameters and evaluate the recipe to generate data of
interest.

```
## set cache in tempdir for test
Sys.setenv(cachePath = file.path(tempdir(), "cache"))

recipeUpdate()
#> Updating recipes...
#> STAR_index.R added
#> bowtie2_index.R added
#> echo_out.R added
#> ensembl_liftover.R added
#> gcp_broad_gatk_hg19.R added
#> gcp_broad_gatk_hg38.R added
#> gcp_gatk_mutect2_b37.R added
#> gcp_gatk_mutect2_hg38.R added
#> gencode_annotation.R added
#> gencode_genome_grch38.R added
#> gencode_transcripts.R added
#> hisat2_index.R added
#> reference_genome.R added
#> salmon_index.R added
#> ucsc_database.R added
#>
#> recipeHub with 15 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC1  | STAR_index
#>   BFC2  | bowtie2_index
#>   BFC3  | echo_out
#>   BFC4  | ensembl_liftover
#>   BFC5  | gcp_broad_gatk_hg19
#>   ...     ...
#>   BFC11 | gencode_transcripts
#>   BFC12 | hisat2_index
#>   BFC13 | reference_genome
#>   BFC14 | salmon_index
#>   BFC15 | ucsc_database
recipeSearch("echo")
#> recipeHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>          name
#>   BFC3 | echo_out
echo_out <- recipeLoad("echo_out")
#> Note: you need to assign a name for the recipe: rcpName <- recipeLoad('xx')
#> Data recipe loaded!
#> Use inputs() to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/echo_out.html
#> for user instructions (e.g., eligible input values, data source, etc.)
inputs(echo_out)
#> inputs:
#>   input (input)  (string):
#>   outfile (outfile)  (string):
```

Users can then assign values to the input parameters, and evaluate the
recipe (`getData`) to generate data of interest. Users need to specify
an output directory for all files (desired data file, intermediate
files that are internally generated as workflow scripts or annotation
files). Detailed notes for the data is encouraged which will be used
for keywords matching for later data search.

We can install cwltool first to make sure a cwl-runner is available.

```
invisible(Rcwl::install_cwltool())
```

```
echo_out$input <- "Hello World!"
echo_out$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(echo_out,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))
#> }[1;30mINFO[0m Final process status is success
```

The file path to newly generated dataset can be easily retrieved. It
can also be retrieved using `dataSearch()` functions with multiple
keywords. Before that, `dataUpdate()` needs to be done.

```
res$output
#> [1] "/tmp/RtmpIAiCac/SharedData/outfile.txt"
```

There are some automatically generated files to help track the data
recipe evaluation, including `*.sh` to record the original shell
script, `*.cwl` file as the official workflow script which was
internally submitted for data recipe evaluation, `*.yml` file as part
of CWL workflow evaluation, which also record data annotations, and
`*.md5` checksum file to check/verify the integrity of generated data
file.

```
list.files(outdir, pattern = "echo")
#> [1] "echo_out_Hello_World!_outfile.cwl" "echo_out_Hello_World!_outfile.md5"
#> [3] "echo_out_Hello_World!_outfile.sh"  "echo_out_Hello_World!_outfile.yml"
```

The `*.yml` file contains information about recipe input parameters,
the file path to output file, the notes for the dataset, and
auto-added date for data generation time. A later data search using
`dataSearch()` will refer to this file for keywords match.

```
readLines(res$yml)
#> [1] "input: Hello World!"
#> [2] "outfile: outfile"
#> [3] "# output: /tmp/RtmpIAiCac/SharedData/outfile.txt"
#> [4] "# notes: echo hello world txt"
#> [5] "# date: 2025-10-30 02:01:44.25757"
```

## 2.2 Data caching, updating and searching

`dataUpdate()` creates (if first time use), syncs and updates the local
cache for curated datasets. It finds and reads all the `.yml` files
recursively in the provided data folder, creates a cache record for
each dataset that is associated (including newly generated ones with
`getData()`), and updates the local cache for later data searching and
reuse.

**IMPORTANT:** It is recommended that users create a specified folder for
data archival (e.g., `file/path/to/SharedData`) that other group
members have access to, and use sub-folders for different kinds of
datasets (e.g., those generated from same recipe).

```
(dh <- dataUpdate(dir = outdir))
#>
#> Updating data record...
#> outfile.txt added
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
```

`dataUpdate` and `dataSearch` return a `dataHub` object with a list of
all available or matching datasets.

One can subset the list with `[` and use getter functions to retrieve
the annotation information about the data, e.g., data names,
parameters values to the recipe, notes, tags, and the corresponding
yaml file.

```
dh[1]
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
## dh["BFC1"]
dh[dataNames(dh) == "outfile.txt"]
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
dataNames(dh)
#> [1] "outfile.txt"
dataParams(dh)
#> [1] "input: Hello World!; outfile: outfile"
dataNotes(dh)
#> [1] "echo hello world txt"
dataTags(dh)
#> [1] ""
dataYml(dh)
#> [1] "/tmp/RtmpIAiCac/SharedData/echo_out_Hello_World!_outfile.yml"
```

`ReUseData`, as the name suggests, commits to promoting the data reuse.
Data can be prepared in standard input formats (`toList`), e.g.,
YAML and JSON, to be easily integrated in workflow methods that are
locally or cloud-hosted.

```
(dh1 <- dataSearch(c("echo", "hello", "world")))
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
toList(dh1, listNames = c("input_file"))
#> $input_file
#> [1] "/tmp/RtmpIAiCac/SharedData/outfile.txt"
toList(dh1, format = "yaml", listNames = c("input_file"))
#> [1] "input_file: /tmp/RtmpIAiCac/SharedData/outfile.txt"
toList(dh1, format = "json", file = file.path(tempdir(), "data.json"))
#> File is saved as: "/tmp/RtmpIAiCac/data.json"
#> {
#>   "outfile.txt": "/tmp/RtmpIAiCac/SharedData/outfile.txt"
#> }
```

Data can also be aggregated from different resources by tagging with
specific software tools.

```
dataSearch()
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
dataTags(dh[1]) <- "#gatk"
dataSearch("#gatk")
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
```

## 2.3 Existing data annotation

The package can also be used to add annotation and notes to existing
data resources or experiment data for management. Here we add
exisiting “exp\_data” to local data repository.

```
exp_data <- file.path(tempdir(), "exp_data")
dir.create(exp_data)
```

We first add notes to the data, and then update data repository with
information from the new dataset.

```
annData(exp_data, notes = c("experiment data"))
#> meta.yml added
#> [1] "/tmp/RtmpIAiCac/exp_data/meta.yml"
dataUpdate(exp_data)
#>
#> Updating data record...
#> exp_data added
#> dataHub with 2 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name        Path
#>   BFC1 | outfile.txt /tmp/RtmpIAiCac/SharedData/outfile.txt
#>   BFC2 | exp_data    /tmp/RtmpIAiCac/exp_data
```

Now our data hub cached meta information from two different
directories, one from data recipe and one from exisiting data. Data
can be retrieved by keywords.

```
dataSearch("experiment")
#> dataHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>          name     Path
#>   BFC2 | exp_data /tmp/RtmpIAiCac/exp_data
```

**NOTE:** if the argument `cloud=TRUE` is enabled, `dataUpdate()` will
also cache the pregenerated data sets (from evaluation of public
ReUseData recipes) that are available on ReUseData google bucket and
return in the `dataHub` object that are fully searchable. Please see
the following section for details.

# 3 Cloud data resources

With the prebuilt data recipes for curation (e.g., downloading,
unzipping, indexing) of commonly used public data resources we have
pregenerated some data sets and put them on the cloud space for direct
use.

Before searching, one need to use `dataUpdate(cloud=TRUE)` to sync the
existing data sets on cloud, then `dataSearch()` can be used to search
any available data set either in local cache and on the cloud.

```
gcpdir <- file.path(tempdir(), "gcpData")
dataUpdate(gcpdir, cloud=TRUE)
#>
#> Updating data record...
#> 2948102da2c54c_GRCh38.primary_assembly.genome.fa.1.bt2 added
#> 29481073c823b5_GRCh38.primary_assembly.genome.fa.2.bt2 added
#> 2948101e31cb19_GRCh38.primary_assembly.genome.fa.3.bt2 added
#> 2948101725f63f_GRCh38.primary_assembly.genome.fa.4.bt2 added
#> 2948106b5acf7_GRCh38.primary_assembly.genome.fa.rev.1.bt2 added
#> 2948105524f365_GRCh38.primary_assembly.genome.fa.rev.2.bt2 added
#> 2948105d6de4da_outfile.txt added
#> 29481050d0a360_GRCh37_to_GRCh38.chain added
#> 294810712600d6_GRCh37_to_NCBI34.chain added
#> 29481016d98650_GRCh37_to_NCBI35.chain added
#> 29481048513d43_GRCh37_to_NCBI36.chain added
#> 294810351257d_GRCh38_to_GRCh37.chain added
#> 29481064f7fd25_GRCh38_to_NCBI34.chain added
#> 29481044d61a2e_GRCh38_to_NCBI35.chain added
#> 294810724c94a3_GRCh38_to_NCBI36.chain added
#> 294810495d11cb_NCBI34_to_GRCh37.chain added
#> 2948105a73f951_NCBI34_to_GRCh38.chain added
#> 29481076e45903_NCBI35_to_GRCh37.chain added
#> 29481066a007c3_NCBI35_to_GRCh38.chain added
#> 2948106ad6337c_NCBI36_to_GRCh37.chain added
#> 2948104f698374_NCBI36_to_GRCh38.chain added
#> 29481061dd71c9_GRCm38_to_NCBIM36.chain added
#> 294810a40c600_GRCm38_to_NCBIM37.chain added
#> 29481028e19e59_NCBIM36_to_GRCm38.chain added
#> 2948106c15bc6b_NCBIM37_to_GRCm38.chain added
#> 29481034a0f7a6_1000G_omni2.5.b37.vcf.gz added
#> 294810622b81ad_1000G_omni2.5.b37.vcf.gz.tbi added
#> 294810549440af_Mills_and_1000G_gold_standard.indels.b37.vcf.gz added
#> 29481023f17437_Mills_and_1000G_gold_standard.indels.b37.vcf.gz.tbi added
#> 294810860ae7f_1000G_omni2.5.hg38.vcf.gz added
#> 294810584a628c_1000G_omni2.5.hg38.vcf.gz.tbi added
#> 29481051943983_Mills_and_1000G_gold_standard.indels.hg38.vcf.gz added
#> 2948107c28d234_Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi added
#> 294810767c2da5_af-only-gnomad.raw.sites.vcf added
#> 29481068ba2fc2_af-only-gnomad.raw.sites.vcf.idx added
#> 2948102de7f2b_Mutect2-exome-panel.vcf.idx added
#> 2948104ba1210a_Mutect2-WGS-panel-b37.vcf added
#> 2948104628149c_Mutect2-WGS-panel-b37.vcf.idx added
#> 29481053af228b_small_exac_common_3.vcf added
#> 2948103cc721e1_small_exac_common_3.vcf.idx added
#> 2948105d019aec_1000g_pon.hg38.vcf.gz added
#> 2948101c005fce_1000g_pon.hg38.vcf.gz.tbi added
#> 2948104018475e_af-only-gnomad.hg38.vcf.gz added
#> 29481041f99812_af-only-gnomad.hg38.vcf.gz.tbi added
#> 29481060d679fc_small_exac_common_3.hg38.vcf.gz added
#> 2948103264dc01_small_exac_common_3.hg38.vcf.gz.tbi added
#> 294810b56a9dd_gencode.v41.annotation.gtf added
#> 2948103b4a734d_gencode.v42.annotation.gtf added
#> 29481029493505_gencode.vM30.annotation.gtf added
#> 29481071f6b1a1_gencode.vM31.annotation.gtf added
#> 2948102620a6c9_gencode.v41.transcripts.fa added
#> 29481078b2b879_gencode.v41.transcripts.fa.fai added
#> 29481053d4236a_gencode.v42.transcripts.fa added
#> 29481030616cc9_gencode.v42.transcripts.fa.fai added
#> 294810219456d2_gencode.vM30.pc_transcripts.fa added
#> 2948103fe9dfd5_gencode.vM30.pc_transcripts.fa.fai added
#> 29481065026470_gencode.vM31.pc_transcripts.fa added
#> 2948103bfd87f_gencode.vM31.pc_transcripts.fa.fai added
#> 294810147e2084_GRCh38.primary_assembly.genome.fa.1.ht2 added
#> 2948108f3d8a7_GRCh38.primary_assembly.genome.fa.2.ht2 added
#> 294810c2086fe_GRCh38.primary_assembly.genome.fa.3.ht2 added
#> 2948106cc88310_GRCh38.primary_assembly.genome.fa.4.ht2 added
#> 2948105a88122a_GRCh38.primary_assembly.genome.fa.5.ht2 added
#> 2948108495932_GRCh38.primary_assembly.genome.fa.6.ht2 added
#> 2948106344b0b5_GRCh38.primary_assembly.genome.fa.7.ht2 added
#> 294810434241ed_GRCh38.primary_assembly.genome.fa.8.ht2 added
#> 294810b27d85d_GRCh38_full_analysis_set_plus_decoy_hla.fa.fai added
#> 2948102ee5d1c0_GRCh38_full_analysis_set_plus_decoy_hla.fa.amb added
#> 29481096a5689_GRCh38_full_analysis_set_plus_decoy_hla.fa.ann added
#> 2948105ed6fae8_GRCh38_full_analysis_set_plus_decoy_hla.fa.bwt added
#> 2948106bacf3a1_GRCh38_full_analysis_set_plus_decoy_hla.fa.pac added
#> 294810666bf176_GRCh38_full_analysis_set_plus_decoy_hla.fa.sa added
#> 2948107ad75ab6_GRCh38_full_analysis_set_plus_decoy_hla.fa added
#> 2948102bc53aff_GRCh38.primary_assembly.genome.fa.fai added
#> 29481028658988_GRCh38.primary_assembly.genome.fa.amb added
#> 2948105badd4b3_GRCh38.primary_assembly.genome.fa.ann added
#> 2948105e2a1700_GRCh38.primary_assembly.genome.fa.bwt added
#> 29481033bc3365_GRCh38.primary_assembly.genome.fa.pac added
#> 29481016f84800_GRCh38.primary_assembly.genome.fa.sa added
#> 2948107734c05_GRCh38.primary_assembly.genome.fa added
#> 29481025b2e506_hs37d5.fa.fai added
#> 2948103d18eeca_hs37d5.fa.amb added
#> 29481026047e_hs37d5.fa.ann added
#> 29481079870871_hs37d5.fa.bwt added
#> 2948106d7a5b93_hs37d5.fa.pac added
#> 29481021ba5b51_hs37d5.fa.sa added
#> 2948103970e846_hs37d5.fa added
#> 294810527cc003_complete_ref_lens.bin added
#> 294810257a33d0_ctable.bin added
#> 2948104def08cb_ctg_offsets.bin added
#> 2948105b7098aa_duplicate_clusters.tsv added
#> 294810319abacf_info.json added
#> 2948103ab78bdb_mphf.bin added
#> 29481035f8aad5_pos.bin added
#> 29481039e41401_pre_indexing.log added
#> 2948101dfc3c91_rank.bin added
#> 294810793aecc2_ref_indexing.log added
#> 294810450bec5f_refAccumLengths.bin added
#> 2948104ce20e51_reflengths.bin added
#> 2948102a5434b_refseq.bin added
#> 29481023e2e747_seq.bin added
#> 294810388f01f2_versionInfo.json added
#> 294810691134c1_salmon_index added
#> 2948101eba41fe_chrLength.txt added
#> 29481064543cf1_chrName.txt added
#> 2948101176be49_chrNameLength.txt added
#> 2948107a6816b1_chrStart.txt added
#> 294810427e53f1_exonGeTrInfo.tab added
#> 2948104532f1af_exonInfo.tab added
#> 29481011605eb1_geneInfo.tab added
#> 29481049f19ff7_Genome added
#> 2948106ae5d6b5_genomeParameters.txt added
#> 2948104e794d7b_Log.out added
#> 2948104a17a475_SA added
#> 294810646cdf26_SAindex added
#> 2948103bf3a90f_sjdbInfo.txt added
#> 2948106bd1ffc6_sjdbList.fromGTF.out.tab added
#> 2948101dddc76d_sjdbList.out.tab added
#> 294810e706912_transcriptInfo.tab added
#> 294810114c3397_GRCh38.GENCODE.v42_100 added
#> 2948106bccd038_knownGene_hg38.sql added
#> 29481069e101bd_knownGene_hg38.txt added
#> 29481042e6ee66_refGene_hg38.sql added
#> 29481026845c13_refGene_hg38.txt added
#> 2948101fd9ac92_knownGene_mm39.sql added
#> 2948107ccb0267_knownGene_mm39.txt added
#> 294810448098a4_refGene_mm39.sql added
#> 29481019149954_refGene_mm39.txt added
#> dataHub with 130 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>            name
#>   BFC1   | outfile.txt
#>   BFC2   | exp_data
#>   BFC3   | GRCh38.primary_assembly.genome.fa.1.bt2
#>   BFC4   | GRCh38.primary_assembly.genome.fa.2.bt2
#>   BFC5   | GRCh38.primary_assembly.genome.fa.3.bt2
#>   ...      ...
#>   BFC126 | refGene_hg38.txt
#>   BFC127 | knownGene_mm39.sql
#>   BFC128 | knownGene_mm39.txt
#>   BFC129 | refGene_mm39.sql
#>   BFC130 | refGene_mm39.txt
#>          Path
#>   BFC1   /tmp/RtmpIAiCac/SharedData/outfile.txt
#>   BFC2   /tmp/RtmpIAiCac/exp_data
#>   BFC3   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC4   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC5   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   ...    ...
#>   BFC126 https://storage.googleapis.com/reusedata/ucsc_database/refGene_h...
#>   BFC127 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC128 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC129 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
#>   BFC130 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
```

If the data of interest already exist on the cloud, then
`getCloudData` will directly download the data to your computer. Add
it to the local caching system using `dataUpdate()` for later use.

```
(dh <- dataSearch(c("ensembl", "GRCh38")))
#> dataHub with 8 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>           name
#>   BFC10 | GRCh37_to_GRCh38.chain
#>   BFC14 | GRCh38_to_GRCh37.chain
#>   BFC15 | GRCh38_to_NCBI34.chain
#>   BFC16 | GRCh38_to_NCBI35.chain
#>   BFC17 | GRCh38_to_NCBI36.chain
#>   BFC19 | NCBI34_to_GRCh38.chain
#>   BFC21 | NCBI35_to_GRCh38.chain
#>   BFC23 | NCBI36_to_GRCh38.chain
#>         Path
#>   BFC10 https://storage.googleapis.com/reusedata/ensembl_liftover/GRCh37...
#>   BFC14 https://storage.googleapis.com/reusedata/ensembl_liftover/GRCh38...
#>   BFC15 https://storage.googleapis.com/reusedata/ensembl_liftover/GRCh38...
#>   BFC16 https://storage.googleapis.com/reusedata/ensembl_liftover/GRCh38...
#>   BFC17 https://storage.googleapis.com/reusedata/ensembl_liftover/GRCh38...
#>   BFC19 https://storage.googleapis.com/reusedata/ensembl_liftover/NCBI34...
#>   BFC21 https://storage.googleapis.com/reusedata/ensembl_liftover/NCBI35...
#>   BFC23 https://storage.googleapis.com/reusedata/ensembl_liftover/NCBI36...
getCloudData(dh[1], outdir = gcpdir)
#> Data is downloaded:
#> /tmp/RtmpIAiCac/gcpData/GRCh37_to_GRCh38.chain
```

Now we create the data cache with only local data files, and we can
see that the downloaded data is available.

```
dataUpdate(gcpdir)  ## Update local data cache (without cloud data)
#>
#> Updating data record...
#> GRCh37_to_GRCh38.chain added
#> dataHub with 131 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>            name
#>   BFC1   | outfile.txt
#>   BFC2   | exp_data
#>   BFC3   | GRCh38.primary_assembly.genome.fa.1.bt2
#>   BFC4   | GRCh38.primary_assembly.genome.fa.2.bt2
#>   BFC5   | GRCh38.primary_assembly.genome.fa.3.bt2
#>   ...      ...
#>   BFC127 | knownGene_mm39.sql
#>   BFC128 | knownGene_mm39.txt
#>   BFC129 | refGene_mm39.sql
#>   BFC130 | refGene_mm39.txt
#>   BFC131 | GRCh37_to_GRCh38.chain
#>          Path
#>   BFC1   /tmp/RtmpIAiCac/SharedData/outfile.txt
#>   BFC2   /tmp/RtmpIAiCac/exp_data
#>   BFC3   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC4   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC5   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   ...    ...
#>   BFC127 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC128 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC129 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
#>   BFC130 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
#>   BFC131 /tmp/RtmpIAiCac/gcpData/GRCh37_to_GRCh38.chain
dataSearch()  ## data is available locally!!!
#> dataHub with 131 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseData
#> # dataUpdate() to update the local data cache
#> # dataSearch() to query a specific dataset
#> # Additional information can be retrieved using:
#> # dataNames(), dataParams(), dataNotes(), dataPaths(), dataTag() or mcols()
#>
#>            name
#>   BFC1   | outfile.txt
#>   BFC2   | exp_data
#>   BFC3   | GRCh38.primary_assembly.genome.fa.1.bt2
#>   BFC4   | GRCh38.primary_assembly.genome.fa.2.bt2
#>   BFC5   | GRCh38.primary_assembly.genome.fa.3.bt2
#>   ...      ...
#>   BFC127 | knownGene_mm39.sql
#>   BFC128 | knownGene_mm39.txt
#>   BFC129 | refGene_mm39.sql
#>   BFC130 | refGene_mm39.txt
#>   BFC131 | GRCh37_to_GRCh38.chain
#>          Path
#>   BFC1   /tmp/RtmpIAiCac/SharedData/outfile.txt
#>   BFC2   /tmp/RtmpIAiCac/exp_data
#>   BFC3   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC4   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   BFC5   https://storage.googleapis.com/reusedata/bowtie2_index/GRCh38.pr...
#>   ...    ...
#>   BFC127 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC128 https://storage.googleapis.com/reusedata/ucsc_database/knownGene...
#>   BFC129 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
#>   BFC130 https://storage.googleapis.com/reusedata/ucsc_database/refGene_m...
#>   BFC131 /tmp/RtmpIAiCac/gcpData/GRCh37_to_GRCh38.chain
```

The data supports user-friendly discovery and access through the
`ReUseData` portal, where detailed instructions are provided for
straight-forward incorporation into data analysis pipelines run on
local computing nodes, web resources, and cloud computing platforms
(e.g., Terra, CGC).

# 4 Know your data

Here we provide a function `meta_data()` to create a data frame that
contains all information about the data sets in the specified file
path (recursively), including the annotation file (`$yml` column),
parameter values for the recipe (`$params` column), data file path
(`$output` column), keywords for data file (`notes` columns), date of
data generation (`date` column), and any tag if available (`tag`
column).

Use `cleanup = TRUE` to cleanup any invalid or expired/older
intermediate files.

```
mt <- meta_data(outdir)
head(mt)
#>                                                            yml
#> 1 /tmp/RtmpIAiCac/SharedData/echo_out_Hello_World!_outfile.yml
#>                                  params                                 output
#> 1 input: Hello World!; outfile: outfile /tmp/RtmpIAiCac/SharedData/outfile.txt
#>                  notes                      date
#> 1 echo hello world txt 2025-10-30 02:01:44.25757
```

# 5 SessionInfo

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] ReUseData_1.10.0    Rcwl_1.26.0         S4Vectors_0.48.0
#> [4] BiocGenerics_0.56.0 generics_0.1.4      yaml_2.3.10
#> [7] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1     dplyr_1.1.4          blob_1.2.4
#>  [4] filelock_1.0.3       R.utils_2.13.0       fastmap_1.2.0
#>  [7] BiocFileCache_3.0.0  promises_1.4.0       digest_0.6.37
#> [10] base64url_1.4        mime_0.13            lifecycle_1.0.4
#> [13] RSQLite_2.4.3        magrittr_2.0.4       compiler_4.5.1
#> [16] rlang_1.1.6          sass_0.4.10          progress_1.2.3
#> [19] tools_4.5.1          data.table_1.17.8    knitr_1.50
#> [22] prettyunits_1.2.0    brew_1.0-10          htmlwidgets_1.6.4
#> [25] bit_4.6.0            curl_7.0.0           reticulate_1.44.0
#> [28] RColorBrewer_1.1-3   batchtools_0.9.18    BiocParallel_1.44.0
#> [31] withr_3.0.2          purrr_1.1.0          R.oo_1.27.1
#> [34] grid_4.5.1           git2r_0.36.2         xtable_1.8-4
#> [37] debugme_1.2.0        cli_3.6.5            rmarkdown_2.30
#> [40] DiagrammeR_1.0.11    crayon_1.5.3         otel_0.2.0
#> [43] httr_1.4.7           visNetwork_2.1.4     DBI_1.2.3
#> [46] cachem_1.1.0         parallel_4.5.1       BiocManager_1.30.26
#> [49] basilisk_1.22.0      vctrs_0.6.5          Matrix_1.7-4
#> [52] jsonlite_2.0.0       dir.expiry_1.18.0    bookdown_0.45
#> [55] hms_1.1.4            bit64_4.6.0-1        jquerylib_0.1.4
#> [58] RcwlPipelines_1.26.0 glue_1.8.0           codetools_0.2-20
#> [61] stringi_1.8.7        later_1.4.4          tibble_3.3.0
#> [64] pillar_1.11.1        rappdirs_0.3.3       htmltools_0.5.8.1
#> [67] R6_2.6.1             dbplyr_2.5.1         httr2_1.2.1
#> [70] evaluate_1.0.5       shiny_1.11.1         lattice_0.22-7
#> [73] R.methodsS3_1.8.2    png_0.1-8            backports_1.5.0
#> [76] memoise_2.0.1        httpuv_1.6.16        bslib_0.9.0
#> [79] Rcpp_1.1.0           checkmate_2.3.3      xfun_0.53
#> [82] pkgconfig_2.0.3
```