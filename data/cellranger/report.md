# cellranger CWL Generation Report

## cellranger_count

### Tool Description
Count gene expression and/or feature barcode reads from a single sample and GEM well

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS
- **tutorial**: https://www.10xgenomics.com/support/software/cell-ranger/latest/tutorials

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellranger/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/10XGenomics/cellranger
- **Stars**: N/A
### Original Help Text
```text
Count gene expression and/or feature barcode reads from a single sample and GEM
well

Usage: cellranger count [OPTIONS] --id <ID> --create-bam <true|false>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+
      --description <TEXT>
          Sample description to embed in output files [default: ""]
      --transcriptome <PATH>
          Path of folder containing 10x-compatible transcriptome reference
      --fastqs <PATH>
          Path to input FASTQ data
      --project <TEXT>
          Name of the project folder within a mkfastq or bcl2fastq-generated
          folder from which to pick FASTQs
      --sample <PREFIX>
          Prefix of the filenames of FASTQs to select
      --lanes <NUMS>
          Only use FASTQs from selected lanes
      --libraries <CSV>
          CSV file declaring input library data sources
      --feature-ref <CSV>
          Feature reference CSV file, declaring Feature Barcode constructs and
          associated barcodes
      --expect-cells <NUM>
          Expected number of recovered cells, used as input to cell calling
          algorithm
      --force-cells <NUM>
          Force pipeline to use this number of cells, bypassing cell calling
          algorithm. [MINIMUM: 10]
      --create-bam <true|false>
          Enable or disable BAM file generation. Setting --create-bam=false
          reduces the total computation time and the size of the output
          directory (BAM file not generated). We recommend setting
          --create-bam=true if unsure. See https://10xgen.com/create-bam for
          additional guidance [possible values: true, false]
      --nosecondary
          Disable secondary analysis, e.g. clustering. Optional
      --r1-length <NUM>
          Hard trim the input Read 1 to this length before analysis
      --r2-length <NUM>
          Hard trim the input Read 2 to this length before analysis
      --include-introns <true|false>
          Include intronic reads in count [default: true] [possible values:
          true, false]
      --chemistry <CHEM>
          Assay configuration. NOTE: by default the assay configuration is
          detected automatically, which is the recommended mode. You usually
          will not need to specify a chemistry. Options are: 'auto' for
          autodetection, 'threeprime' for Single Cell 3', 'fiveprime' for
          Single Cell 5', 'SC3Pv1' or 'SC3Pv2' or 'SC3Pv3' or 'SC3Pv4' for
          Single Cell 3' v1/v2/v3/v4, 'SC3Pv3HT' for Single Cell 3' v3 HT,
          'SC5P-PE' or 'SC5P-PE-v3' or 'SC5P-R2' or 'SC5P-R2-v3' for Single Cell
          5', paired-end/R2-only, 'SC-FB' for Single Cell Antibody-only 3' v2 or
          5'. To analyze the GEX portion of multiome data, chemistry must be set
          to 'ARC-v1' [default: auto]
      --no-libraries
          Proceed with processing using a --feature-ref but no Feature Barcode
          libraries specified with the 'libraries' flag
      --check-library-compatibility <true|false>
          Whether to check for barcode compatibility between libraries.
          [default: true] [possible values: true, false]
      --tenx-cloud-token-path <PATH>
          The path to the 10x Cloud Analysis user token used to enable cell
          annotation. If not provided, will default to the location stored
          through cellranger cloud auth setup
      --cell-annotation-model <MODEL>
          Cell annotation model to use. Valid model names can be viewed by
          running `cellranger cloud annotation models` or on the 10x Genomics
          Support site (https://www.10xgenomics.com/support). If "auto", uses
          the default model for the species. If not provided, does not run cell
          annotation
      --disable-cell-annotation
          Disable cell type annotation
      --min-crispr-umi <NUM>
          Minimum CRISPR UMI threshold [default: 3]
      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop
      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster
      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs
      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs
      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs
      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes
      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes
      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes
      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file
      --output-dir <PATH>
          Output the results to this directory
      --uiport <PORT>
          Serve web UI at http://localhost:PORT
      --disable-ui
          Do not serve the web UI
      --noexit
          Keep web UI running after pipestance completes or fails
      --nopreflight
          Skip preflight checks
  -h, --help
          Print help
```


## cellranger_multi

### Tool Description
Analyze multiplexed data or combined gene expression/immune profiling/feature barcode data

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Analyze multiplexed data or combined gene expression/immune profiling/feature
barcode data

Usage: cellranger multi [OPTIONS] --id <ID> --csv <CSV>

Options:
      --id <ID>             A unique run id and output folder name
                            [a-zA-Z0-9_-]+
      --description <TEXT>  Sample description to embed in output files
                            [default: ""]
      --csv <CSV>           Path of CSV file enumerating input libraries and
                            analysis parameters
      --dry                 Do not execute the pipeline. Generate a pipeline
                            invocation (.mro) file and stop
      --jobmode <MODE>      Job manager to use. Valid options: local (default),
                            sge, lsf, slurm or path to a .template file. Search
                            for help on "Cluster Mode" at
                            support.10xgenomics.com for more details on
                            configuring the pipeline to use a compute cluster
      --localcores <NUM>    Set max cores the pipeline may request at one time.
                            Only applies to local jobs
      --localmem <NUM>      Set max GB the pipeline may request at one time.
                            Only applies to local jobs
      --localvmem <NUM>     Set max virtual address space in GB for the
                            pipeline. Only applies to local jobs
      --mempercore <NUM>    Reserve enough threads for each job to ensure enough
                            memory will be available, assuming each core on your
                            cluster has at least this much memory available.
                            Only applies to cluster jobmodes
      --maxjobs <NUM>       Set max jobs submitted to cluster at one time. Only
                            applies to cluster jobmodes
      --jobinterval <NUM>   Set delay between submitting jobs to cluster, in ms.
                            Only applies to cluster jobmodes
      --overrides <PATH>    The path to a JSON file that specifies stage-level
                            overrides for cores and memory. Finer-grained than
                            --localcores, --mempercore and --localmem. Consult
                            https://10xgen.com/resource-override for an example
                            override file
      --output-dir <PATH>   Output the results to this directory
      --uiport <PORT>       Serve web UI at http://localhost:PORT
      --disable-ui          Do not serve the web UI
      --noexit              Keep web UI running after pipestance completes or
                            fails
      --nopreflight         Skip preflight checks
  -h, --help                Print help
```


## cellranger_multi-template

### Tool Description
Output cellranger multi config CSV template for analyzing Single Cell Gene Expression with Feature Barcode Technology, Flex Gene Expression, on-chip multiplexing, hashing with Antibody Capture, or Single Cell Immune Profiling data.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
# This template shows the possible cellranger multi config CSV options for analyzing Single Cell Gene Expression with Feature Barcode Technology (Antibody Capture, CRISPR Guide Capture, CellPlex Multiplexing, Antigen Capture), Flex Gene Expression, on-chip multiplexing, hashing with Antibody Capture, or Single Cell Immune Profiling data.
# These options cannot be used all together - see section descriptions for detail.
# Use 'cellranger multi-template --parameters' to see descriptions of all parameters.
# Please see cellranger multi documentation for details and experimental design-specific examples at https://www.10xgenomics.com/support.

[gene-expression]
reference,/path/to/transcriptome
create-bam,true
# probe-set,/path/to/probe/set, # Required, Flex only
# filter-probes,<true|false>, # Optional, Flex only
# r1-length,<int>
# r2-length,<int>
# chemistry,<auto>
# expect-cells,<int>
# force-cells,<int>
# emptydrops-minimum-umis,<int>, # See https://10xgen.com/scFFPE-cell-calling
# no-secondary,<true|false>
# check-library-compatibility,<true|false>
# include-introns,<true|false>
# min-assignment-confidence,<0.9>, # Optional, CellPlex Multiplexing and hashtag multiplexing only
# cmo-set,/path/to/CMO/reference, # Optional, CellPlex Multiplexing only
# barcode-sample-assignment,/path/to/barcode-sample-assignment/csv, # Optional, CellPlex Multiplexing and hashtag multiplexing only
# tenx-cloud-token-path,/path/to/cloud/token, # Optional, Cell Annotation only
# cell-annotation-model,<str>, # Optional, Cell Annotation only

[feature] # For Feature Barcode libraries only
reference,/path/to/feature/reference
# r1-length,<int>
# r2-length,<int>
# min-crispr-umi,<int>, # Optional, CRISPR Guide Capture only

[vdj] # For TCR and BCR libraries only
reference,/path/to/vdj_reference
# inner-enrichment-primers,/path/to/primers
# r1-length,<int>
# r2-length,<int>
# denovo,<true|false>

[libraries]
fastq_id,fastqs,feature_types
# GEX1,/path/to/fastqs,Gene Expression
# Antibody1,/path/to/fastqs,Antibody Capture, # Antibody and hashtag multiplexing
# CRISPR1,path/to/CRISPR_fastqs,CRISPR Guide Capture
# CMO1,/path/to/fastqs,Multiplexing Capture, # CellPlex Multiplexing only
# VDJ_B1,path/to/vdj_B_fastqs,VDJ-B, # 5' Immune Profiling only
# VDJ_T1,path/to/vdj_T_fastqs,VDJ-T, # 5' Immune Profiling only
# VDJ_T_GD1,path/to/vdj_T_GD_fastqs,VDJ-T-GD, # 5' Immune Profiling only for gamma-delta TCR
# Antigen1,path/to/antigen_capture_fastqs,Antigen Capture, # 5' Antigen Capture only

[antigen-specificity] # for 5' BCR/TCR Antigen Capture only
control_id,mhc_allele
Antigen1,AG001
Antigen2,AG002

[samples] # for On-chip multiplexing data only
sample_id,ocm_barcode_ids,description
sample1,OB1,Control
sample2,OB2,Treated

[samples] # for CellPlex Multiplexing data only
sample_id,cmo_ids,description
sample1,CMO301,Control
sample2,CMO303,Treated

[samples] # for Flex multiplexed data only
sample_id,probe_barcode_ids,description
sample1,BC001,Control
sample2,BC003,Treated

[samples] # for hashtag multiplexing data only
sample_id,hashtag_ids,description
sample1,hashtag1,Control # ID used must match Feature ID in feature reference CSV
sample2,hashtag2,Treated
```


## cellranger_vdj

### Tool Description
Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries

Usage: cellranger vdj [OPTIONS] --id <ID> --fastqs <PATH>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+
      --description <TEXT>
          Sample description to embed in output files [default: ""]
      --reference <PATH>
          Path of folder containing 10x-compatible VDJ reference. Optional if
          '--denovo' is specified
      --fastqs <PATH>
          Path to input FASTQ data
      --project <TEXT>
          Name of the project folder within a mkfastq or bcl2fastq-generated
          folder to pick FASTQs from
      --sample <PREFIX>
          Prefix of the filenames of FASTQs to select
      --lanes <NUMS>
          Only use FASTQs from selected lanes
      --denovo
          Run in reference-free mode (do not use annotations)
      --chain <CHAIN_SPEC>
          Chain type to display metrics for: 'TR' for T cell receptors, 'IG' for
          B cell receptors, or 'auto' to autodetect [default: auto]
      --inner-enrichment-primers <PATH>
          If inner enrichment primers other than those provided in the 10x kits
          are used, they need to be specified here as a textfile with one primer
          per line. Disable secondary analysis, e.g. clustering
      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop
      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster
      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs
      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs
      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs
      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes
      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes
      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes
      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file
      --output-dir <PATH>
          Output the results to this directory
      --uiport <PORT>
          Serve web UI at http://localhost:PORT
      --disable-ui
          Do not serve the web UI
      --noexit
          Keep web UI running after pipestance completes or fails
      --nopreflight
          Skip preflight checks
  -h, --help
          Print help
```


## cellranger_aggr

### Tool Description
Aggregate data from multiple Cell Ranger runs

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Aggregate data from multiple Cell Ranger runs

Usage: cellranger aggr [OPTIONS] --id <ID> --csv <CSV>

Options:
      --id <ID>               A unique run id and output folder name
                              [a-zA-Z0-9_-]+
      --description <TEXT>    Sample description to embed in output files
                              [default: ""]
      --csv <CSV>             Path of CSV file enumerating 'cellranger
                              count/vdj/multi' outputs
      --normalize <MODE>      Library depth normalization mode [default: mapped]
                              [possible values: mapped, none]
      --nosecondary           Disable secondary analysis, e.g. clustering
      --dry                   Do not execute the pipeline. Generate a pipeline
                              invocation (.mro) file and stop
      --min-crispr-umi <NUM>  Minimum CRISPR UMI threshold [default: 3]
      --jobmode <MODE>        Job manager to use. Valid options: local
                              (default), sge, lsf, slurm or path to a .template
                              file. Search for help on "Cluster Mode" at
                              support.10xgenomics.com for more details on
                              configuring the pipeline to use a compute cluster
      --localcores <NUM>      Set max cores the pipeline may request at one
                              time. Only applies to local jobs
      --localmem <NUM>        Set max GB the pipeline may request at one time.
                              Only applies to local jobs
      --localvmem <NUM>       Set max virtual address space in GB for the
                              pipeline. Only applies to local jobs
      --mempercore <NUM>      Reserve enough threads for each job to ensure
                              enough memory will be available, assuming each
                              core on your cluster has at least this much memory
                              available. Only applies to cluster jobmodes
      --maxjobs <NUM>         Set max jobs submitted to cluster at one time.
                              Only applies to cluster jobmodes
      --jobinterval <NUM>     Set delay between submitting jobs to cluster, in
                              ms. Only applies to cluster jobmodes
      --overrides <PATH>      The path to a JSON file that specifies stage-level
                              overrides for cores and memory. Finer-grained than
                              --localcores, --mempercore and --localmem. Consult
                              https://10xgen.com/resource-override for an
                              example override file
      --output-dir <PATH>     Output the results to this directory
      --uiport <PORT>         Serve web UI at http://localhost:PORT
      --disable-ui            Do not serve the web UI
      --noexit                Keep web UI running after pipestance completes or
                              fails
      --nopreflight           Skip preflight checks
  -h, --help                  Print help
```


## cellranger_annotate

### Tool Description
Annotate cell-types from outputs of a Cell Ranger run

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Annotate cell-types from outputs of a Cell Ranger run

Usage: cellranger annotate [OPTIONS] --id <ID> --matrix <MATRIX_H5>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+
      --description <TEXT>
          Sample description to embed in output files [default: ""]
      --tenx-cloud-token-path <PATH>
          Path to 10x Cloud cell annotation token file
      --cell-annotation-model <CELL_ANNOTATION_MODEL>
          Cell annotation model to use
      --cloupe <CLOUPE>
          Cloupe file to use
      --cloupe-group-name <TEXT>
          Name of track to add onto the cloupe file
      --matrix <MATRIX_H5>
          A feature-barcode matrix containing data for one genome. Should be the
          filtered version
      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop
      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster
      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs
      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs
      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs
      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes
      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes
      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes
      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file
      --output-dir <PATH>
          Output the results to this directory
      --uiport <PORT>
          Serve web UI at http://localhost:PORT
      --disable-ui
          Do not serve the web UI
      --noexit
          Keep web UI running after pipestance completes or fails
      --nopreflight
          Skip preflight checks
  -h, --help
          Print help
```


## cellranger_reanalyze

### Tool Description
Re-run secondary analysis (dimensionality reduction, clustering, etc)

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Re-run secondary analysis (dimensionality reduction, clustering, etc)

Usage: cellranger reanalyze [OPTIONS] --id <ID> --matrix <MATRIX_H5>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+
      --description <TEXT>
          Sample description to embed in output files [default: ""]
      --matrix <MATRIX_H5>
          A feature-barcode matrix containing data for one genome. Should be the
          filtered version, unless using --force-cells
      --params <PARAMS_CSV>
          A CSV file specifying analysis parameters. Optional
      --barcodes <BARCODES_CSV>
          A CSV file containing a list of cell barcodes to use for reanalysis,
          e.g. barcodes exported from Loupe Browser. Optional
      --genes <GENES_CSV>
          A CSV file containing a list of feature IDs to use for reanalysis. For
          gene expression, this should correspond to the gene_id field in the
          reference GTF should be \(e.g. ENSG... for ENSEMBL-based references\).
          Optional
      --exclude-genes <GENES_CSV>
          A CSV file containing a list of feature IDs to exclude from
          reanalysis. For gene expression, this should correspond to the gene_id
          field in the reference GTF \(e.g., ENSG... for ENSEMBL-based
          references\). The exclusion is applied after --genes. Optional
      --agg <AGGREGATION_CSV>
          If the input matrix was produced by 'aggr', you may pass the same
          aggregation CSV in order to retain per-library tag information in the
          resulting .cloupe file.  This argument is required to enable chemistry
          batch correction. Optional
      --force-cells <NUM>
          Force pipeline to use this number of cells, bypassing cell calling
          algorithm. [MINIMUM: 10]
      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop
      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster
      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs
      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs
      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs
      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes
      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes
      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes
      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file
      --output-dir <PATH>
          Output the results to this directory
      --uiport <PORT>
          Serve web UI at http://localhost:PORT
      --disable-ui
          Do not serve the web UI
      --noexit
          Keep web UI running after pipestance completes or fails
      --nopreflight
          Skip preflight checks
  -h, --help
          Print help
```


## cellranger_mkvdjref

### Tool Description
Prepare a reference for use with Cell Ranger VDJ. Build a Cell Ranger V(D)J-compatible reference folder from user-supplied genome FASTA and gene GTF files, or a FASTA file containing V(D)J segments.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Prepare a reference for use with Cell Ranger VDJ.

Build a Cell Ranger V(D)J-compatible reference folder from: 1. A user-supplied
genome FASTA and gene GTF files. For example, using files from ENSEMBL.

OR

2. A FASTA file containing V(D)J segments as per the mkvdjref spec. For example,
using files from IMGT.

Creates a new folder named after the genome.

Usage: cellranger mkvdjref [OPTIONS] --genome <GENOME_NAME>

Options:
      --genome <GENOME_NAME>
          Unique genome name, used to name output folder [a-zA-Z0-9_.-]+ (must
          not start with `.`)

      --fasta <FASTA_FILE>
          Path to FASTA file containing your genome reference

      --genes <GTF_FILES>
          Path to genes GTF file containing annotated genes for your genome
          reference. Specify multiple genomes by specifying this argument
          multiple times

      --seqs <SEQ_FILE>
          Path to a FASTA file that directly specifies V(D)J sequences. This is
          mutually exclusive with the "fasta" and "genes" args

      --rm-transcripts <REMOVE_TRANSCRIPTS_FILE>
          Path to text file with transcript IDs to ignore. This file should have
          one transcript ID per line where the IDs correspond to the
          "transcript_id" key in the GTF info column

      --memgb <MEM_GB>
          Maximum memory (GB) used
          
          [default: 16]

      --ref-version <REF_VERSION>
          Optional reference version string to include with reference

      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop

      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster

      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs

      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs

      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs

      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes

      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes

      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes

      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file

      --output-dir <PATH>
          Output the results to this directory

      --uiport <PORT>
          Serve web UI at http://localhost:PORT

      --disable-ui
          Do not serve the web UI

      --noexit
          Keep web UI running after pipestance completes or fails

      --nopreflight
          Skip preflight checks

  -h, --help
          Print help (see a summary with '-h')
```


## cellranger_testrun

### Tool Description
Execute the 'count' pipeline on a small test dataset

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Execute the 'count' pipeline on a small test dataset

Usage: cellranger testrun [OPTIONS] --id <ID>

Options:
      --id <ID>             A unique run id and output folder name
                            [a-zA-Z0-9_-]+
      --description <TEXT>  Sample description to embed in output files
      --dry                 Do not execute the pipeline. Generate a pipeline
                            invocation (.mro) file and stop
      --jobmode <MODE>      Job manager to use. Valid options: local (default),
                            sge, lsf, slurm or path to a .template file. Search
                            for help on "Cluster Mode" at
                            support.10xgenomics.com for more details on
                            configuring the pipeline to use a compute cluster
      --localcores <NUM>    Set max cores the pipeline may request at one time.
                            Only applies to local jobs
      --localmem <NUM>      Set max GB the pipeline may request at one time.
                            Only applies to local jobs
      --localvmem <NUM>     Set max virtual address space in GB for the
                            pipeline. Only applies to local jobs
      --mempercore <NUM>    Reserve enough threads for each job to ensure enough
                            memory will be available, assuming each core on your
                            cluster has at least this much memory available.
                            Only applies to cluster jobmodes
      --maxjobs <NUM>       Set max jobs submitted to cluster at one time. Only
                            applies to cluster jobmodes
      --jobinterval <NUM>   Set delay between submitting jobs to cluster, in ms.
                            Only applies to cluster jobmodes
      --overrides <PATH>    The path to a JSON file that specifies stage-level
                            overrides for cores and memory. Finer-grained than
                            --localcores, --mempercore and --localmem. Consult
                            https://10xgen.com/resource-override for an example
                            override file
      --output-dir <PATH>   Output the results to this directory
      --uiport <PORT>       Serve web UI at http://localhost:PORT
      --disable-ui          Do not serve the web UI
      --noexit              Keep web UI running after pipestance completes or
                            fails
      --nopreflight         Skip preflight checks
  -h, --help                Print help
```


## cellranger_cloud

### Tool Description
The official command-line client for 10x Genomics Cloud Analysis.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
The official command-line client for 10x Genomics Cloud Analysis.

You can use 'txg help command' for more information on any of the available
commands.

Before using the CLI, you'll need to authenticate with 'txg auth setup'.  See
'txg help auth' for more information.

For more information, please visit https://support.10xgenomics.com/cloud-analysis

Usage:
  txg [command]

Available Commands:
  analyses    Manage analyses
  annotation  Cell type annotation functions
  auth        Manage authentication
  fastqs      Upload and manage FASTQs
  files       Upload and manage files
  help        Help about any command
  projects    Manage projects
  references  Upload and manage custom references

Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.

Use "txg [command] --help" for more information about a command.
```


## cellranger_mat2csv

### Tool Description
Tool for converting feature-barcode matrices from sparse format to dense CSV format, for use by external programs.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Tool for converting feature-barcode matrices from sparse format to dense.

CSV format, for use by external programs.

The commands below should be preceded by 'cellranger':

Usage:
    mat2csv <input_path> <output_csv> [--genome=GENOME]
    mat2csv -h | --help | --version

Arguments:
    input_path          Path to a Cell Ranger feature-barcode matrix. Can be
                            either a feature-barcode h5 file (recommended) or a
                            path to a MEX Cell Ranger output folder.
    output_csv          Output CSV file.

Options:
    --genome=GENOME     Specify which genome to extract. This only applies to
                            multi-genome h5 input files.
    -h --help           Show this message.
    --version           Show version.
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:165: SyntaxWarning: invalid escape sequence '\S'
  name = re.findall('(<\S*?>)', source)[0]
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:166: SyntaxWarning: invalid escape sequence '\['
  value = re.findall('\[default: (.*)\]', source, flags=re.I)
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:207: SyntaxWarning: invalid escape sequence '\['
  matched = re.findall('\[default: (.*)\]', description, flags=re.I)
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:456: SyntaxWarning: invalid escape sequence '\S'
  split = re.split('\n *(<\S+?>|-\S+?)', doc)[1:]
```


## cellranger_mkref

### Tool Description
Prepare a reference for use with 10x analysis software. Requires a GTF and FASTA

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Prepare a reference for use with 10x analysis software. Requires a GTF and FASTA

Usage: cellranger mkref [OPTIONS] --genome <GENOME_NAMES> --fasta <FASTA_FILES> --genes <GTF_FILES>

Options:
      --genome <GENOME_NAMES>
          Unique genome name, used to name output folder [a-zA-Z0-9_.-]+ (must
          not start with `.`). Specify multiple genomes by specifying this
          argument multiple times; the output folder will be <name1>_and_<name2>
      --fasta <FASTA_FILES>
          Path to FASTA file containing your genome reference. Specify multiple
          genomes by specifying this argument multiple times
      --genes <GTF_FILES>
          Path to genes GTF file containing annotated genes for your genome
          reference. Specify multiple genomes by specifying this argument
          multiple times
      --nthreads <NUM_THREADS>
          Number of threads used during STAR genome index generation. Defaults
          to 1 [default: 1]
      --memgb <MEM_GB>
          Maximum memory (GB) used [default: 16]
      --ref-version <REF_VERSION>
          Optional reference version string to include with reference
      --dry
          Do not execute the pipeline. Generate a pipeline invocation (.mro)
          file and stop
      --jobmode <MODE>
          Job manager to use. Valid options: local (default), sge, lsf, slurm or
          path to a .template file. Search for help on "Cluster Mode" at
          support.10xgenomics.com for more details on configuring the pipeline
          to use a compute cluster
      --localcores <NUM>
          Set max cores the pipeline may request at one time. Only applies to
          local jobs
      --localmem <NUM>
          Set max GB the pipeline may request at one time. Only applies to local
          jobs
      --localvmem <NUM>
          Set max virtual address space in GB for the pipeline. Only applies to
          local jobs
      --mempercore <NUM>
          Reserve enough threads for each job to ensure enough memory will be
          available, assuming each core on your cluster has at least this much
          memory available. Only applies to cluster jobmodes
      --maxjobs <NUM>
          Set max jobs submitted to cluster at one time. Only applies to cluster
          jobmodes
      --jobinterval <NUM>
          Set delay between submitting jobs to cluster, in ms. Only applies to
          cluster jobmodes
      --overrides <PATH>
          The path to a JSON file that specifies stage-level overrides for cores
          and memory. Finer-grained than --localcores, --mempercore and
          --localmem. Consult https://10xgen.com/resource-override for an
          example override file
      --output-dir <PATH>
          Output the results to this directory
      --uiport <PORT>
          Serve web UI at http://localhost:PORT
      --disable-ui
          Do not serve the web UI
      --noexit
          Keep web UI running after pipestance completes or fails
      --nopreflight
          Skip preflight checks
  -h, --help
          Print help
```


## cellranger_mkgtf

### Tool Description
Filter user-supplied GTF files for use as Cell Ranger-compatible genes files for mkref tool.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Genes GTF tool for 10x Genomics Cell Ranger.

Filter user-supplied GTF files for use as Cell Ranger-compatible
genes files for mkref tool.

The commands below should be preceded by 'cellranger':

Usage:
    mkgtf <input_gtf> <output_gtf> [--attribute=KEY:VALUE...]
    mkgtf -h | --help | --version

Arguments:
    input_gtf           Path to input genes GTF file.
    output_gtf          Path to filtered output genes GTF file.

Options:
    --attribute=<key:value>
                        Key-value pair in attributes field to be kept in the GTF
                            file.
    -h --help           Show this message.
    --version           Show version.
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:165: SyntaxWarning: invalid escape sequence '\S'
  name = re.findall('(<\S*?>)', source)[0]
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:166: SyntaxWarning: invalid escape sequence '\['
  value = re.findall('\[default: (.*)\]', source, flags=re.I)
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:207: SyntaxWarning: invalid escape sequence '\['
  matched = re.findall('\[default: (.*)\]', description, flags=re.I)
/software/cellranger-10.1.0/external/anaconda/lib/python3.12/site-packages/docopt.py:456: SyntaxWarning: invalid escape sequence '\S'
  split = re.split('\n *(<\S+?>|-\S+?)', doc)[1:]
```


## cellranger_upload

### Tool Description
Upload a file with cellranger

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:
        cellranger upload <your_email> <file>
```


## cellranger_sitecheck

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
cellranger sitecheck (10.1.0)
Copyright 2023 10x Genomics, Inc. All rights reserved.
-------------------------------------------------------------------------------
Mon Sep 28 21:16:53 UTC 2026

=====================================================================
System Info
uname -a
---------------------------------------------------------------------
Linux 5d336fd5bbb4 6.8.0-142-generic #142-Ubuntu SMP PREEMPT_DYNAMIC Wed Sep  2 14:24:27 UTC 2026 x86_64
=====================================================================

=====================================================================
CPU Model
grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f 2 | sed 's/^[ 	]*//'
---------------------------------------------------------------------
12th Gen Intel(R) Core(TM) i9-12900H
=====================================================================

=====================================================================
Linux Distro
cat /etc/*-release | sort -u
---------------------------------------------------------------------
BUG_REPORT_URL="https://bugs.debian.org/"
DEBIAN_VERSION_FULL=13.6
HOME_URL="https://www.debian.org/"
ID=debian
NAME="Debian GNU/Linux"
PRETTY_NAME="Debian GNU/Linux 13 (trixie)"
SUPPORT_URL="https://www.debian.org/support"
VERSION="13 (trixie)"
VERSION_CODENAME=trixie
VERSION_ID="13"
=====================================================================

=====================================================================
Kernel Build
cat /proc/version
---------------------------------------------------------------------
Linux version 6.8.0-142-generic (buildd@lcy02-amd64-049) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #142-Ubuntu SMP PREEMPT_DYNAMIC Wed Sep  2 14:24:27 UTC 2026
=====================================================================

=====================================================================
glibc version
ldd --version | head -n 1
---------------------------------------------------------------------
ldd (GNU libc) 2.41
=====================================================================

=====================================================================
CPU Support
grep -m 1 'flags' /proc/cpuinfo | cut -d ':' -f 2 | sed 's/^[ 	]*//'
---------------------------------------------------------------------
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb intel_pt sha_ni xsaveopt xsavec xgetbv1 xsaves split_lock_detect user_shstk avx_vnni dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku ospke waitpkg gfni vaes vpclmulqdq tme rdpid movdiri movdir64b fsrm md_clear serialize pconfig arch_lbr ibt flush_l1d arch_capabilities ibpb_exit_to_user
=====================================================================

=====================================================================
CPU Sockets
grep 'physical id' /proc/cpuinfo | sort -u | wc -l
---------------------------------------------------------------------
1
=====================================================================

=====================================================================
CPU Cores
grep -c processor /proc/cpuinfo
---------------------------------------------------------------------
20
=====================================================================

=====================================================================
Memory Total
grep MemTotal /proc/meminfo | cut -d ':' -f 2 | sed 's/^[ 	]*//'
---------------------------------------------------------------------
65521052 kB
=====================================================================

=====================================================================
Filesystem Options
mount | cut -d ' ' -f 5,6
---------------------------------------------------------------------
overlay (rw,relatime)
proc (rw,nosuid,nodev,noexec,relatime)
tmpfs (rw,nosuid)
devpts (rw,nosuid,noexec,relatime)
sysfs (ro,nosuid,nodev,noexec,relatime)
cgroup2 (ro,nosuid,nodev,noexec,relatime)
mqueue (rw,nosuid,nodev,noexec,relatime)
tmpfs (rw,nosuid,nodev,noexec,relatime)
ext4 (rw,relatime)
ext4 (rw,relatime)
ext4 (rw,relatime)
proc (ro,nosuid,nodev,noexec,relatime)
proc (ro,nosuid,nodev,noexec,relatime)
proc (ro,nosuid,nodev,noexec,relatime)
proc (ro,nosuid,nodev,noexec,relatime)
proc (ro,nosuid,nodev,noexec,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (rw,nosuid)
tmpfs (rw,nosuid)
tmpfs (rw,nosuid)
tmpfs (rw,nosuid)
tmpfs (ro,relatime)
tmpfs (rw,nosuid)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
tmpfs (ro,relatime)
=====================================================================

=====================================================================
User Limits
bash -c 'ulimit -a'
---------------------------------------------------------------------
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 255010
max locked memory       (kbytes, -l) 8192
max memory size         (kbytes, -m) unlimited
open files                      (-n) 524287
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) unlimited
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
=====================================================================

=====================================================================
User Limits (hard)
bash -c 'ulimit -aH'
---------------------------------------------------------------------
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 255010
max locked memory       (kbytes, -l) 8192
max memory size         (kbytes, -m) unlimited
open files                      (-n) 524288
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) unlimited
cpu time               (seconds, -t) unlimited
max user processes              (-u) unlimited
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
=====================================================================

=====================================================================
Global File Limit
cat /proc/sys/fs/file-max /proc/sys/fs/file-nr
---------------------------------------------------------------------
9223372036854775807
19848	0	9223372036854775807
=====================================================================

=====================================================================
Memory config
sysctl vm
---------------------------------------------------------------------
vm.admin_reserve_kbytes = 8192
vm.compact_unevictable_allowed = 1
vm.compaction_proactiveness = 20
vm.dirty_background_bytes = 0
vm.dirty_background_ratio = 10
vm.dirty_bytes = 0
vm.dirty_expire_centisecs = 3000
vm.dirty_ratio = 20
vm.dirty_writeback_centisecs = 500
vm.dirtytime_expire_seconds = 43200
vm.extfrag_threshold = 500
vm.hugetlb_optimize_vmemmap = 0
vm.hugetlb_shm_group = 0
vm.laptop_mode = 0
vm.legacy_va_layout = 0
vm.lowmem_reserve_ratio = 256	256	32	0	0
vm.max_map_count = 1048576
vm.memfd_noexec = 0
vm.memory_failure_early_kill = 0
vm.memory_failure_recovery = 1
vm.min_free_kbytes = 67584
vm.min_slab_ratio = 5
vm.min_unmapped_ratio = 1
vm.mmap_min_addr = 65536
vm.mmap_rnd_bits = 32
vm.mmap_rnd_compat_bits = 16
vm.nr_hugepages = 0
vm.nr_hugepages_mempolicy = 0
vm.nr_overcommit_hugepages = 0
vm.numa_stat = 1
vm.numa_zonelist_order = Node
vm.oom_dump_tasks = 1
vm.oom_kill_allocating_task = 0
vm.overcommit_kbytes = 0
vm.overcommit_memory = 0
vm.overcommit_ratio = 50
vm.page-cluster = 3
vm.page_lock_unfairness = 5
vm.panic_on_oom = 0
vm.percpu_pagelist_high_fraction = 0
vm.stat_interval = 1
vm.stat_refresh = 
vm.swappiness = 60
vm.unprivileged_userfaultfd = 0
vm.user_reserve_kbytes = 131072
vm.vfs_cache_pressure = 100
vm.watermark_boost_factor = 15000
vm.watermark_scale_factor = 10
vm.zone_reclaim_mode = 0
=====================================================================

=====================================================================
THP memory config
cat /sys/kernel/mm/transparent_hugepage/enabled
---------------------------------------------------------------------
always [madvise] never
=====================================================================

=====================================================================
cgroups
cat /proc/self/cgroup
---------------------------------------------------------------------
0::/
=====================================================================

=====================================================================
Container
[ -e /.dockerenv ] || [ -e /.dockerinit ] \
		|| [ ! -z "$container" ] || grep -m 1 -E 'docker|lxc' /proc/1/cgroup \
		> /dev/null && echo 'Detected'
---------------------------------------------------------------------
Detected
=====================================================================

=====================================================================
init process
head -n 1 /proc/1/sched | cut -d ' ' -f 1
---------------------------------------------------------------------
cellranger (1, #threads: 1)
=====================================================================

=====================================================================
SGE Submit
which qsub
---------------------------------------------------------------------
=====================================================================

=====================================================================
LSF Submit
which bsub
---------------------------------------------------------------------
=====================================================================

=====================================================================
HTCondor Submit
which condor_submit
---------------------------------------------------------------------
=====================================================================

=====================================================================
Batch system
echo $BATCH_SYSTEM
---------------------------------------------------------------------
=====================================================================

=====================================================================
BCL2FASTQ 1
which configureBclToFastq.pl
---------------------------------------------------------------------
=====================================================================

=====================================================================
BCL2FASTQ 1
which bcl2fastq
---------------------------------------------------------------------
=====================================================================

=====================================================================
Java
which java
---------------------------------------------------------------------
=====================================================================

=====================================================================
10X Refdata
echo $TENX_REFDATA
---------------------------------------------------------------------
=====================================================================

=====================================================================
slurm info
sinfo -O nodes,maxcpuspernode,memory,time
---------------------------------------------------------------------
=====================================================================

=====================================================================
MRP
mrp --version
---------------------------------------------------------------------
v4.0.15
=====================================================================

=====================================================================
mrp templates
ls $(dirname $(dirname $(which mrp)))/jobmanagers/*.template
---------------------------------------------------------------------
=====================================================================
```


## cellranger_telemetry

### Tool Description
Configure and inspect telemetry settings and data

### Metadata
- **Docker Image**: cumulusprod/cellranger:10.1.0
- **Homepage**: https://github.com/10XGenomics/cellranger
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Configure and inspect telemetry settings and data

Usage: telemetry [help] (check|disable|enable|list|show)

check:   Show whether telemetry is currently enabled and
         configuration information.
disable: Disable telemetry collection for this user.
enable:  Enable telemetry collection for this user.
list:    List files containing saved telemetry data for this product.
show:    Display contents of saved telemetry data for this product.

For more information about what data is collected and how it's used, visit
https://10xgen.com/pipeline-telemetry
```


## Metadata
- **Skill**: generated
