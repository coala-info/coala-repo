# cenmap CWL Generation Report

## cenmap

### Tool Description
(Cen)tromere (M)apping and (A)nnotation (P)ipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/cenmap:1.2.0--h577a1d6_0
- **Homepage**: https://github.com/logsdon-lab/CenMAP
- **Package**: https://anaconda.org/channels/bioconda/packages/cenmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cenmap/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2026-01-13
- **GitHub**: https://github.com/logsdon-lab/CenMAP
- **Stars**: N/A
### Original Help Text
```text
usage: cenmap [-h] [-i INPUT_ASM [INPUT_ASM ...] | -c CONFIG] [-g]
              [--hifi [HIFI ...]] [--ont [ONT ...]] [--reference REFERENCE]
              [-s SAMPLE] [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
              [-m {human,nhp}] [--omit-repeatmasker] [-o OUTPUT_DIR]
              [-p PROCESSES | -j JOBS] [--workflow-profile WORKFLOW_PROFILE]
              [--snake-opts SNAKE_OPTS] [-v]

(Cen)tromere (M)apping and (A)nnotation (P)ipeline.

options:
  -h, --help            show this help message and exit
  -g, --generate-config
                        Generate template configfile for --config.
  -v, --version         Show version and exit.

Data:
  Input data arguments.

  -i INPUT_ASM [INPUT_ASM ...], --input-asm INPUT_ASM [INPUT_ASM ...]
                        Input assembly files for one sample. Supports fasta,
                        fasta.gz, fa, or fa.gz.
  -c CONFIG, --config CONFIG
                        Input configfile. If provided, other arguments are
                        ignored. Allows submission of multiple samples or
                        parameter tuning.
  --hifi [HIFI ...]     Input PacBio HiFi reads for assembly evaluation with
                        NucFlag. Supports BAM, CRAM, or gzipped/uncompressed
                        fastq/fasta files.
  --ont [ONT ...]       Input ONT reads with MM and ML tags for CDR detection.
                        Supports BAM and gzipped/uncompressed fastq WITH MM
                        and ML tags in header.
  --reference REFERENCE
                        Path to reference assembly used to rename and reorient
                        contigs. Defaults to CHM13 v2.0 and assumes contig
                        names are exact matches to --chromosomes. If not
                        provided and --chromosomes set to 'none', no reference
                        chromosome mapping is performed. Avoid changing unless
                        you know what you're doing.

Configuration:
  Configuration arguments.

  -s SAMPLE, --sample SAMPLE
                        Sample name.
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Chromosomes to partition outputs. Specifying 'none'
                        will not partition output. Format: 'chr[0-9XY]+|none'
  -m {human,nhp}, --mode {human,nhp}
                        Species of sample. Either 'human' or non-human primate
                        ('nhp').
  --omit-repeatmasker   Omit RepeatMasker and its outputs from the workflow.
                        This removes repeat annotations from plots and
                        switches the partial detection algorithm to use kmers
                        instead of RepeatMasker repeats. Putative alpha-
                        satellite annotations are produced using srf/trf. Use
                        this option for a substantial speedup in centromere
                        detection.

Workflow:
  Workflow configuration arguments.

  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory.
  -p PROCESSES, --processes PROCESSES
                        Number of processes to run. Minimum of 4 processes.
  -j JOBS, --jobs JOBS  Number of jobs to run. Requires setting --workflow-
                        profile and one of the snakemake cluster plugins.
                        Minimum of 4 jobs.
  --workflow-profile WORKFLOW_PROFILE
                        Custom workflow profile for snakemake.
  --snake-opts SNAKE_OPTS
                        Additional snakemake options.
```

