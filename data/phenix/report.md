# phenix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phenix_filter_vcf | Failed | tool bug: filter_vcf.py calls filter_variants(out_vcf=...) which the phe library does not accept, so every run stops with TypeError |
| phenix_prepare_reference | PASS | mpileup/bwa mode writes the bwa index and .fai; the gatk variant stops with GATK_JAR not found (the GATK jar is not in the image) |
| phenix_vcf2distancematrix | PASS | default mode checked against the VCF (11 and 12 SNPs to the reference, 0 between samples, N positions skipped); --remove-recombination not confirmed because the repo reference genome file is only a path stub |
| phenix_vcf2fasta | PASS | output has the same records as the repo gold file (record order differs); positions checked against the VCF PASS sites |
| phenix_vcf2json | PASS |  |

## phenix_filter_vcf

### Tool Description
OUTPUT [--reference REFERENCE] [--only-good]  

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phenix.py filter_vcf [-h] --vcf VCF
                            [--filters FILTERS | --config CONFIG] --output
                            OUTPUT [--reference REFERENCE] [--only-good]

Filter the VCF using provided filters.

optional arguments:
  -h, --help            show this help message and exit
  --vcf VCF, -v VCF     VCF file to (re)filter.
  --filters FILTERS, -f FILTERS
                        Filter(s) to apply as key:threshold pairs, separated
                        by comma. Recommendations: GATK:
                        mq_score:30,min_depth:10,ad_ratio:0.9 Mpileup:
                        mq_score:30,min_depth:10,dp4_ratio:0.9
  --config CONFIG, -c CONFIG
                        Config with filters in YAML format.
                        E.g.filters:-key:value
  --output OUTPUT, -o OUTPUT
                        Location for filtered VCF to be written.
  --reference REFERENCE, -r REFERENCE
                        mpileup version <= 1.3 do not output all positions.
                        This is required to fix rfrence base in VCF.
  --only-good           Write only variants that PASS all filters (default all
                        variants are written).
```

## phenix_prepare_reference

### Tool Description
Prepare reference for SNP pipeline by generating required aux files. 

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phenix.py prepare_reference [-h] --reference REFERENCE
                                   [--mapper MAPPER] [--variant VARIANT]

Prepare reference for SNP pipeline by generating required aux files.

optional arguments:
  -h, --help            show this help message and exit
  --reference REFERENCE, -r REFERENCE
                        Path to reference file to prepare.
  --mapper MAPPER       Available mappers: ['bwa', 'bowtie2']
  --variant VARIANT     Available variants: ['mpileup', 'gatk']
```

## phenix_vcf2fasta

### Tool Description
[--regexp REGEXP] --out OUT                            [--with-mixtures WITH_MIXTURES] 

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phenix.py vcf2fasta [-h]
                           (--directory DIRECTORY | --input INPUT [INPUT ...])
                           [--regexp REGEXP] --out OUT
                           [--with-mixtures WITH_MIXTURES]
                           [--column-Ns COLUMN_NS] [--column-gaps COLUMN_GAPS]
                           [--sample-Ns SAMPLE_NS] [--sample-gaps SAMPLE_GAPS]
                           [--sample-Ns-gaps-auto-factor SAMPLE_NS_GAPS_AUTO_FACTOR]
                           [--reference REFERENCE | --remove-invariant-npos]
                           [--reflength REFLENGTH]
                           [--include INCLUDE | --exclude EXCLUDE]
                           [--with-stats WITH_STATS]

Combine multiple VCFs into a single FASTA file.

optional arguments:
  -h, --help            show this help message and exit
  --directory DIRECTORY, -d DIRECTORY
                        Path to the directory with .vcf files.
  --input INPUT [INPUT ...], -i INPUT [INPUT ...]
                        List of VCF files to process.
  --regexp REGEXP       Regular expression for finding VCFs in a directory.
  --out OUT, -o OUT     Path to the output FASTA file.
  --with-mixtures WITH_MIXTURES
                        Specify this option with a threshold to output
                        mixtures above this threshold.
  --column-Ns COLUMN_NS
                        Keeps columns with fraction of Ns below specified
                        threshold.
  --column-gaps COLUMN_GAPS
                        Keeps columns with fraction of Ns below specified
                        threshold.
  --sample-Ns SAMPLE_NS
                        Keeps samples with fraction of Ns below specified
                        threshold or put 'auto'.Fraction expressed as fraction
                        of genome. Requires --reflength or --reference.
  --sample-gaps SAMPLE_GAPS
                        Keeps samples with fraction of gaps below specified
                        threshold or put 'auto'.Fraction expressed as fraction
                        of genome. Requires --reflength or --reference.
  --sample-Ns-gaps-auto-factor SAMPLE_NS_GAPS_AUTO_FACTOR
                        When using 'auto' option for --sample-gaps or
                        --sample-Ns, remove sample that havegaps or Ns this
                        many times above the stddev of all samples. [Default:
                        2.0]
  --reference REFERENCE
                        If path to reference specified (FASTA), then whole
                        genome will be written to alignment.
  --remove-invariant-npos
                        Remove all positions that invariant apart from N
                        positions.
  --reflength REFLENGTH
                        Length of reference. Either as int or can be worked
                        out from fasta file. Ignored if --reference is used.
  --include INCLUDE     Only include positions in BED file in the FASTA
  --exclude EXCLUDE     Exclude any positions specified in the BED file.
  --with-stats WITH_STATS
                        If a path is specified, then position of the outputed
                        SNPs is stored in this file.
```

## phenix_vcf2distancematrix

### Tool Description
--out OUT [--deletion STRING]                                     [--substitution STRING] 

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phenix.py vcf2distancematrix [-h]
                                    (--directory DIRECTORY | --input INPUT [INPUT ...] | --alignment-input MULTI FASTA FILE)
                                    --out OUT [--deletion STRING]
                                    [--substitution STRING]
                                    [--include BED FILE | --exclude BED FILE]
                                    [--remove-recombination]
                                    [--refgenome FASTA FILE]
                                    [--refgenomename STRING]
                                    [--threshold FLOAT] [--threads INT]
                                    [--format STRING] [--tree FILE]
                                    [--with-stats]

Combine multiple VCFs into a distance matrix. Distance measures according to
five different models are available: * Number of differences * Jukes-Cantor
distance (jc69) * Tajima-Nei distance (k80) * Kimura 2-parameter distance
(tn84) * Tamura 3-parameter distance (t93)

optional arguments:
  -h, --help            show this help message and exit
  --directory DIRECTORY, -d DIRECTORY
                        Path to the directory with .vcf files. Input option 1.
  --input INPUT [INPUT ...], -i INPUT [INPUT ...]
                        List of VCF files to process. Input option 2.
  --alignment-input MULTI FASTA FILE, -a MULTI FASTA FILE
                        Multi fasta file with whole genome input alignment.
                        Input option 3.
  --out OUT, -o OUT     Path to the maxtrix output file in given format.
                        [REQUIRED. default format is tab separated. use
                        --format to change format]
  --deletion STRING     Method of recombination filtering. Either 'pairwise'
                        or 'complete' ['pairwise']
  --substitution STRING
                        Substituition model. Either 'number_of_differences',
                        'jc69', 'k80', 'tn84' or 't93'
                        ['number_of_differences']
  --include BED FILE    Only include positions in BED file in the FASTA
  --exclude BED FILE    Exclude any positions specified in the BED file.
  --remove-recombination
                        Attempt to remove recombination from distance matrix.
                        [don't]
  --refgenome FASTA FILE, -g FASTA FILE
                        Reference genome used for SNP calling [Required for
                        recombination removal].
  --refgenomename STRING, -n STRING
                        Name of reference genome in input alignment [Required
                        if input option 3 is used and reference is not named
                        'reference'].
  --threshold FLOAT, -k FLOAT
                        Density tyhreshold above mean density for relevant
                        pair. [1.0].
  --threads INT         Number of threads to use. [1].
  --format STRING       Change format for output file. Available options csv,
                        tsv and mega. [tsv]
  --tree FILE, -t FILE  Make an NJ tree and write it to the given file in
                        newick format. [Default: Don't make tree, only matrix]
  --with-stats          Write additional files with information on removed
                        recombinant SNPs. [don't]
```

## phenix_vcf2json

### Tool Description
[--vcf_is_filtered] [--summary_info]  

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phenix.py vcf2json [-h] --input INPUT
                          [--output_file_prefix OUTPUT_FILE_PREFIX] [--nozip]
                          [--vcf_is_filtered] [--summary_info]

Converts the postions of variants and ignored/missing positions in either a
'raw' or filtered VCF file to a json string and writes it to a file. The json
contains 6 arrays for each chromosome in the VCF file: g_positions,
a_positions, t_positions, c_positions, gap_positions, n_positions

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        path to a VCF file
  --output_file_prefix OUTPUT_FILE_PREFIX, -o OUTPUT_FILE_PREFIX
                        Path to the json output file (without file extension).
                        Default: sample_name
  --nozip, -z           Do not gzip json when writing file. (default: Yes,
                        gzip it.)
  --vcf_is_filtered, -f
                        Required: Confirm that the input vcf is filtered. It
                        is stronglyrecommended to filter the file with Phenix
                        using the sameparameters that are used throughout the
                        database this jason file is meant for.
  --summary_info, -s    Print summary of the json string
```

