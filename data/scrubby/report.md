# scrubby CWL Generation Report

## scrubby_help

### Tool Description
Scrubby command-line application

### Metadata
- **Docker Image**: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
- **Homepage**: https://github.com/esteinig/scrubby
- **Package**: https://anaconda.org/channels/bioconda/packages/scrubby/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scrubby/overview
- **Total Downloads**: 726
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/esteinig/scrubby
- **Stars**: N/A
### Original Help Text
```text
scrubby 0.2.1
Scrubby command-line application

USAGE:
    scrubby <SUBCOMMAND>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    help           Prints this message or the help of the given subcommand(s)
    scrub-reads    Clean sequence reads by removing background taxa (Kraken2) or aligning reads (Minimap2)
```


## scrubby_scrub-reads

### Tool Description
Clean sequence reads by removing background taxa (Kraken2) or aligning reads (Minimap2)

### Metadata
- **Docker Image**: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
- **Homepage**: https://github.com/esteinig/scrubby
- **Package**: https://anaconda.org/channels/bioconda/packages/scrubby/overview
- **Validation**: PASS

### Original Help Text
```text
scrubby-scrub-reads 0.2.1
Clean sequence reads by removing background taxa (Kraken2) or aligning reads (Minimap2)

USAGE:
    scrubby scrub-reads [FLAGS] [OPTIONS] --input <input>... --kraken-db <kraken-db>... --output <output>...

FLAGS:
    -e, --extract    
            Extract reads instead of removing them.
            
            This flag reverses the depletion and makes the command an extraction process of reads that would otherwise
            be removed during depletion.
    -h, --help       
            Prints help information

    -K, --keep       
            Keep the working directory and intermediate files.
            
            This flag specifies that we want to keep the working directory and all intermediate files; otherwise the
            working directory is deleted.
    -V, --version    
            Prints version information


OPTIONS:
    -L, --compression-level <1-9>                         
            Compression level to use if compressing output [default: 6]

    -i, --input <input>...                                
            Input filepath(s) (fa, fq, gz, bz).
            
            For paired Illumina you may either pass this flag twice `-i r1.fq -i r2.fq` or give two files consecutively
            `-i r1.fq r2.fq`. Read identifiers for paired-end Illumina reads are assumed to be the same in forward and
            reverse read files (modern format) without trailing read orientations `/1` or `/2`.
    -k, --kraken-db <kraken-db>...                        
            Kraken2 database directory path(s).
            
            Specify the path to the database directory to be used for classification with `Kraken2`. This only needs to
            be specified if you would like to run the `Kraken2` analysis; otherwise `--kraken-report` and `--kraken-
            read` can be used. Note that multiple databases can be specified with `--kraken-db` which will be
            run and reads depleted/extracted in the order with which the database files were provided. You may either
            pass this flag twice `-k db1/ -k db2/` or give two files consecutively `-k db1/ db2/`.
    -t, --kraken-taxa <kraken-taxa>...
            Taxa and sub-taxa (Domain and below) to include from the report of `Kraken2`.
            
            You may specify multiple taxon names or taxonomic identifiers by passing this flag multiple times `-t
            Archaea -t 9606` or give taxa consecutively `-t Archaea 9606`. `Kraken2` reports are parsed and every
            taxonomic level below the provided taxon level will be included. Only taxa or sub-taxa that have reads
            directly assigned to them will be parsed. For example, when providing `Archaea` (Domain) all taxonomic
            levels below the `Domain` level are included until the next level of the same rank or higher is encountered
            in the report. This means that higher levels than `Domain` should be specified with `--kraken-taxa-direct`.
    -d, --kraken-taxa-direct <kraken-taxa-direct>...      
            Taxa to include directly from reads classified with `Kraken2`.
            
            Additional taxon names or taxonomic identifiers can be specified with this argument, such as those above the
            `Domain` level. These are directly added to the list of taxa to include while parsing the report without
            considering sub-taxa. For example, to retain `Viruses` one can specify the domains `-t Archaea -t Bacteria
            -t Eukaryota` with `--kraken-taxa` and add `-d 'other sequences' -d 'cellular organsisms' -d root` with
            `--kraken-taxa-direct`.
    -j, --kraken-threads <kraken-threads>                 
            Threads to use for Kraken2.
            
            Specify the number of threads with which to run `Kraken2`. [default: 4]
    -c, --min-cov <min-cov>
            Minimum query alignment coverage to deplete a read [default: 0]

    -l, --min-len <min-len>                               
            Minimum query alignment length to deplete a read [default: 0]

    -q, --min-mapq <min-mapq>                             
            Minimum mapping quality to deplete a read [default: 0]

    -m, --minimap2-index <minimap2-index>...              
            Reference sequence file(s) or index file(s) for `minimap2`.
            
            Specify the index file (.mmi) or the reference sequence(s) (.fasta) for alignment with `minimap2`. Note that
            multiple references can be specified with `--minimap2-index` which will be run and reads depleted/extracted
            in the order with which the database files were provided. You may either pass this flag twice `-m idx1.mmi
            -m idx2.mmi` or give two files consecutively `-m idx1.mmi idx2.mmi`.
    -x, --minimap2-preset <sr|map-ont|map-hifi|map-pb>    
            Minimap2 preset configuration - default is `sr`.
            
            Specify the preset configuration for `minimap2` - the default is short reads! [default: sr]
    -o, --output <output>...
            Output filepath(s) with reads removed or extracted (`--extract`).
            
            For paired Illumina you may either pass this flag twice `-o r1.fq -o r2.fq` or give two files consecutively
            `-o r1.fq r2.fq`. NOTE: The order of the pairs is assumed to be the same as that given for --input.
    -O, --output-format <u|b|g|l>                         
            u: uncompressed; b: Bzip2; g: Gzip; l: Lzma
            
            Default is to attempt to infer the output compression format automatically from the filename extension
            (gz|bz|bz2|lzma). This option is used to override that.
    -w, --workdir <workdir>                               
            Working directory containing intermediary files.
            
            Path to a working directory which contains the alignment and intermediary output files from the programs
            called during scrubbing. By default is the working output directory is named with a timestamp in the format:
            `Scrubby_{YYYYMMDDTHHMMSS}`.
```


## Metadata
- **Skill**: generated
