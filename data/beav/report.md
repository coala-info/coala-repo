# beav CWL Generation Report

## beav

### Tool Description
BEAV- Bacterial Element Annotation reVamped

### Metadata
- **Docker Image**: quay.io/biocontainers/beav:1.4.0--hdfd78af_1
- **Homepage**: https://github.com/weisberglab/beav
- **Package**: https://anaconda.org/channels/bioconda/packages/beav/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beav/overview
- **Total Downloads**: 12.9K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/weisberglab/beav
- **Stars**: N/A
### Original Help Text
```text
BEAV version 1.4.0

--help

usage: beav [--input INPUT] [--output OUTPUT_DIRECTORY] [--strain STRAIN] [--bakta_arguments BAKTA_ARGUMENTS] [--tiger_arguments TIGER_ARGUMENTS][--agrobacterium AGROBACTERIUM] [--skip_macsyfinder] [--skip_integronfinder][--skip_defensefinder] [--skip_tiger] [--skip_gapmind][--skip_dcscan-swa] [--skip_antismash] [--help] [--threads THREADS] [--genbank] [--continue]
    BEAV- Bacterial Element Annotation reVamped
    Input/Output:
        --input, -i INPUT.fna
                Input file in fasta nucleotide format (Required)
        --output DIRECTORY
                Output directory (default: current working directory)
        --strain STRAIN
                Strain name (default: input file prefix)
        --bakta_arguments ARGUMENTS
                Additional arguments specific to Bakta
        --antismash_arguments ARGUMENTS
                Additional arguments specific to antiSMASH (Default: "")
        --tiger_blast_database DATABASE_PATH
                Path to a reference genome blast database for TIGER2 ICE analysis (Required unless --skip_tiger is used)
        --run_operon_email EMAIL
                Run the Operon-mapper pipeline [remote]. Requires an email address for the operon-mapper webserver job
    Options:
        --agrobacterium
                Agrobacterium specific tools that identify biovar/species group, Ti/Ri plasmid, T-DNA borders, virboxes and traboxes
        --skip_macsyfinder
                Skip detection and annotation of secretion systems
        --skip_integronfinder
                Skip detection and annotation of integrons
        --skip_defensefinder
                Skip detection and annotation of anti-phage defense systems
        --skip_tiger
                Skip detection and annotation of integrative conjugative elements (ICEs)
        --skip_gapmind
                Skip detection of amino acid biosynthesis and carbon metabolism pathways
        --skip_dbscan-swa
                Skip detection and annotation of prophage
        --skip_antismash
                Skip detection and annotation of biosynthetic gene clusters
        --gbk
                Use a GenBank file as input
    General:
        --help, -h
                Show BEAV help message
        --threads, -t
                Number of CPU threads
        --continue
                Continue a previously started run
```

