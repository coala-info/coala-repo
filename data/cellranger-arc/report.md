# cellranger-arc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cellranger-arc_aggr | PASS |  |
| cellranger-arc_cloud_analyses_download | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_analyses_files | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_analyses_get | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_analyses_list | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_annotation_models | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_auth_reset | Not completed | Ran with exit 0 but the container has no saved 10x Cloud token, so there was nothing to delete or check. |
| cellranger-arc_cloud_auth_verify | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_fastqs_list | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_fastqs_upload | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_files_download | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_files_list | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_files_upload | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_projects_create | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_projects_list | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access; a run with a dummy token reached the server and was refused. |
| cellranger-arc_cloud_projects_update | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_references_delete | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_references_get | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_references_list | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_references_update | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_cloud_references_upload | Not completed | Needs a 10x Genomics Cloud Analysis account, access token and network access. |
| cellranger-arc_count | PASS |  |
| cellranger-arc_mkfastq | Failed | image problem: bcl2fastq is not in the image, and mkfastq needs it on PATH to demultiplex. |
| cellranger-arc_mkgtf | PASS |  |
| cellranger-arc_mkref | PASS |  |
| cellranger-arc_reanalyze | PASS |  |
| cellranger-arc_telemetry | PASS |  |
| cellranger-arc_testrun | PASS |  |
| cellranger-arc_upload | Not completed | Sends a file to 10x Genomics support servers; needs network access and a real email, so it was not run. |

## cellranger-arc_count

### Tool Description
Count ATAC and gene expression reads from a single library

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellranger-arc/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Stars**: N/A
### Original Help Text
```text
Count ATAC and gene expression reads from a single library

Usage: cellranger-arc count [OPTIONS] --id <ID> --reference <PATH> --libraries <CSV> --create-bam <true|false>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+ of maximum
          length 64 characters

      --description <TEXT>
          Sample description to embed in output files

      --reference <PATH>
          Path to folder containing cellranger-arc-compatible reference.
          Reference packages can be downloaded from support.10xgenomics.com or
          constructed using the `cellranger-arc mkref` command

      --libraries <CSV>
          Path to 3-column CSV file defining the paths to ATAC and gene
          expression FASTQ data generated with the Chromium Single Cell Multiome
          ATAC + Gene Expression solution. A template CSV would look as follows
          (blank lines are ignored):
          
          fastqs,sample,library_type
          
          /data/HAWT7ADXX/outs/fastq_path,myATAC,Chromatin Accessibility
          
          /data/H35KCBCXY/outs/fastq_path,myGEX,Gene Expression

      --min-atac-count <NUM>
          Cell caller override: define the minimum number of ATAC transposition
          events in peaks (ATAC counts) for a cell barcode. Note: this option
          must be specified in conjunction with `min-gex-count`. With
          `--min-atac-count=X` and `--min-gex-count=Y` a barcode is defined as a
          cell if it contains at least X ATAC counts AND at least Y GEX UMI
          counts

      --min-gex-count <NUM>
          Cell caller override: define the minimum number of GEX UMI counts for
          a cell barcode. Note: this option must be specified in conjunction
          with `min-atac-count`. With `--min-atac-count=X` and
          `--min-gex-count=Y` a barcode is defined as a cell if it contains at
          least X ATAC counts AND at least Y GEX UMI counts

      --peaks <BED>
          Override peak caller: specify peaks to use in downstream analyses from
          supplied 3-column BED file. The supplied peaks file must be sorted by
          position and not contain overlapping peaks; comment lines beginning
          with `#` are allowed

      --gex-exclude-introns
          Disable counting of intronic reads. In this mode, only reads that are
          exonic and compatible with annotated splice junctions in the reference
          are counted. Note: using this mode will reduce the UMI counts in the
          feature-barcode matrix

      --tenx-cloud-token-path <PATH>
          The path to the 10x Cloud Analysis user token used to enable cell
          annotation. If not provided, will default to the location stored
          through cellranger-arc cloud auth setup

      --cell-annotation-model <MODEL>
          Cell annotation model to use. Valid model names can be viewed by
          running `cellranger-arc cloud annotation models` or on the 10x
          Genomics Support site. If this option is omitted or set to "auto",
          uses the default model for the species. If a cloud token is not
          available or the --disable-cell-annotation flag is used, cloud cell
          annotation will not be performed. For local models, no
          cell-annotation-model is necessary

      --disable-cell-annotation
          Disable cell type annotation

      --create-bam <true|false>
          Enable or disable BAM file generation. Setting --create-bam=false
          reduces the total computation time and the size of the output
          directory (BAM file not generated). We recommend setting
          --create-bam=true if unsure. See https://10xgen.com/create-bam for
          additional guidance
          
          [possible values: true, false]

      --nosecondary
          Disable secondary analysis, e.g. clustering

      --rna-r1-length <NUM>
          Trim the input Read 1 for GEX data to this length before analysis

      --rna-r2-length <NUM>
          Trim the input Read 2 for GEX data to this length before analysis

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

## cellranger-arc_mkfastq

### Tool Description
Run Illumina demultiplexer on sample sheets that contain 10x-specific sample index sets, and generate 10x-specific quality metrics after the demultiplex.

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
cellranger-arc mkfastq (2.2.0)
Copyright (c) 2021 10x Genomics, Inc.  All rights reserved.
-------------------------------------------------------------------------------

Run Illumina demultiplexer on sample sheets that contain 10x-specific sample
index sets, and generate 10x-specific quality metrics after the demultiplex.
Any bcl2fastq argument will work (except a few that are set by the pipeline
to ensure proper trimming and sample indexing). The FASTQ output generated
will be the same as when running bcl2fastq directly.

These bcl2fastq arguments are overridden by this pipeline:
    --fastq-cluster-count
    --minimum-trimmed-read-length
    --mask-short-adapter-reads

Usage:
    cellranger-arc mkfastq --run=PATH [options]
    cellranger-arc mkfastq -h | --help | --version

Required:
    --run=PATH          Path of Illumina BCL run folder.

Optional:
# Sample Sheet
    --id=NAME           Name of the folder created by mkfastq. If not supplied,
                            will default to the name of the flowcell referred to
                            by the --run argument.
    --csv=PATH
    --samplesheet=PATH
    --sample-sheet=PATH
                        Path to the sample sheet. The sample sheet can either be
                            a simple CSV with lane, sample and index columns, or
                            an Illumina Experiment Manager-compatible sample
                            sheet. Sample sheet indexes can refer to 10x sample
                            index set names (e.g., SI-GA-A12).
    --simple-csv=PATH   Deprecated. Same meaning as --csv.
    --force-single-index
                        If 10x-supplied i7/i5 paired indices are specified,
                            but the flowcell was run with only one sample
                            index, allow the demultiplex to proceed using
                                the i7 half of the sample index pair.
    --filter-single-index
                        Only demultiplex samples identified
                            by an i7-only sample index, ignoring dual-indexed
                            samples.  Dual-indexed samples will not be
                            demultiplexed.
    --filter-dual-index
                        Only demultiplex samples identified
                          by i7/i5 dual-indices (e.g., SI-TT-A6), ignoring single-
                          index samples.  Single-index samples will not be
                          demultiplexed.
    --rc-i2-override=BOOL
                        Indicates if the bases in the I2 read are emitted as
                          reverse complement by the sequencing workflow.
                          Set to 'true' for the Reverse Complement Workflow
                          (Workflow B)/ NovaSeq Reagent Kit v1.5 or greater.
                          Set to 'false' for the Forward Strand Workflow
                          (Workflow A) / older NovaSeq Reagent Kits.
                          NOTE: this parameter is autodetected
                          and should only be passed in special circumstances.

# bcl2fastq Pass-Through
    --lanes=NUMS        Comma-delimited series of lanes to demultiplex. Shortcut
                            for the --tiles argument.
    --use-bases-mask=MASK
                        Same as bcl2fastq; override the read lengths as
                            specified in RunInfo.xml. See Illumina bcl2fastq
                            documentation for more information.
    --delete-undetermined
                        Delete the Undetermined FASTQ files left by bcl2fastq
                            Useful if your sample sheet is only expected to
                            match a subset of the flowcell.
    --output-dir=PATH   Same as in bcl2fastq. Folder where FASTQs, reports and
                            stats will be generated.
    --project=NAME      Custom project name, to override the samplesheet or to
                            use in conjunction with the --csv argument.

# Martian Runtime
    --jobmode=MODE      Job manager to use. Valid options: local (default), sge,
                            lsf, or a .template file
    --localcores=NUM    Set max cores the pipeline may request at one time. Only
                            applies to local jobs.
    --localmem=NUM      Set max GB the pipeline may request at one time. Only
                            applies to local jobs.
    --localvmem=NUM     Set max virtual address space in GB for the pipeline.
                            Only applies to local jobs.
    --mempercore=NUM    Reserve enough threads for each job to ensure enough
                        memory will be available, assuming each core on your
                        cluster has at least this much memory available. Only
                            applies in cluster jobmodes.
    --maxjobs=NUM       Set max jobs submitted to cluster at one time. Only
                            applies in cluster jobmodes.
    --jobinterval=NUM   Set delay between submitting jobs to cluster, in ms.
                            Only applies in cluster jobmodes.
    --overrides=PATH    The path to a JSON file that specifies stage-level
                            overrides for cores and memory. Finer-grained
                            than --localcores, --mempercore and --localmem.
                            Consult the 10x support website for an example
                            override file.

    --uiport=PORT       Serve web UI at http://localhost:PORT
    --disable-ui        Do not serve the UI.
    --noexit            Keep web UI running after pipestance completes or fails.
    --nopreflight       Skip preflight checks.

    -h --help           Show this message.
    --version           Show version.

If you demultiplexed with 'cellranger-arc mkfastq' or directly with Illumina
bcl2fastq, then set --fastqs to the project folder containing FASTQ files. In
addition, set --sample to the name prefixed to the FASTQ files comprising
your sample. For example, if your FASTQs are named:
    subject1_S1_L001_R1_001.fastq.gz
then set --sample=subject1

The `cellranger-arc mkfastq` pipeline is deprecated and will be removed in a future release.
Please use Illumina's BCL Convert to generate Cell Ranger ARC-compatible FASTQ files.
For detailed guidance, refer to the Generating FASTQs support page:
https://www.10xgenomics.com/support/software/cell-ranger-arc/latest/analysis/inputs/generating-fastqs-mkfastq
        

The `cellranger-arc mkfastq` pipeline is deprecated and will be removed in a future release.
Please use Illumina's BCL Convert to generate Cell Ranger ARC-compatible FASTQ files.
For detailed guidance, refer to the Generating FASTQs support page:
https://www.10xgenomics.com/support/software/cell-ranger-arc/latest/analysis/inputs/generating-fastqs-mkfastq
```

## cellranger-arc_mkref

### Tool Description
Build a reference package from a user-supplied genome FASTA and gene GTF file for 10x Genomics Cell Ranger Multiome ATAC + Gene Expression.

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Reference preparation tool for 10x Genomics Cell Ranger Multiome ATAC + Gene Expression.

Build a reference package from a user-supplied genome FASTA and gene GTF file.
Creates a new folder named after the genome.

NOTE: Multi-species references are not supported by cellranger-arc. If you
construct a multi-species reference and run 'cellranger-arc count' you will not
be able to generate all the outputs of the pipeline.

The commands below should be preceded by 'cellranger-arc':

Usage:
    mkref
        --config=PATH
        [options]
    mkref -h | --help | --version

Arguments:
    config              Path to configuration file containing additional
                            information about the reference. See online
                            documentation for more details. The following is an
                            example of a config file:
                            {
                                organism: "human"
                                genome: ["GRCh38"]
                                input_fasta: ["/path/to/GRCh38/assembly.fa"]
                                input_gtf: ["/path/to/gencode/annotation.gtf"]
                                non_nuclear_contigs: ["chrM"]
                                input_motifs: "/path/to/jaspar/motifs.pfm"
                            }
                            Parameters:
                                - organism: (optional; string) name of the
                                    organism
                                - genome: (required; list of strings) name(s) of
                                    the genome(s) that comprise the organism
                                - input_fasta: (required; list of paths) path(s)
                                    to the assembly fasta file(s) for each
                                    genome
                                - input_gtf: (required; list of paths) path(s)
                                    to the gene annotation GTF file(s) for each
                                    genome
                                - non_nuclear_contigs:
                                    (optional; list of strings) contigs in the
                                    assembly that are not nuclear and have no
                                    chromatin structure (e.g., mitochondria)
                                - input_motifs: (optional; path) path to a
                                    motif annotations file in the JASPAR format
                            The above config file would create a reference
                            package in "$(pwd)/GRCh38".

Options:
    --nthreads=<num>    Number of threads used during STAR genome index
                            generation. Defaults to 1.
    --memgb=<num>       Maximum memory (GB) used when aligning reads with STAR.
                            Defaults to 16.
    --ref-version=<str> Optional reference version string to include with
                            reference.
    -h --help           Show this message.
    --version           Show version.

/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:165: SyntaxWarning: invalid escape sequence '\S'
  name = re.findall('(<\S*?>)', source)[0]
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:166: SyntaxWarning: invalid escape sequence '\['
  value = re.findall('\[default: (.*)\]', source, flags=re.I)
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:207: SyntaxWarning: invalid escape sequence '\['
  matched = re.findall('\[default: (.*)\]', description, flags=re.I)
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:456: SyntaxWarning: invalid escape sequence '\S'
  split = re.split('\n *(<\S+?>|-\S+?)', doc)[1:]
```

## cellranger-arc_aggr

### Tool Description
Aggregate data from multiple `cellranger-arc count` runs

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Aggregate data from multiple `cellranger-arc count` runs

Usage: cellranger-arc aggr [OPTIONS] --id <ID> --reference <PATH> --csv <CSV>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+ of maximum
          length 64 characters

      --description <TEXT>
          Sample description to embed in output files
          
          [default: ""]

      --reference <PATH>
          Path to folder containing cellranger-arc-compatible reference.
          Reference packages can be downloaded from support.10xgenomics.com or
          constructed using the `cellranger-arc mkref` command. Note: this
          reference must match the reference used for the initial
          `cellranger-arc count` run

      --csv <CSV>
          Path to CSV file enumerating 'cellranger-arc count' outputs required
          for aggregation.
          
          For example, a CSV for aggregating two samples would look as follows
          (blank lines are ignored):
          
          library_id,atac_fragments,per_barcode_metrics,gex_molecule_info
          
          L1,/data/L1/outs/atac_fragments.tsv.gz,/data/L1/outs/per_barcode_metrics.csv,/data/L1/outs/gex_molecule_info.h5
          
          L2,/data/L2/outs/atac_fragments.tsv.gz,/data/L2/outs/per_barcode_metrics.csv,/data/L2/outs/gex_molecule_info.h5
          
          Optionally, metadata associated with these libraries can be specified
          using additional columns. This information is not used by the pipeline
          but will be available in the Loupe file for visualization.

      --peaks <BED>
          Override peak caller: specify peaks to use in downstream analyses from
          supplied 3-column BED file. The supplied peaks file must be sorted by
          position and not contain overlapping peaks; comment lines beginning
          with `#` are allowed

      --normalize <MODE>
          Library depth normalization mode
          
          [default: depth]
          [possible values: none, depth]

      --nosecondary
          Disable secondary analysis, e.g. clustering

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

## cellranger-arc_reanalyze

### Tool Description
Re-run secondary analysis (dimensionality reduction, clustering, feature linkage etc.) on a completed `cellranger-arc count` or `cellranger-arc aggr` run

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Re-run secondary analysis (dimensionality reduction, clustering, feature linkage
etc.) on a completed `cellranger-arc count` or `cellranger-arc aggr` run

Usage: cellranger-arc reanalyze [OPTIONS] --id <ID> --reference <PATH> --matrix <H5> --atac-fragments <TSV.GZ>

Options:
      --id <ID>
          A unique run id and output folder name [a-zA-Z0-9_-]+ of maximum
          length 64 characters

      --description <TEXT>
          Sample description to embed in output files
          
          [default: ""]

      --reference <PATH>
          Path to folder containing cellranger-arc-compatible reference.
          Reference packages can be downloaded from support.10xgenomics.com or
          constructed using the `cellranger-arc mkref` command. Note: this
          reference must match the reference used for the initial
          `cellranger-arc count` run

      --matrix <H5>
          Path to a feature barcode matrix H5 generated by cellranger-arc
          `count` or `aggr`. If you intend to subset to a set of barcodes then
          use the raw matrix, otherwise use the filtered feature barcode matrix

      --atac-fragments <TSV.GZ>
          Path to the atac_fragments.tsv.gz generated by cellranger-arc `count`
          or `aggr`. Note it is assumed that the tabix index file
          atac_fragments.tsv.gz.tbi is present in the same directory

      --params <CSV>
          Specify key-value pairs in CSV format for analysis: any subset of
          `random_seed`, `k_means_max_clusters`, `feature_linkage_max_dist_mb`,
          `num_gex_pcs`, `num_atac_pcs`. For example, to override the number of
          GEX principal components used to 15 and the distance threshold for
          feature linkage computation to 2.5 megabases, the CSV would take the
          form (blank lines are ignored):
          
          num_gex_pcs,15
          
          feature_linkage_max_dist_mb,2.5

      --barcodes <CSV>
          Specify barcodes to use in analysis. The barcodes could be specified
          in a text file that contains one barcode per line, like this (blank
          lines are ignored):
          
          ACGT-1
          
          TGCA-1
          
          Or you can supply a CSV (with/without a header) whose first column
          will be used - exports from Loupe Browser will have this format. For
          example,
          
          Barcode,Cluster
          
          ACGT-1,T cells
          
          TGCA-1,B cells

      --min-atac-count <NUM>
          Cell caller override: define the minimum number of ATAC transposition
          events in peaks (ATAC counts) for a cell barcode. Note: this option
          must be specified in conjunction with `min-gex-count`. With
          `--min-atac-count=X` and `--min-gex-count=Y` a barcode is defined as a
          cell if it contains at least X ATAC counts AND at least Y GEX UMI
          counts

      --min-gex-count <NUM>
          Cell caller override: define the minimum number of GEX UMI counts for
          a cell barcode. Note: this option must be specified in conjunction
          with `min-atac-count`. With `--min-atac-count=X` and
          `--min-gex-count=Y` a barcode is defined as a cell if it contains at
          least X ATAC counts AND at least Y GEX UMI counts

      --peaks <BED>
          Override peak caller: specify peaks to use in secondary analyses from
          supplied 3-column BED file. The supplied peaks file must be sorted by
          position and not contain overlapping peaks; comment lines beginning
          with `#` are allowed

      --agg <AGGREGATION_CSV>
          If the input matrix was produced by 'cellranger-arc aggr', it's
          possible to pass the same aggregation CSV in order to retain
          per-library tag information in the resulting .cloupe file

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

## cellranger-arc_testrun

### Tool Description
Run a tiny cellranger-arc count pipeline to verify software integrity

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Run a tiny cellranger-arc count pipeline to verify software integrity

Usage: cellranger-arc testrun [OPTIONS] --id <ID>

Options:
      --id <ID>             A unique run id and output folder name
                            [a-zA-Z0-9_-]+ of maximum length 64 characters
      --description <TEXT>  Sample description to embed in output files
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

## cellranger-arc_mkgtf

### Tool Description
Filter user-supplied GTF files for use as Cell Ranger Multiome ATAC + Gene Expression-compatible genes files for mkref tool.

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Genes GTF tool for 10x Genomics Cell Ranger Multiome ATAC + Gene Expression.

Filter user-supplied GTF files for use as Cell Ranger Multiome ATAC + Gene Expression-compatible
genes files for mkref tool.

The commands below should be preceded by 'cellranger-arc':

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

/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:165: SyntaxWarning: invalid escape sequence '\S'
  name = re.findall('(<\S*?>)', source)[0]
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:166: SyntaxWarning: invalid escape sequence '\['
  value = re.findall('\[default: (.*)\]', source, flags=re.I)
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:207: SyntaxWarning: invalid escape sequence '\['
  matched = re.findall('\[default: (.*)\]', description, flags=re.I)
/software/cellranger-arc-2.2.0/external/anaconda/lib/python3.12/site-packages/docopt.py:456: SyntaxWarning: invalid escape sequence '\S'
  split = re.split('\n *(<\S+?>|-\S+?)', doc)[1:]
```

## cellranger-arc_upload

### Tool Description
Upload files to 10x Genomics support

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:
        cellranger-arc upload <your_email> <file>
```

## cellranger-arc_telemetry

### Tool Description
Manage and inspect telemetry data collection for Cell Ranger ARC

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: telemetry [help] (collect|check|disable|enable|list|show)

collect: Collect telemetry data, if enabled.
check:   Show whether telemetry is currently enabled and
         configuration information.
disable: Disable telemetry collection for this user.
enable:  Enable telemetry collection for this user.
list:    List files containing saved telemetry data for this product.
show:    Display contents of saved telemetry data for this product.

For more information about what data is collected and how it's used, visit
https://www.10xgenomics.com/support/software/cell-ranger-arc/latest/tutorials/cr-arc-pipeline-telemetry
```

## cellranger-arc_cloud_analyses_download

### Tool Description
Download analysis files in a single analysis

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download analysis files in a single analysis.

Download files from the specified analysis.  This may take a long
time, depending on the size of the analysis files.  You will be prompted to confirm
the files to download before downloading begins.

Usage:
  txg analyses download ANALYSIS-ID

Flags:
      --file-id strings     IDs of the files to download.
      --target-dir string   Destination directory to download to (default is current directory). (default ".")

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_analyses_files

### Tool Description
List all analysis files in a single analysis

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List all analysis files in a single analysis.

List files of the specified analysis.  An analysis's ID can be
displayed by running 'txg analyses list'.

Usage:
  txg analyses files ANALYSIS-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_analyses_get

### Tool Description
Show details about a single analysis

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Show details about a single analysis.

Show the details of the specified analysis.  An analysis's ID can be
displayed by running 'txg analyses list'.

Usage:
  txg analyses get ANALYSIS-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_analyses_list

### Tool Description
List all analyses in a project

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List all analyses in a project.

List analyses for the specified project ID.  A project ID is a unique key
generated for each project.  You can find the ID of a project by running 'txg
projects list'.

Usage:
  txg analyses list PROJECT-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_annotation_models

### Tool Description
List and/or describe cell annotation models

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List and/or describe cell annotation models.

List the cell type annotation models that can be used.  If the '--verbose' flag is added,
print more information about each model.

Usage:
  txg annotation models [--verbose]

Flags:
  -v, --verbose   Print details about each model.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_auth_reset

### Tool Description
Delete saved authentication information

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Delete saved authentication information

Delete the saved access token (if it exists).

Usage:
  txg auth reset

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_auth_verify

### Tool Description
Verify authentication

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Verify authentication

Verify that the stored access token is valid and that the 10x Genomics Cloud
Analysis service can be successfully reached.  Returns a zero exit code if
successful, nonzero otherwise.

Usage:
  txg auth verify

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_fastqs_list

### Tool Description
List FASTQs

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List FASTQs

List FASTQ files for the specified project ID.  A project ID is a unique key
generated for each project.  You can find the ID of a project by running 'txg
projects list'.

Usage:
  txg fastqs list PROJECT-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_fastqs_upload

### Tool Description
Upload FASTQ files

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Upload FASTQ files.

Upload the specified FASTQ files to the specified project.  This may take a long
time, depending on the size of the FASTQ files.  You will be prompted to confirm
the files to upload before uploading begins.

FASTQ filenames must match the Illumina FASTQ naming conventions.  Valid
filenames look like:

    example_S1_L001_R1_001.fastq.gz

Individual FASTQs may be specified directly, e.g. 'txg upload *.fastq.gz'.  You
can also specify a directory instead, which will upload all FASTQ files
immediately inside that directory.  For example, if you have a directory
structure like this:

    foo/
        foo_S1_L001_I1_001.fastq.gz
        foo_S1_L001_R1_001.fastq.gz
        foo_S1_L001_R2_001.fastq.gz
        a/
            a_S1_L001_I1_001.fastq.gz
            a_S1_L001_R1_001.fastq.gz
            a_S1_L001_R2_001.fastq.gz
        b/
            b_S1_L001_I1_001.fastq.gz
            b_S1_L001_R1_001.fastq.gz
            b_S1_L001_R2_001.fastq.gz

In this example, running 'txg fastq upload foo' would upload the 3 FASTQs starting
with 'foo_' (because they are immediately inside the specified path), but not
the others (because they're inside nested directories).

Usage:
  txg fastqs upload [--project-id ID|--new-project NAME] PATH...

Flags:
  -n, --new-project string   Create a new project with the specified name and immediately upload the FASTQs to it.
  -p, --project-id id        Upload the FASTQs to the project with the specified ID.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_files_download

### Tool Description
Download project files

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download project files.

Download files from the specified project.  This may take a long
time, depending on the size of the files.  You will be prompted to confirm
the files to download before downloading begins.

Usage:
  txg files download PROJECT-ID

Flags:
      --file-id strings     IDs of the files to download.
      --target-dir string   Destination directory to download to (default is current directory). (default ".")

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_files_list

### Tool Description
List Files

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List Files

List files for the specified project ID.  A project ID is a unique key
generated for each project.  You can find the ID of a project by running 'txg
projects list'.

Usage:
  txg files list PROJECT-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_files_upload

### Tool Description
Upload files

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Upload files.

Upload the specified files to the specified project.  This may take a long
time, depending on the size of the files.  You will be prompted to confirm
the files to upload before uploading begins.

There are several supported file types including images, fastqs and others. 

FASTQ filenames must match the Illumina FASTQ naming conventions.  Valid
filenames look like:

    example_S1_L001_R1_001.fastq.gz

Individual FASTQs may be specified directly, e.g. 'txg upload *.fastq.gz'.  You
can also specify a directory instead, which will upload all FASTQ files
immediately inside that directory.  For example, if you have a directory
structure like this:

    foo/
        foo_S1_L001_I1_001.fastq.gz
        foo_S1_L001_R1_001.fastq.gz
        foo_S1_L001_R2_001.fastq.gz
        a/
            a_S1_L001_I1_001.fastq.gz
            a_S1_L001_R1_001.fastq.gz
            a_S1_L001_R2_001.fastq.gz
        b/
            b_S1_L001_I1_001.fastq.gz
            b_S1_L001_R1_001.fastq.gz
            b_S1_L001_R2_001.fastq.gz

In this example, running 'txg files upload foo' would upload the 3 FASTQs starting
with 'foo_' (because they are immediately inside the specified path), but not
the others (because they're inside nested directories).

Image file types supported are TIFF and JPEG.

Usage:
  txg files upload [--project-id ID|--new-project NAME] PATH...

Flags:
  -n, --new-project string   Create a new project with the specified name and immediately upload the FASTQs to it.
  -p, --project-id id        Upload the FASTQs to the project with the specified ID.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_projects_create

### Tool Description
Create a new project

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Create a new project

Create a new project with the specified name and optional description.  The
project name must be unique across all your projects.

You can update a project's name and description later by visiting the project's
settings page.

Usage:
  txg projects create --name NAME [--description DESC]

Flags:
      --description string   Project description (optional).
      --name string          Project name (required).

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_projects_list

### Tool Description
List your projects

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List your projects

Display a list of your projects, optionally sorted by a specific field.

Usage:
  txg projects list [flags]

Flags:
      --sort-by string   Sort the list by the specified field, which must be one of: id, name, created.  Default: unsorted.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_projects_update

### Tool Description
Update a project

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Update a project

Update the name and/or description of the specified project.  A project's ID can
be displayed by running 'txg projects list'.

Usage:
  txg projects update PROJECT-ID [flags]

Flags:
      --description string   Set the project description.
      --name string          Set the project name.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_references_delete

### Tool Description
Delete a custom reference

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Delete a custom reference

Delete the specified custom reference.  A reference's ID can be displayed by
running 'txg references list'.

Usage:
  txg references delete REFERENCE-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_references_get

### Tool Description
Show custom reference

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Show custom reference.

Show the details of the specified custom reference.  A reference's ID can be
displayed by running 'txg references list'.

Usage:
  txg references get REFERENCE-ID

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_references_list

### Tool Description
List custom references

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
List custom references

Display a list of your custom references, optionally sorted by a specific field.

Usage:
  txg references list

Flags:
      --sort-by string   Sort the list by the specified field, which must be one of: id, name, or created.  Default: unsorted.

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_references_update

### Tool Description
Update a custom reference

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Update a custom reference

Update the specified custom reference.  A reference's ID can be displayed by
running 'txg references list'.

Usage:
  txg references update REFERENCE-ID [flags]

Flags:
      --build-notes string   Specify how the custom reference was built (optional).
      --description string   Short description (optional).
      --name string          Set the reference name (optional).
      --organism string      Scientific name of the organism followed by the common name in parentheses (optional).

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## cellranger-arc_cloud_references_upload

### Tool Description
Upload a custom reference

### Metadata
- **Docker Image**: cumulusprod/cellranger-arc:2.2.0
- **Homepage**: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Upload a custom reference.

Upload the specified custom reference.  This may take a long time, depending on
the size of the reference file(s).

You can specify a custom reference as either of the following:

    * The path of the reference folder generated by cellranger mkref/mkvdjref
    * A reference tarball ending in .tar.gz

Usage:
  txg references upload FILE [--name NAME]

Flags:
      --name string   Reference name

Global Flags:
      --access-token string   Specify an access token to use.  Default: the saved token from 'txg auth setup'.
  -y, --assumeyes             Assume yes (don't interactively prompt for confirmation, etc).  Default: off.
  -H, --header header         Extra header to include in the request when sending HTTP requests to a server.  May be given multiple times to add multiple headers.  Each header must be of the form 'Header: value'.  Default: no extra headers.
  -h, --help                  Display help and exit.
  -q, --quiet                 Don't show progress or messages.  Default: off.
  -v, --verbose               Display extra debugging information.  Default: off.
      --version               Display version and exit.
```

## Metadata
- **Skill**: generated
