# thapbi-pict CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| thapbi-pict_assess | PASS |  |
| thapbi-pict_classify | PASS |  |
| thapbi-pict_conflicts | PASS |  |
| thapbi-pict_denoise | PASS |  |
| thapbi-pict_dump | PASS |  |
| thapbi-pict_edit-graph | PASS |  |
| thapbi-pict_ena-submit | PASS |  |
| thapbi-pict_fasta-nr | PASS |  |
| thapbi-pict_import | PASS |  |
| thapbi-pict_load-tax | PASS |  |
| thapbi-pict_prepare-reads | PASS |  |
| thapbi-pict_sample-tally | PASS |  |
| thapbi-pict_summary | PASS |  |

## thapbi-pict_load-tax

### Tool Description
Load an NCBI taxonomy dump into a marker database.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict load-tax [-h] -t DIRNAME -d DATABASE [-a ANCESTORS] [-v]

Load an NCBI taxonomy dump into a marker database.

options:
  -h, --help            show this help message and exit
  -t DIRNAME, --tax DIRNAME
                        Folder containing NCBI taxonomy files `names.dmp` etc.
  -d DATABASE, --database DATABASE
                        Which database to write to (or create).
  -a ANCESTORS, --ancestors ANCESTORS
                        Comma separated list of NCBI taxids at genus level or
                        higher. Default is 4762 for Oomycetes, use 4776 for
                        Peronosporales, or 4783 for Phytophthora only.
  -v, --verbose         Verbose logging.
```

## thapbi-pict_import

### Tool Description
Load a FASTA file into a database. Supports several naming conventions for the FASTA titles (simple, ncbi, sintax, taxid, obitools).

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict import [-h] -i INPUT [INPUT ...] -d DATABASE [-k MARKER]
                          [-l PRIMER] [-r PRIMER] [--minlen LENGTH]
                          [--maxlen LENGTH] [-n NAME] [-x] [-g]
                          [-c {simple,ncbi,sintax,taxid,obitools}] [-s CHAR]
                          [--ignore-prefixes STEM [STEM ...]] [-t DIRNAME]
                          [-v]

Load a FASTA file into a database. Supports multiple entries in a single
record using a FASTA title split by the specified separator character. Will
use the NCBI taxid alone if given and in the database. If not,by default
verifies genus/species names against the pre-loaded taxonomy, failing that a
matching genus, otherwise rejected. By default assumes FASTA title line
entries are an accesion followedby an exact species name only, optionally with
taxid=... to finish.With NCBI heuristics enabled, tries to split the species
and any following free text using the taxonomy names in the DB. For SINTAX
format only the genus and species are used. For ObiTools format, the NCBI
taxid alone is used if in the DB, falling back on the genus and species given.
For NCBI taxonomy mode, looks for text like taxid=123456 and takes
genus/species from the DB, ignoring all the other text. See also the 'load-
tax' command.

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        One or more prepared FASTA filenames or folder names
                        (containing files named `*.fasta`).
  -d DATABASE, --database DATABASE
                        Which database to write to (or create).
  -k MARKER, --marker MARKER
                        Unique marker name for a barcode, linked to a PCR
                        primer pair for a diagnostic amplicon. e.g. ITS1, COI,
                        12S. If not already in the DB, it will be added but
                        this requires both left and right primers, and min and
                        max product length are recommended. Required unless DB
                        has exactly one marker already defined in it.
  -l PRIMER, --left PRIMER
                        Left primer sequence to record in DB for this marker.
                        Can use IUPAC ambiguity codes. Default DB uses 21bp
                        ITS6 'GAAGGTGAAGTCGTAACAAGG' from Cooke et al. 2000
                        https://doi.org/10.1006/fgbi.2000.1202
  -r PRIMER, --right PRIMER
                        Right primer sequence to record in the DB for this
                        marker. Will find and remove the reverse complement
                        from end of marker sequences. Can use IUPAC ambiguity
                        codes. Default DB uses 20bp 5.8S-1R primer
                        'GCARRGACTTTCGTCCCYRC' from Scibetta et al. 2012
                        https://doi.org/10.1016/j.mimet.2011.12.012 - meaning
                        look for 'GYRGGGACGAAAGTCYYTGC' after the marker.
  --minlen LENGTH       Minimum acceptable amplicon length for this import.
                        Default 100 if marker not already defined. Will be
                        recorded for a new marker, if marker already defined
                        can use a stricter value for this import.
  --maxlen LENGTH       Maximum acceptable amplicon length for this import.
                        Default 1000 if marker not already defined. Will be
                        recorded for a new marker, if marker already defined
                        can use a stricter value for this import.
  -n NAME, --name NAME  Name to record for this data source (string).
  -x, --lax             Accept species names without pre-loaded taxonomy.
  -g, --genus           Record at genus level only (and only validate at genus
                        level, unless using -x / --lax in which case any word
                        is accepted as a genus).
  -c {simple,ncbi,sintax,taxid,obitools}, --convention {simple,ncbi,sintax,taxid,obitools}
                        Which naming convention does the FASTA file follow.
  -s CHAR, --sep CHAR   FASTA description multi-entry separator character.
                        Default none meaning assume single entries.
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -t DIRNAME, --temp DIRNAME
                        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  -v, --verbose         Verbose logging.
```

## thapbi-pict_dump

### Tool Description
Export a marker database to a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict dump [-h] [-d DATABASE] [-o FILENAME] [-k MARKER] [-m]
                        [-f {txt,fasta}] [-g GENUS] [-s SPECIES] [--sep CHAR]
                        [-v]

Export a marker database to a text file.

options:
  -h, --help            show this help message and exit
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
  -o FILENAME, --output FILENAME
                        File to write to (default '-' meaning stdout)
  -k MARKER, --marker MARKER
                        Which amplicon marker from the DB wanted? Default all.
                        Recommend for minimal and FASTA output.
  -m, --minimal         Minimal output, one record per trimmed sequence with
                        MD5 and species list - rather than all entries with
                        original ID, species, and taxid.
  -f {txt,fasta}, --format {txt,fasta}
                        Format to write out (default 'txt' for debugging).
  -g GENUS, --genus GENUS
                        Which genus (or genera) to export (comma separated
                        list). Default is not to filter by genus.
  -s SPECIES, --species SPECIES
                        Which species to export (comma separated list, ignores
                        any spaces after each comma). Requires a single genus
                        argument be given. Default is not to filter by
                        species.
  --sep CHAR            FASTA description entry separator, default semi-colon.
  -v, --verbose         Verbose logging.

e.g. `thapbi_pict dump -d ... -g Peronospora -o Peronospora.txt`
```

## thapbi-pict_conflicts

### Tool Description
Count genus or species conflicts in a marker database.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict conflicts [-h] [-d DATABASE] [-o FILENAME] [-v]

Count genus or species conflicts in a marker database.

options:
  -h, --help            show this help message and exit
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
  -o FILENAME, --output FILENAME
                        File to write to (default '-' meaning stdout)
  -v, --verbose         Verbose logging.

Number of marker or genus level conflicts is used as the return code. e.g.
`thapbi_pict conflicts -d ... -o conflicts.txt ; echo $?`
```

## thapbi-pict_prepare-reads

### Tool Description
Trim and merge paired FASTQ files of marker amplicons.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict prepare-reads [-h] -i FASTQ [FASTQ ...]
                                 [--ignore-prefixes STEM [STEM ...]] -o
                                 DIRNAME [-a INTEGER] [-f FLOAT] [-d DATABASE]
                                 [-k MARKERS] [--flip]
                                 [--merged-cache DIRNAME] [-t DIRNAME] [-v]
                                 [--cpu CPU]

Trim and merge paired FASTQ files of marker amplicons.

options:
  -h, --help            show this help message and exit
  -i FASTQ [FASTQ ...], --input FASTQ [FASTQ ...]
                        One or more paired FASTQ filenames or folder names
                        (containing files named `*.fastq` or `*.fastq.gz`).
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -o DIRNAME, --output DIRNAME
                        Output directory. Required.
  -a INTEGER, --abundance INTEGER
                        Minimum abundance applied to unique marker sequences
                        in each sample (i.e. each FASTQ pair). Default 2
                        meaning only exclude singletons.
  -f FLOAT, --abundance-fraction FLOAT
                        Minimum abundance fraction, low frequency noise
                        threshold applied to unique marker sequences in each
                        sample. e.g. 0.001 meaning 0.1%. Default zero, meaning
                        not used.
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
  -k MARKERS, --markers MARKERS
                        If the DB defines multiple amplicon markers, but you
                        only wish to use a subset, list them as a comma-
                        separated string
  --flip                Also check reverse complement strand for primers.
  --merged-cache DIRNAME
                        Advanced option. Cache directory for temporary per-
                        sample FASTA file after overlap merging (usually the
                        slowest step), but before primer trimming and
                        abundance threshold.
  -t DIRNAME, --temp DIRNAME
                        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  -v, --verbose         Verbose logging.
  --cpu CPU             Number of parallel threads to use in called tools. Use
                        zero for all available. Default 1.

Each pair of input files should follow the naming style `XXX_1.fastq[.gz]` and
`XXX_2.fastq[.gz]`, or `XXX_R1.fastq[.gz]` and `XXX_R2.fastq[.gz]`, or
`XXX_R1_001.fastq[.gz]` and `XXX_R2_001.fastq[.gz]`, and will given an output
file `XXX.fasta`. These FASTA files have a header, and their sequences are
non-redundant, named by MD5 checksum and their abundance, and sorted by
decreasing abundance then alphabetically by sequence.
```

## thapbi-pict_fasta-nr

### Tool Description
Prepare non-redundant FASTA file using MD5 naming.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict fasta-nr [-h] [-i INPUT [INPUT ...]]
                            [--ignore-prefixes STEM [STEM ...]] [-r INPUT]
                            [-o FILENAME] [-a ABUNDANCE] [--minlen LENGTH]
                            [--maxlen LENGTH] [-v]

Prepare non-redundant FASTA file using MD5 naming.

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        One or more FASTA files.
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -r INPUT, --revcomp INPUT
                        One or more FASTA files as input to be reverse-
                        complemented on loading.
  -o FILENAME, --output FILENAME
                        Single output filename, '-' for stdout (default). Can
                        be a directory if a single -i/-r input file given.
  -a ABUNDANCE, --abundance ABUNDANCE
                        Minimum abundance to require before outputting a
                        sequence. Default no minimum.
  --minlen LENGTH       Minimum length sequence to accept (default 100).
  --maxlen LENGTH       Maximum length sequence to accept (default 1000).
  -v, --verbose         Verbose logging.

Each unique sequence will be named `<MD5>_<count>` using the MD5 checksum of
the upper case sequence and its total abundance. Input files may use
`<prefix>_<count>` naming, this count will be used for the associated
sequence.
```

## thapbi-pict_denoise

### Tool Description
Apply UNOISE based read-correction to denoise FASTA file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict denoise [-h] -i FASTA [FASTA ...] [-o FASTA]
                           [--denoise {unoise-l,usearch,vsearch}] [-α FLOAT]
                           [-γ INT] [-t TOTAL] [--minlen LENGTH]
                           [--maxlen LENGTH] [--temp DIRNAME] [--cpu CPU] [-v]

Apply UNOISE based read-correction to denoise FASTA file(s).

options:
  -h, --help            show this help message and exit
  -i FASTA [FASTA ...], --input FASTA [FASTA ...]
                        One or more input FASTA files.
  -o FASTA, --output FASTA
                        Single output FASTA filename, '-' for stdout
                        (default).
  --denoise {unoise-l,usearch,vsearch}
                        Choice of read-correction algorithm, default
                        'unoise-l' for built-in reimplementation of the Edgar
                        (2016) UNOISE algorithm using Levenshtein distance.
                        Use 'usearch' or 'vsearch' to call external tools
                        `usearch -unoise3 ...` or `vsearch --cluster_unoise
                        ...` respectively.
  -α FLOAT, --unoise_alpha FLOAT, --unoise-alpha FLOAT
                        UNOISE read-correction alpha parameter (α), used in
                        skew threshold function beta (β). Default 2.0 for
                        UNOISE-L, tool defaults for USEARCH and VSEARCH.
  -γ INT, --unoise_gamma INT, --unoise-gamma INT
                        UNOISE read-correction gamma parameter (γ). Variants
                        below this total abundance are discarded before
                        denoising. Default 4 for UNOISE-L, tool defaults for
                        USEARCH and VSEARCH.
  -t TOTAL, --total TOTAL
                        Minimum total abundance for each output sequence.
                        Default 0 (not used).
  --minlen LENGTH       Minimum length sequence to accept (default 100).
  --maxlen LENGTH       Maximum length sequence to accept (default 1000).
  --temp DIRNAME        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  --cpu CPU             Number of parallel threads to use in called tools. Use
                        zero for all available. Default 1.
  -v, --verbose         Verbose logging.

This is a simplified version of the sample-tally command. Input FASTA files
should use `<prefix>_<count>` naming. In the output FASTA file each unique
sequence will be named `<prefix>_<count>` using the first seen name for each
sequence in the input files, and its total abundance including contributions
from any reads corrected to that sequences.
```

## thapbi-pict_sample-tally

### Tool Description
Prepare ASV x sample TSV sequence file using MD5 naming.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict sample-tally [-h] [-k MARKER] -i INPUT [INPUT ...]
                                [--ignore-prefixes STEM [STEM ...]]
                                [-y FASTA [FASTA ...]] [-n FASTA [FASTA ...]]
                                [-o FILENAME] [--fasta FILENAME] [-b FILENAME]
                                [-d DATABASE] [--synthetic GENUS] [-a INTEGER]
                                [-f FLOAT] [-t TOTAL] [--minlen LENGTH]
                                [--maxlen LENGTH]
                                [--denoise {-,unoise-l,usearch,vsearch}]
                                [-α FLOAT] [-γ INT] [--temp DIRNAME]
                                [--cpu CPU] [-v]

Prepare ASV x sample TSV sequence file using MD5 naming.

options:
  -h, --help            show this help message and exit
  -k MARKER, --marker MARKER
                        Which amplicon marker to process. Required if the DB
                        has more than one defined.
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        One or more per-sample FASTA files.
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -y FASTA [FASTA ...], --synctrls FASTA [FASTA ...]
                        One or more synthetic control FASTA filenames (which
                        must also appear in inputs or they will be ignored).
                        High non-synthetic marker levels will increase the
                        fractional abundance threshold of other FASTA files
                        from the same threshold pool (set in FASTA header
                        metadata). Can use '-' for none.
  -n FASTA [FASTA ...], --negctrls FASTA [FASTA ...]
                        One or more synthetic control FASTA filenames (which
                        must also appear in the inputs or they will be
                        ignored). High non-synthetic marker levels will
                        increase the absolute abundance threshold of other
                        FASTA files from the same threshold pool (set in FASTA
                        header metadata). Can use '-' for none.
  -o FILENAME, --output FILENAME
                        Single output filename, '-' for stdout (default). The
                        pipeline will use the .tally.tsv extension which is
                        assumed for the summary and edit-graph commands.
  --fasta FILENAME      Optional output FASTA filename, '-' for stdout.
  -b FILENAME, --biom FILENAME
                        Optional BIOM format output.
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
  --synthetic GENUS     Comma separated case insensitive genus list of any
                        spike-in sequences in the database which should be
                        expected in the negative controls. Default
                        'synthetic', use '' if none.
  -a INTEGER, --abundance INTEGER
                        Minimum abundance applied to unique marker sequences
                        in each sample (i.e. each FASTQ pair). Default 100.
                        May be increased based on negative controls. Half this
                        value is applied to synthetic controls.
  -f FLOAT, --abundance-fraction FLOAT
                        Minimum abundance fraction, low frequency noise
                        threshold applied to unique marker sequences in each
                        sample. Default 0.001 meaning 0.1%. May be increased
                        based on synthetic controls. Half this value is
                        applied to negative controls.
  -t TOTAL, --total TOTAL
                        Minimum total abundance for sequences. Applied after
                        per-sample thresholds. Default 0 (not used).
  --minlen LENGTH       Minimum length sequence to accept (default 100).
  --maxlen LENGTH       Maximum length sequence to accept (default 1000).
  --denoise {-,unoise-l,usearch,vsearch}
                        Optional read-correction algorithm, default '-' for
                        none. Use 'unoise-l' for built-in reimplementation of
                        the Levenshtein distance UNOISE algorithm as described
                        in Edgar (2016). Use 'usearch' to call external tool
                        `usearch -unoise3 ...` and the original author's
                        UNOISE3 implementation. Use 'vsearch' to call external
                        tool `vsearch --cluster_unoise ...` and their UNOISE3
                        reimplementation using pairwise alignment based
                        distance.
  -α FLOAT, --unoise_alpha FLOAT, --unoise-alpha FLOAT
                        UNOISE read-correction alpha parameter (α), used in
                        skew threshold function beta (β). Default 2.0 for
                        UNOISE-L, tool defaults for USEARCH and VSEARCH.
  -γ INT, --unoise_gamma INT, --unoise-gamma INT
                        UNOISE read-correction gamma parameter (γ). Variants
                        below this total abundance are discarded before
                        denoising. Default 4 for UNOISE-L, tool defaults for
                        USEARCH and VSEARCH.
  --temp DIRNAME        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  --cpu CPU             Number of parallel threads to use in called tools. Use
                        zero for all available. Default 1.
  -v, --verbose         Verbose logging.

Each unique sequence will be named `<Marker>/<MD5>_<count>` using the upper
case sequence MD5 checksum, and its total abundance. Per-sample input FASTA
files should use `<prefix>_<count>` naming. Output is a plain text tab-
separated table with one line per unique sequence (ASV), named in the first
column, then one column per sample, and the uppercase sequence as the final
column. The ASV vs sample values are the counts from the input FASTA files
(pooling any read-corrected sequences if using denoising).
```

## thapbi-pict_classify

### Tool Description
Classify FASTA file of marker sequences by species.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict classify [-h] -i INPUT [INPUT ...]
                            [--ignore-prefixes STEM [STEM ...]] [-a ABUNDANCE]
                            [-d DATABASE] [-k MARKER]
                            [-m {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}]
                            [-o DIRNAME] [-b] [-t DIRNAME] [-v] [--cpu CPU]

Classify FASTA file of marker sequences by species.

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        One or more prepared FASTA or sample tally TSV
                        filenames, or folder names (containing files named
                        `*.fasta` or `*.tsv`).
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -a ABUNDANCE, --abundance ABUNDANCE
                        Minimum abundance applied to unique marker sequences
                        in each FASTA sample file, default 0 (classify all).
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
  -k MARKER, --marker MARKER
                        If DB has multiple amplicon markers, which one should
                        be used?
  -m {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}, --method {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}
                        Classify method to run, default is 'onebp'.
  -o DIRNAME, --output DIRNAME
                        Directory for output reports. Default '' means next to
                        each input file. Use '-' for stdout.
  -b, --biom            Enable optional BIOM output.
  -t DIRNAME, --temp DIRNAME
                        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  -v, --verbose         Verbose logging.
  --cpu CPU             Number of parallel threads to use in called tools. Use
                        zero for all available. Default 1.

Each input file `XXX.fasta` will result in an output file named
`XXX.method.tsv` in the specified output directory (default input dir).
```

## thapbi-pict_assess

### Tool Description
Assess accuracy of marker sequence classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict assess [-h] -i INPUT [INPUT ...]
                          [--ignore-prefixes STEM [STEM ...]] [--known KNOWN]
                          [-d DATABASE] [--marker MARKER]
                          [-m {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}]
                          [-a ABUNDANCE] [-o FILENAME] [-t FILENAME]
                          [-c FILENAME] [-v]

Assess accuracy of marker sequence classification.

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        TSV filenames or folders named `*.<method>.tsv`, and
                        `*.<known>.tsv` where the filename suffixes can be set
                        via the -m / --method and --known arguments.
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  --known KNOWN         Replaces the string used in filenames for the truth
                        against which the method in -m / --method is assessed.
                        This could be any defined method, default is 'known'.
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
                        Used for species list to infer true negatives.
  --marker MARKER       Which amplicon marker from the DB wanted? Default all.
                        Use if assessing a single marker to avoid extra false
                        negatives.
  -m {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}, --method {1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr}
                        Classify method (to infer filenames), default 'onebp'.
  -a ABUNDANCE, --abundance ABUNDANCE
                        Minimum abundance to require before considering a
                        classification. Default is one meaning look at
                        everything, but rather than re-running the classifier
                        with a stricter minimum abundance you can apply it
                        here.
  -o FILENAME, --output FILENAME
                        File to write species level classification assessment
                        table to. Default is '-' meaning to stdout.
  -t FILENAME, --table FILENAME
                        File to write expected-to-predicted mapping tally
                        table to. Can use '-' meaning to stdout. Default is
                        not to write this file.
  -c FILENAME, --confusion FILENAME
                        File to write species level confusion matrix to. Can
                        use '-' meaning to stdout. Default is not to write
                        this file.
  -v, --verbose         Verbose logging.

Takes input sample-tally classification files `*.<method>.tsv`, to be assessed
against sample-tally classification files `*.<known>.tsv` or legacy per-sample
expected classification files `<sample>.known.tsv`. Produces a multi-species
confusion matrix (output on request) and classifier performance metrics (to
stdout by default). Assessment is at sample level (taking the union of species
predicted by all sequences from each sample).
```

## thapbi-pict_summary

### Tool Description
Sample and sequence summary reports on classifier output.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict summary [-h] -i INPUT [INPUT ...]
                           [--ignore-prefixes STEM [STEM ...]] -o STEM
                           [-m METHOD] [-a ABUNDANCE] [-t METADATAFILE]
                           [-e ENCODING] [-c COLUMNS] [-x COLUMNS] [-g COL]
                           [--metafields ROW] [-q] [-u] [-b] [-v]

Sample and sequence summary reports on classifier output.

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        Sample tally file `*.tally.tsv` and matching
                        classifier output file `*.method.tsv`, or folder
                        name(s). The classifier method extension can be set
                        via -m / --method.
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -o STEM, --output STEM
                        Output filename stem for generating reports. Not a
                        directory.
  -m METHOD, --method METHOD
                        Classifier method(s) to report, comma separated list
                        (used to infer filenames), default is 'onebp' (only).
  -a ABUNDANCE, --abundance ABUNDANCE
                        Minimum sample level abundance to require for the
                        report. Default 100 reflects default in prepare-reads.
                        Rather than re-running the prepare or classifier steps
                        with a stricter minimum abundance you can apply it
                        here. Use zero or one to look at everything in your
                        input files.
  -t METADATAFILE, --metadata METADATAFILE
                        Optional tab separated table containing metadata
                        indexed by sample name. Must also specify the columns
                        with -c / --metacols.
  -e ENCODING, --metaencoding ENCODING
                        Optional encoding of the metadata table, e.g. 'UTF-8',
                        'latin1', or if exporting from Microsoft Excel on
                        macOS use 'macintosh'.
  -c COLUMNS, --metacols COLUMNS
                        Comma separated list (e.g, '1,3,5') of columns from
                        the metadata table specified with the -m / --metadata
                        argument to be included in the report header, and use
                        to sort the samples. Use in conjunction with -m /
                        --metadata argument.
  -x COLUMNS, --metaindex COLUMNS
                        If using metadata, which column contains the sequenced
                        sample names. Default 1. Field can contain multiple
                        comma separated names catering to the fact that a
                        field sample could be sequenced multiple times with
                        technical replicates.
  -g COL, --metagroups COL
                        If using metadata, which column values should be used
                        for applying background color bands. All samples with
                        the same metadata value must be grouped together after
                        sorting, as the colors are reused. Zero (default) is
                        interpreted as the first column requested as metadata
                        output (the primary sorting key, ensuring all members
                        of the same group will be together).
  --metafields ROW      If using metadata, which row should be used as the
                        field names? Default 1, use 0 for no labels. Use in
                        conjunction with -m / --metadata argument.
  -q, --requiremeta     Ignore any input files without metadata for report.
  -u, --unsequenced     Show unsequenced metadata entries in sample report.
  -b, --biom            Enable optional BIOM output.
  -v, --verbose         Verbose logging.

Assumes you've run prepare-reads, sample-tally and classify giving
`XXX.tally.tsv` (with sequences counts per sample), and classifier output
`XXX.method.tsv` (for the same sequences). The output is two sets of tables.
The read tables have one row per unique sequence (can be thousands of rows)
and one column per sample (often hundreds, typically 96 samples per plate).
The sample tables have one row per sample, and one column per genus and
species.
```

## thapbi-pict_edit-graph

### Tool Description
Draw network graph of marker sequences using edit distance.

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict edit-graph [-h] [-d DATABASE] [-i FILENAME]
                              [--ignore-prefixes STEM [STEM ...]]
                              [-a ABUNDANCE] [-t TOTAL]
                              [--min-samples MIN_SAMPLES] [-k MARKER]
                              [-e {1,2,3}] [-o FILENAME]
                              [-f {graphml,gexf,gml,xgmml,pdf,matrix}] [-v]

Draw network graph of marker sequences using edit distance.

options:
  -h, --help            show this help message and exit
  -d DATABASE, --database DATABASE
                        Marker database to use, default '-' for bundled DB.
                        Used for labels and colors. Use '' to mean no DB.
  -i FILENAME, --input FILENAME
                        Sample-tally TSV file `*.tally.tsv` or classifier
                        output `*.<method>.tsv`
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  -a ABUNDANCE, --abundance ABUNDANCE
                        Minimum sample level abundance for FASTA sequences.
                        Default 100 reflects default in prepare-reads.
  -t TOTAL, --total TOTAL
                        Minimum total abundance for FASTA sequences. Applied
                        after per-sample level minimum (-a / --abundance).
                        Offered as a way to simplify the final graph.
  --min-samples MIN_SAMPLES
                        Minimum number of samples a unique sequence must
                        appear in. Offered as a way to simplify the final
                        graph. Default 0.
  -k MARKER, --marker MARKER
                        Show only entries from this marker. Required if only
                        drawing DB entries.
  -e {1,2,3}, --editdist {1,2,3}
                        Maximum edit distance to draw. Default and maximum 3.
  -o FILENAME, --output FILENAME
                        Write graph here. Default is '-' meaning stdout.
  -f {graphml,gexf,gml,xgmml,pdf,matrix}, --format {graphml,gexf,gml,xgmml,pdf,matrix}
                        Format to write out (default 'xgmml' for Cytoscape).
  -v, --verbose         Verbose logging.

Takes a marker database and/or prepared sample-tally file as input. The output
is a network graph (in a choice of format) with unique sequences as nodes (in
the PDF labelled by the database taxonomy, colored by genus, size set by total
abundance in the FASTA files), and short edit distances as edges between
nodes. For Cytoscape we recommend generating XGMML output here, then start
Cytoscape, menu 'File', 'Import', 'Import from file', and then run a layout.
Both 'Perfuse Force Directed' and 'Edge-weighted Spring Embedded' work well.
```

## thapbi-pict_ena-submit

### Tool Description
Write paired FASTQ table for upload to ENA (and thus SRA).

### Metadata
- **Docker Image**: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/peterjc/thapbi-pict
- **Package**: https://anaconda.org/channels/bioconda/packages/thapbi-pict/overview
- **Validation**: PASS

### Original Help Text
```text
usage: thapbi_pict ena-submit [-h] -i FASTQ [FASTQ ...]
                              [--ignore-prefixes STEM [STEM ...]]
                              [--ignore-stems FILENAME] [-o FILENAME] --study
                              STUDY [-t METADATAFILE] [-e ENCODING]
                              [-c COLUMNS] [-x COLUMNS] [--metafields ROW]
                              [--library LIBRARY] [--instrument INSTRUMENT]
                              [--flat] [--temp DIRNAME] [-v]

Write paired FASTQ table for upload to ENA (and thus SRA).

options:
  -h, --help            show this help message and exit
  -i FASTQ [FASTQ ...], --input FASTQ [FASTQ ...]
                        One or more paired FASTQ filenames or folder names
                        (containing files named `*.fastq` or `*.fastq.gz`).
  --ignore-prefixes STEM [STEM ...]
                        One or more filename prefixes to ignore, default
                        Undetermined_ unknown_
  --ignore-stems FILENAME
                        Text file of FASTQ stems to ignore, one per line.
                        Useful if you have already upload some data to the
                        ENA.
  -o FILENAME, --output FILENAME
                        File to write to (default '-' meaning stdout)
  --study STUDY         Value for study field, your PRJEB or ERP number.
  -t METADATAFILE, --metadata METADATAFILE
                        Optional tab separated table containing metadata
                        indexed by sample name. Must also specify the columns
                        with -c / --metacols.
  -e ENCODING, --metaencoding ENCODING
                        Optional encoding of the metadata table, e.g. 'UTF-8',
                        'latin1', or if exporting from Microsoft Excel on
                        macOS use 'macintosh'.
  -c COLUMNS, --metacols COLUMNS
                        Comma separated list (e.g, '1,3,5') of columns from
                        the metadata table specified with the -m / --metadata
                        argument to be included in the report header, and use
                        to sort the samples. Use in conjunction with -m /
                        --metadata argument.
  -x COLUMNS, --metaindex COLUMNS
                        If using metadata, which column contains the sequenced
                        sample names. Default 1. Field can contain multiple
                        comma separated names catering to the fact that a
                        field sample could be sequenced multiple times with
                        technical replicates.
  --metafields ROW      If using metadata, which row should be used as the
                        field names? Default 1, use 0 for no labels. Use in
                        conjunction with -m / --metadata argument.
  --library LIBRARY     Value for library_name field, default is '-' meaning
                        take the FASTQ file's parent folder name, which is
                        intended to support configurations like using multiple
                        96-well plates.
  --instrument INSTRUMENT
                        Value for instrument_model field, default 'Illumina
                        MiSeq'.
  --flat                Output FASTQ filenames without their directory prefix.
                        Use this if you uploaded them to the root of the ENA
                        FTP site.
  --temp DIRNAME        Debug option. Specify an (ideally empty) directory to
                        use for temporary files, which will not be deleted.
  -v, --verbose         Verbose logging.

Facilitate interactive upload of paired FASTQ files to the ENA/SRA. First
upload the raw FASTQ files, and interactively define your samples. Then use
the output of this command to match the FASTQ files to the samples. If your
ENA sample names match your FASTQ prefixes, no metadata file is needed here.
However, you can provide a metadata table to map the FASTQ stem to your sample
aliases or ENA sample accessions. Here -x should be the FASTQ stem column, and
-c should be the sample name column.See https://ena-
docs.readthedocs.io/en/latest/submit/reads/interactive.html where this is
intended to produce the completed spreadsheet for you.
```

