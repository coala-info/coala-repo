# tomm40_wgs CWL Generation Report

## tomm40_wgs_TOMM40_WGS

### Tool Description
Genotyping TOMM40'523 Poly-T Polymorphisms Using Whole-Genome Sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/tomm40_wgs:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/RushAlz/TOMM40_WGS/
- **Package**: https://anaconda.org/channels/bioconda/packages/tomm40_wgs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tomm40_wgs/overview
- **Total Downloads**: 581
- **Last updated**: 2025-09-29
- **GitHub**: https://github.com/RushAlz/TOMM40_WGS
- **Stars**: N/A
### Original Help Text
```text
TOMM40_WGS: Genotyping TOMM40'523 Poly-T Polymorphisms Using Whole-Genome Sequencing

Usage: TOMM40_WGS [OPTIONS]

Parameters:
   --input_wgs               Input BAM/CRAM file(s). Can be a single file, glob pattern ("*.cram"; quotes are mandatory).
   --input_table             TSV file with columns 'sample_id' and 'path' listing input files.
   --configfile              YAML configuration file (default: config.yaml in script directory).
   --ref_fasta               Reference genome FASTA file.
   --genome_build            Genome build.
   --output_dir              Output directory.
   --cores                   Number of cores to use (default: 1).

Useful Snakemake parameters:
   --conda-create-envs-only  Only creates the job-specific conda environments then exits
   -k, --keep-going          Continue with independent jobs if a job fails
   -n, --dryrun              Do not execute anything

Examples:
   # Run with a single input file
   TOMM40_WGS --input_wgs sample.bam

   # Run with multiple files using glob pattern (must be quoted)
   TOMM40_WGS --input_wgs "*.cram"

   # Run with a sample table
   TOMM40_WGS --input_table samples.tsv

   # Run with just a config file (parameters will be read from config)
   TOMM40_WGS --configfile my_config.yaml

More info at https://github.com/RushAlz/TOMM40_WGS
```

