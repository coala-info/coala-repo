# gottcha2 CWL Generation Report

## gottcha2_profile

### Tool Description
Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-independent and signature-based metagenomic taxonomic profiling tool that has significantly smaller FDR than other profiling tools. This program is a wrapper to map input reads to pre-computed signature databases using minimap2 and/or to profile mapped reads in SAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/poeli/gottcha2
- **Package**: https://anaconda.org/channels/bioconda/packages/gottcha2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gottcha2/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2026-02-14
- **GitHub**: https://github.com/poeli/gottcha2
- **Stars**: N/A
### Original Help Text
```text
usage: gottcha2.py [-h] (-i [FASTQ] [[FASTQ] ...] | -s [SAMFILE] | -v)
                   [-d [GOTTCHA2_db]] [-l [LEVEL]] [-ti [PATH]] [-np]
                   [-e TAXON[,TAXON2,...]] [-ef] [-eo] [-fm [STR]]
                   [-r [FIELD]] [-t <INT>] [-o [DIR]] [-p <STR>] [-xm <STR>]
                   [--m2options <STR>] [-mc <FLOAT>] [-mr <INT>] [-ml <INT>]
                   [-mz <FLOAT>] [-mf <FLOAT>] [-mg <INT>] [-mi <FLOAT>]
                   [-ss <FLOAT>[,<FLOAT>,<FLOAT>]] [-nc] [-A [FILE]]
                   [-rm {yes,no,auto}] [-er <FLOAT>] [-c] [--mpa] [--silent]
                   [--verbose] [--debug]

Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-
independent and signature-based metagenomic taxonomic profiling tool that has
significantly smaller FDR than other profiling tools. This program is a
wrapper to map input reads to pre-computed signature databases using minimap2
and/or to profile mapped reads in SAM format. (VERSION: 2.2.0)

options:
  -h, --help            show this help message and exit
  -i, --input [FASTQ] [[FASTQ] ...]
                        Input FASTQ/FASTA file(s). Use space to separate
                        multiple input files.
  -s, --sam [SAMFILE]   Specify the input SAM file. Use '-' for standard
                        input.
  -d, --database [GOTTCHA2_db]
                        The path and prefix of the GOTTCHA2 database.
  -l, --dbLevel [LEVEL]
                        Specify the taxonomic level of the input database. You
                        can choose one rank from "superkingdom", "phylum",
                        "class", "order", "family", "genus", "species" and
                        "strain". The value will be auto-detected if the input
                        database ended with levels (e.g. GOTTCHA_db.species).
  -ti, --taxInfo [PATH]
                        Specify the path to the taxonomy information directory
                        or file. The program will attempt to locate a matching
                        .tax.tsv file for the specified database. If it cannot
                        find one, it will use the ‘taxonomy_db’ directory
                        located in the same directory as the executable by
                        default.
  -np, --nanopore       Indicate that the input reads are from Oxford Nanopore
                        sequencing platform. This option enables read
                        splitting and error rate set to 0.03 if not specified.
  -e, --extract TAXON[,TAXON2,...]
                        Extract mapped reads for specific taxa to a FASTA or
                        FASTQ file. You can specify taxa in one of the
                        following ways: - Comma-separated list of taxon IDs:
                        e.g., -e '1234,5678' - File containing a list of taxon
                        IDs (one per line): e.g., -e '@taxids.txt' - File with
                        read limits and format: e.g., -e
                        '@taxids.txt:1000:fasta' This limits the number of
                        reads extracted per taxon to <NUMBER> and outputs in
                        <FORMAT> (fasta or fastq). Use 'all' to extract all
                        matching taxa/reads. [default: None]
  -ef, --extractFullRef
                        Extract up to 20 sequences per reference from the SAM
                        file and save them to a FASTA file. Equivalent to
                        using: -e 'all:20:fasta'.
  -eo, --extractOnly    While --extract is specified, this option will only
                        extract the reads and not perform any further
                        processing of the SAM file.
  -fm, --format [STR]   Format of the results; available options include tsv,
                        csv or biom. [default: tsv]
  -r, --relAbu [FIELD]  The field will be used to calculate relative
                        abundance. You can specify one of the following
                        fields: "DEPTH", "READ_COUNT", "GENOMIC_CONTENT_EST".
                        [default: DEPTH]
  -t, --threads <INT>   Number of threads [default: 1]
  -o, --outdir [DIR]    Output directory [default: .]
  -p, --prefix <STR>    Prefix of the output file [default:
                        <INPUT_FILE_PREFIX>]
  -xm, --presetx <STR>  The preset option (-x) for minimap2. Default value
                        'sr' for short reads. [default: sr]
  --m2options <STR>     The minimap2 mapping options for short reads. Do not
                        use this option unless you know what you are doing.
                        [default: 'auto']
  -mc, --minCov <FLOAT>
                        Minimum signature coverage to be considered valid in
                        abundance calculation. [default: 0]
  -mr, --minReads <INT>
                        Minimum number of reads to be considered valid in
                        abundance calculation. [default: 0]
  -ml, --minLen <INT>   Minimum signature length to be considered valid in
                        abundance calculation. [default: 0]
  -mz, --maxZscore <FLOAT>
                        Maximum estimated z-score for the depths of the mapped
                        region. Set to 0 to disable. [default: 0]
  -mf, --matchFraction <FLOAT>
                        Minimum fraction (0.0-1.0) of the read or signature
                        fragment required to be considered a valid match.
                        [default: 0]
  -mg, --matchLength <INT>
                        Minimum length of the alignment required to be
                        considered a valid match. [default: 0]
  -mi, --matchIdentity <FLOAT>
                        Minimum identity (0.0-1.0) required for a valid match.
                        [default: 0]
  -ss, --sniScore <FLOAT>[,<FLOAT>,<FLOAT>]
                        Signature nucleotide identity (SNI) score thresholds
                        for taxonomic aggregation: other levels (first),
                        species level (first value), and strain level (second
                        value); if only one value is provided, all three
                        levels use that value. [default: 0.9,0.95,0.99]
  -nc, --noCutoff       Remove all cutoffs. This option is equivalent to use
                        [-mc 0 -mr 0 -ml 0 -mf 0 -mz 0 -ss 0,0,0]
  -A, --accExclusionList [FILE]
                        List of excluded accessions from the database (e.g.
                        plasmid accessions).
  -rm, --removeMultipleHits {yes,no,auto}
                        The multiple hit removal step is automatically enabled
                        for sequence input files and disabled for SAM files.
                        Users can explicitly control this behavior by
                        specifying 'yes' or 'no' to force the step to be
                        enabled or disabled. [default: auto]
  -er, --errorRate <FLOAT>
                        Estimated error rate for sequencing data. [default:
                        0.005]
  -c, --stdout          Write on standard output.
  --mpa                 Generate output in MetaPhlAn format.
  -v, --version         Print version number.
  --silent              Disable all messages.
  --verbose             Provide verbose messages.
  --debug               Debug mode. Provide verbose running messages and keep
                        all temporary files.
```


## gottcha2_extract

### Tool Description
Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-independent and signature-based metagenomic taxonomic profiling tool that has significantly smaller FDR than other profiling tools. This program is a wrapper to map input reads to pre-computed signature databases using minimap2 and/or to profile mapped reads in SAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/poeli/gottcha2
- **Package**: https://anaconda.org/channels/bioconda/packages/gottcha2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gottcha2.py [-h] (-i [FASTQ] [[FASTQ] ...] | -s [SAMFILE] | -v)
                   [-d [GOTTCHA2_db]] [-l [LEVEL]] [-ti [PATH]] [-np]
                   [-e TAXON[,TAXON2,...]] [-ef] [-eo] [-fm [STR]]
                   [-r [FIELD]] [-t <INT>] [-o [DIR]] [-p <STR>] [-xm <STR>]
                   [--m2options <STR>] [-mc <FLOAT>] [-mr <INT>] [-ml <INT>]
                   [-mz <FLOAT>] [-mf <FLOAT>] [-mg <INT>] [-mi <FLOAT>]
                   [-ss <FLOAT>[,<FLOAT>,<FLOAT>]] [-nc] [-A [FILE]]
                   [-rm {yes,no,auto}] [-er <FLOAT>] [-c] [--mpa] [--silent]
                   [--verbose] [--debug]

Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-
independent and signature-based metagenomic taxonomic profiling tool that has
significantly smaller FDR than other profiling tools. This program is a
wrapper to map input reads to pre-computed signature databases using minimap2
and/or to profile mapped reads in SAM format. (VERSION: 2.2.0)

options:
  -h, --help            show this help message and exit
  -i, --input [FASTQ] [[FASTQ] ...]
                        Input FASTQ/FASTA file(s). Use space to separate
                        multiple input files.
  -s, --sam [SAMFILE]   Specify the input SAM file. Use '-' for standard
                        input.
  -d, --database [GOTTCHA2_db]
                        The path and prefix of the GOTTCHA2 database.
  -l, --dbLevel [LEVEL]
                        Specify the taxonomic level of the input database. You
                        can choose one rank from "superkingdom", "phylum",
                        "class", "order", "family", "genus", "species" and
                        "strain". The value will be auto-detected if the input
                        database ended with levels (e.g. GOTTCHA_db.species).
  -ti, --taxInfo [PATH]
                        Specify the path to the taxonomy information directory
                        or file. The program will attempt to locate a matching
                        .tax.tsv file for the specified database. If it cannot
                        find one, it will use the ‘taxonomy_db’ directory
                        located in the same directory as the executable by
                        default.
  -np, --nanopore       Indicate that the input reads are from Oxford Nanopore
                        sequencing platform. This option enables read
                        splitting and error rate set to 0.03 if not specified.
  -e, --extract TAXON[,TAXON2,...]
                        Extract mapped reads for specific taxa to a FASTA or
                        FASTQ file. You can specify taxa in one of the
                        following ways: - Comma-separated list of taxon IDs:
                        e.g., -e '1234,5678' - File containing a list of taxon
                        IDs (one per line): e.g., -e '@taxids.txt' - File with
                        read limits and format: e.g., -e
                        '@taxids.txt:1000:fasta' This limits the number of
                        reads extracted per taxon to <NUMBER> and outputs in
                        <FORMAT> (fasta or fastq). Use 'all' to extract all
                        matching taxa/reads. [default: None]
  -ef, --extractFullRef
                        Extract up to 20 sequences per reference from the SAM
                        file and save them to a FASTA file. Equivalent to
                        using: -e 'all:20:fasta'.
  -eo, --extractOnly    While --extract is specified, this option will only
                        extract the reads and not perform any further
                        processing of the SAM file.
  -fm, --format [STR]   Format of the results; available options include tsv,
                        csv or biom. [default: tsv]
  -r, --relAbu [FIELD]  The field will be used to calculate relative
                        abundance. You can specify one of the following
                        fields: "DEPTH", "READ_COUNT", "GENOMIC_CONTENT_EST".
                        [default: DEPTH]
  -t, --threads <INT>   Number of threads [default: 1]
  -o, --outdir [DIR]    Output directory [default: .]
  -p, --prefix <STR>    Prefix of the output file [default:
                        <INPUT_FILE_PREFIX>]
  -xm, --presetx <STR>  The preset option (-x) for minimap2. Default value
                        'sr' for short reads. [default: sr]
  --m2options <STR>     The minimap2 mapping options for short reads. Do not
                        use this option unless you know what you are doing.
                        [default: 'auto']
  -mc, --minCov <FLOAT>
                        Minimum signature coverage to be considered valid in
                        abundance calculation. [default: 0]
  -mr, --minReads <INT>
                        Minimum number of reads to be considered valid in
                        abundance calculation. [default: 0]
  -ml, --minLen <INT>   Minimum signature length to be considered valid in
                        abundance calculation. [default: 0]
  -mz, --maxZscore <FLOAT>
                        Maximum estimated z-score for the depths of the mapped
                        region. Set to 0 to disable. [default: 0]
  -mf, --matchFraction <FLOAT>
                        Minimum fraction (0.0-1.0) of the read or signature
                        fragment required to be considered a valid match.
                        [default: 0]
  -mg, --matchLength <INT>
                        Minimum length of the alignment required to be
                        considered a valid match. [default: 0]
  -mi, --matchIdentity <FLOAT>
                        Minimum identity (0.0-1.0) required for a valid match.
                        [default: 0]
  -ss, --sniScore <FLOAT>[,<FLOAT>,<FLOAT>]
                        Signature nucleotide identity (SNI) score thresholds
                        for taxonomic aggregation: other levels (first),
                        species level (first value), and strain level (second
                        value); if only one value is provided, all three
                        levels use that value. [default: 0.9,0.95,0.99]
  -nc, --noCutoff       Remove all cutoffs. This option is equivalent to use
                        [-mc 0 -mr 0 -ml 0 -mf 0 -mz 0 -ss 0,0,0]
  -A, --accExclusionList [FILE]
                        List of excluded accessions from the database (e.g.
                        plasmid accessions).
  -rm, --removeMultipleHits {yes,no,auto}
                        The multiple hit removal step is automatically enabled
                        for sequence input files and disabled for SAM files.
                        Users can explicitly control this behavior by
                        specifying 'yes' or 'no' to force the step to be
                        enabled or disabled. [default: auto]
  -er, --errorRate <FLOAT>
                        Estimated error rate for sequencing data. [default:
                        0.005]
  -c, --stdout          Write on standard output.
  --mpa                 Generate output in MetaPhlAn format.
  -v, --version         Print version number.
  --silent              Disable all messages.
  --verbose             Provide verbose messages.
  --debug               Debug mode. Provide verbose running messages and keep
                        all temporary files.
```


## gottcha2_gottcha2

### Tool Description
GOTTCHA2 - Genomic Origin Through Taxonomic CHAllenge v2.2.0

### Metadata
- **Docker Image**: quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/poeli/gottcha2
- **Package**: https://anaconda.org/channels/bioconda/packages/gottcha2/overview
- **Validation**: PASS

### Original Help Text
```text
Error: 'gottcha2' is not a valid command

GOTTCHA2 - Genomic Origin Through Taxonomic CHAllenge v2.2.0

Usage:
    gottcha2 <command> [options]

Commands:
    profile    Taxonomic profiling of metagenomic reads
              (Map reads to signature database and classify)

    extract    Extract reads of a specific taxon from profiled results

    version    Display version information
    
Examples:
    gottcha2 profile -i reads.fastq -d database/db_prefix

    gottcha2 extract -s prefix.sam -d database/db_prefix -e 666

For detailed help on a specific command:
    gottcha2 <command> --help
```


## Metadata
- **Skill**: generated
