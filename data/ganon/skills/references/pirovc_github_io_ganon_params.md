[ganon2](..)

* [ganon2](..)

* [Quick Start](../start/)

* Parameters

* [Databases (ganon build)](../default_databases/)

* [Custom databases (ganon build-custom)](../custom_databases/)

* [Classification (ganon classify)](../classification/)

* [Reports (ganon report)](../reports/)

* [Table (ganon table)](../table/)

* [Output files](../outputfiles/)

* [Tutorials](../tutorials/)

[ganon2](..)

* Parameters

---

# Parameters[:)](#parameters "Permanent link")

```
usage: ganon [-h] [-v]
             {build,build-custom,update,classify,reassign,report,table} ...

- - - - - - - - - -
   _  _  _  _  _
  (_|(_|| |(_)| |
   _|   v. 2.3.0
- - - - - - - - - -

positional arguments:
  {build,build-custom,update,classify,reassign,report,table}
    build               Download and build ganon default databases
                        (refseq/genbank)
    build-custom        Build custom ganon databases
    update              Update ganon default databases
    classify            Classify reads against built databases
    reassign            Reassign reads with multiple matches with an EM
                        algorithm
    report              Generate reports from classification results
    table               Generate table from reports

options:
  -h, --help            show this help message and exit
  -v, --version         Show program's version number and exit.
```

ganon build

```
usage: ganon build [-h] [-g [ ...]] [-a [ ...]] [-l ] [-b [ ...]] [-o ] [-c] [-r] [-u ] [-m [ ...]] [-z [ ...]]
                   [--skip-genome-size] -d DB_PREFIX [-x ] [-t ] [-p ] [-k ] [-w ] [-s ] [-f ] [-j ] [-y ] [-v ]
                   [--restart] [--verbose] [--quiet] [--write-info-file]

options:
  -h, --help            show this help message and exit

required arguments:
  -g, --organism-group [ ...]
                        One or more organism groups to download [archaea, bacteria, fungi, human, invertebrate,
                        metagenomes, other, plant, protozoa, vertebrate_mammalian, vertebrate_other, viral]. Mutually
                        exclusive --taxid (default: None)
  -a, --taxid [ ...]    One or more taxonomic identifiers to download. e.g. 562 (-x ncbi) or 's__Escherichia coli' (-x
                        gtdb). Mutually exclusive --organism-group (default: None)
  -d, --db-prefix DB_PREFIX
                        Database output prefix

database arguments:
  -l, --level           Highest level to build the database. Options: any available taxonomic rank [species, genus,
                        ...], 'leaves' for taxonomic leaves or 'assembly' for a assembly/strain based analysis (default:
                        species)

download arguments:
  -b, --source [ ...]   Source to download [refseq, genbank] (default: ['refseq'])
  -o, --top             Download limited assemblies for each taxa. 0 for all. (default: 0)
  -c, --complete-genomes
                        Download only sub-set of complete genomes (default: False)
  -r, --reference-genomes
                        Download only sub-set of reference genomes (default: False)
  -u, --genome-updater
                        Additional genome_updater parameters (https://github.com/pirovc/genome_updater) (default: None)
  -m, --taxonomy-files [ ...]
                        Specific files for taxonomy - otherwise files will be downloaded (default: None)
  -z, --genome-size-files [ ...]
                        Specific files for genome size estimation - otherwise files will be downloaded (default: None)
  --skip-genome-size    Do not attempt to get genome sizes. Activate this option when using sequences not representing
                        full genomes. (default: False)

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

ganon build-custom

```
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
                        Database output prefix

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

ganon update

```
usage: ganon update [-h] -d DB_PREFIX [-o ] [-t ] [--restart] [--verbose] [--quiet] [--write-info-file]

options:
  -h, --help            show this help message and exit

required arguments:
  -d, --db-prefix DB_PREFIX
                        Existing database input prefix

important arguments:
  -o, --output-db-prefix
                        Output database prefix. By default will be the same as --db-prefix and overwrite files (default:
                        None)
  -t, --threads

optional arguments:
  --restart             Restart build/update from scratch, do not try to resume from the latest possible step.
                        {db_prefix}_files/ will be deleted if present. (default: False)
  --verbose             Verbose output mode (default: False)
  --quiet               Quiet output mode (default: False)
  --write-info-file     Save copy of target info generated to {db_prefix}.info.tsv. Can be re-used as --input-file for
                        further attempts. (default: False)
```

ganon classify

```
usage: ganon classify [-h] -d [DB_PREFIX ...] -o OUTPUT_PREFIX [-s [reads.fq[.gz] ...]]
                      [-p [reads.1.fq[.gz] reads.2.fq[.gz] ...]] [-a [file.tsv ...]] [-c [ ...]] [-e [ ...]] [-m ]
                      [--ranks [ ...]] [--min-count ] [--report-type ] [--skip-report] [--output-one] [--output-all]
                      [--output-unclassified] [--output-single] [-t ] [-b] [-f [ ...]] [-l [ ...]] [--verbose] [--quiet]

options:
  -h, --help            show this help message and exit

required arguments:
  -d, --db-prefix [DB_PREFIX ...]
                        Database input prefix[es]
  -o, --output-prefix OUTPUT_PREFIX
                        Output prefix for base report (.rep) and tree-like report (.tre).
  -s, --single-reads [reads.fq[.gz] ...]
                        Multi-fastq[.gz] file[s] to classify (default: None)
  -p, --paired-reads [reads.1.fq[.gz] reads.2.fq[.gz] ...]
                        Multi-fastq[.gz] pairs of file[s] to classify (default: None)
  -a, --batch-reads [file.tsv ...]
                        File with single- or paired-end reads to be processed in one run. Prefix can be repeated.
                        Example: prefix <tab> file1 [<tab> file2] (default: None)

cutoff/filter arguments:
  -c, --rel-cutoff [ ...]
                        Min. percentage of a read (set of k-mers) shared with a reference necessary to consider a match.
                        Generally used to remove low similarity matches. Single value or one per database (e.g. 0.7 1
                        0.25). 0 for no cutoff (default: [0.75])
  -e, --rel-filter [ ...]
                        Additional relative percentage of matches (relative to the best match) to keep. Generally used
                        to keep top matches above cutoff. Single value or one per hierarchy (e.g. 0.1 0). 1 for no
                        filter (default: [0.1])

post-processing/report arguments:
  -m, --multiple-matches
                        Method to solve reads with multiple matches [em, lca, skip]. em -> expectation maximiz