# themis CWL Generation Report

## themis_build-custom

### Tool Description
Build a custom database for Ganon.

### Metadata
- **Docker Image**: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
- **Homepage**: https://github.com/xujialupaoli/Themis
- **Package**: https://anaconda.org/channels/bioconda/packages/themis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/themis/overview
- **Total Downloads**: 142
- **Last updated**: 2026-01-02
- **GitHub**: https://github.com/xujialupaoli/Themis
- **Stars**: N/A
### Original Help Text
```text
usage: ganon build-custom [-h] [-i [ ...]] [-e ] [-c] [-n ] [-a ] [-l ] [-m [ ...]] [-z [ ...]] [--skip-genome-size]
                          [-r [ ...]] [-q [ ...]] -d DB_PREFIX [-x ] [-t ] [-p ] [-k ] [-w ] [-s ] [-f ] [-j ] [-y ]
                          [-v ] [--restart] [--verbose] [--quiet] [--write-info-file]

options:
  -h, --help            show this help message and exit

required arguments:
  -i, --input [ ...]    Input file(s) and/or folder(s). Mutually exclusive --input-file. (default: None)
  -e, --input-extension 
                        Required if --input contains folder(s). Wildcards/Shell Expansions not supported (e.g. *).
                        (default: fna.gz)
  -c, --input-recursive
                        Look for files recursively in folder(s) provided with --input (default: False)
  -d, --db-prefix DB_PREFIX
                        Database output prefix (default: None)

custom arguments:
  -n, --input-file      Tab-separated file with all necessary file/sequence information. Fields: file [<tab> target
                        <tab> node <tab> specialization <tab> specialization name]. For details:
                        https://pirovc.github.io/ganon/custom_databases/. Mutually exclusive --input (default: None)
  -a, --input-target    Target to use [file, sequence]. Parse input by file or by sequence. Using 'file' is recommended
                        and will speed-up the building process (default: file)
  -l, --level           Max. level to build the database. By default, --level is the --input-target. Options: any
                        available taxonomic rank [species, genus, ...] or 'leaves' (requires --taxonomy). Further
                        specialization options [assembly, custom]. assembly will retrieve and use the assembly accession
                        and name. custom requires and uses the specialization field in the --input-file. (default: None)
  -m, --taxonomy-files [ ...]
                        Specific files for taxonomy - otherwise files will be downloaded (default: None)
  -z, --genome-size-files [ ...]
                        Specific files for genome size estimation - otherwise files will be downloaded (default: None)
  --skip-genome-size    Do not attempt to get genome sizes. Activate this option when using sequences not representing
                        full genomes. (default: False)

ncbi arguments:
  -r, --ncbi-sequence-info [ ...]
                        Uses NCBI e-utils webservices or downloads accession2taxid files to extract target information.
                        [eutils, nucl_gb, nucl_wgs, nucl_est, nucl_gss, pdb, prot, dead_nucl, dead_wgs, dead_prot or one
                        or more accession2taxid files from https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/].
                        By default uses e-utils up-to 50000 sequences or downloads nucl_gb nucl_wgs otherwise. (default:
                        [])
  -q, --ncbi-file-info [ ...]
                        Downloads assembly_summary files to extract target information. [refseq, genbank,
                        refseq_historical, genbank_historical or one or more assembly_summary files from
                        https://ftp.ncbi.nlm.nih.gov/genomes/] (default: ['refseq', 'genbank'])

important arguments:
  -x, --taxonomy        Set taxonomy to enable taxonomic classification, lca and reports [ncbi, gtdb, skip] (default:
                        ncbi)
  -t, --threads 

advanced arguments:
  -p, --max-fp          Max. false positive for bloom filters. Mutually exclusive --filter-size. Defaults to 0.001 with
                        --filter-type hibf or 0.05 with --filter-type ibf. (default: None)
  -k, --kmer-size       The k-mer size to split sequences. (default: 19)
  -w, --window-size     The window-size to build filter with minimizers. (default: 31)
  -s, --hash-functions 
                        The number of hash functions for the interleaved bloom filter [1-5]. With --filter-type ibf, 0
                        will try to set optimal value. (default: 4)
  -f, --filter-size     Fixed size for filter in Megabytes (MB). Mutually exclusive --max-fp. Only valid for --filter-
                        type ibf. (default: 0)
  -j, --mode            Create smaller or faster filters at the cost of classification speed or database size,
                        respectively [avg, smaller, smallest, faster, fastest]. If --filter-size is used,
                        smaller/smallest refers to the false positive rate. By default, an average value is calculated
                        to balance classification speed and database size. Only valid for --filter-type ibf. (default:
                        avg)
  -y, --min-length      Skip sequences smaller then value defined. 0 to not skip any sequence. Only valid for --filter-
                        type ibf. (default: 0)
  -v, --filter-type     Variant of bloom filter to use [hibf, ibf]. hibf requires raptor >= v3.0.1 installed or binary
                        path set with --raptor-path. --mode, --filter-size and --min-length will be ignored with hibf.
                        hibf will set --max-fp 0.001 as default. (default: hibf)

optional arguments:
  --restart             Restart build/update from scratch, do not try to resume from the latest possible step.
                        {db_prefix}_files/ will be deleted if present. (default: False)
  --verbose             Verbose output mode (default: False)
  --quiet               Quiet output mode (default: False)
  --write-info-file     Save copy of target info generated to {db_prefix}.info.tsv. Can be re-used as --input-file for
                        further attempts. (default: False)
```


## themis_profile

### Tool Description
Profile microbial communities using a compressed de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
- **Homepage**: https://github.com/xujialupaoli/Themis
- **Package**: https://anaconda.org/channels/bioconda/packages/themis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: themis profile [-h] -r [...] [--single]--db-prefix DB_PREFIX -i REF_INFO -o [-t] [-k]

options:
  -h, --help        show this help message and exit
  -r, --reads       For paired-end data, specify mates consecutively: -r R1.fq
                    -r R2.fq. For single-end data, use --single and give one
                    -r per file.
  --single          Treat input as single-end reads.
  -d, --db-prefix   Database input prefix.
  -i, --ref-info    Tab-separated reference metadata file. Fields: strain_name
                    <tab> strain_taxid <tab> species_taxid <tab> species_name
                    <tab> genome_path. strain_name and strain_taxid must be
                    unique.
  -o, --output      Output directory for profiling results.
  -t, --threads     Number of threads.
  -k, --kmer-size   k-mer size used in the ccDBG-based profiling step.
```


## Metadata
- **Skill**: generated

## themis

### Tool Description
Themis: a robust and accurate species-level metagenomic profiler.

### Metadata
- **Docker Image**: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
- **Homepage**: https://github.com/xujialupaoli/Themis
- **Package**: https://anaconda.org/channels/bioconda/packages/themis/overview
- **Validation**: PASS
### Original Help Text
```text
usage: themis [-h] <command> ...

Themis: a robust and accurate species-level metagenomic profiler.

positional arguments:
  <command>
    build-custom  Build custom themis databases.
    profile       Profile reads against custom databases.

options:
  -h, --help      show this help message and exit
```

