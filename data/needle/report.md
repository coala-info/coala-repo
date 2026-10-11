# needle CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| needle_count | PASS | repo test reads (32 GeneA reads) and gene.fasta: counts 32 and 1 match the read numbers |
| needle_estimate | PASS | GeneA expression levels 2 and 1 from the ibf and ibfmin indexes, matching 32 and 1 reads |
| needle_ibf | PASS | index from the two repo test files; estimate gives GeneA levels 2 and 1 as expected from 32 and 1 reads |
| needle_ibfmin | PASS | index built from minimiser files gives the same estimate (GeneA 2 and 1) as the ibf index |
| needle_minimiser | PASS | repo test reads give minimiser files; ibfmin and estimate can use them |

## needle_count

### Tool Description
Get expression value depending on minimizers. This function is only used to test the validity of Needle's estimation approach. It estimates the expression value for all sequences in the genome file based on the exact minimiser occurrences of the given sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
needle-count - Get expression value depending on minimizers. This function is only used to test the validity of Needle's estimation approach. It estimates the expression value for all sequences in the genome file based on the exact minimiser occurrences of the given sequence files.
==========================================================================================================================================================================================================================================================================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (List of std::filesystem::path)
          Please provide at least one sequence file. Default: [].

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -k, --kmer (unsigned 8 bit integer)
          Define k-mer size for the minimisers. Default: 20. Default: 20.
    -w, --window (unsigned 32 bit integer)
          Define window size for the minimisers. Default: 60. Default: 0.
    --shape (unsigned 64 bit integer)
          Define a shape for the minimisers by the decimal of a bitvector,
          where 0 symbolizes a position to be ignored, 1 a position
          considered. Default: ungapped. Default: 0.
    --seed (unsigned 64 bit integer)
          Define seed for the minimisers. Default: 0.
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default: "./".
    -t, --threads (unsigned 8 bit integer)
          Number of threads to use. Default: 1. Default: 1.
    -g, --genome (std::filesystem::path)
          Please provide one sequence file with transcripts. Default: "".
    --exclude (std::filesystem::path)
          Please provide one sequence file with minimizers to ignore. Default:
          "".
    -p, --paired
          If set, experiments are paired. Default: Not paired.

VERSION
    Last update:
    needle-count version:
    SeqAn version: 3.0.3
```

## needle_estimate

### Tool Description
Estimate expression value of transcript based on the Needle index.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
#######################################################################
   Automatic Update Notifications
#######################################################################
 This app performs automatic checks for updates. For more information
 see: https://github.com/seqan/seqan3/wiki/Update-Notifications
#######################################################################

needle-estimate - Estimate expression value of transcript based on the Needle index.
====================================================================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (std::filesystem::path)
          Please provide a sequence file.

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -i, --in (std::filesystem::path)
          Directory where input files can be found. Default: "./".
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default:
          "expressions.out".
    -m, --normalization-mode
          Set, if normalization is wanted. Normalization is achieved
          bydividing the expression value with the expression threshold of the
          first ibf. Only make sense if every bin has its own expression
          thresholds (which is the case if expression thresholds were
          generated automatically).Default: False.

VERSION
    Last update:
    needle-estimate version: 1.0.0
    SeqAn version: 3.0.3

LEGAL
    Author: Mitra Darvish
    SeqAn Copyright: 2006-2021 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
```

## needle_ibf

### Tool Description
Constructs the Needle index.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
#######################################################################
   Automatic Update Notifications
#######################################################################
 This app performs automatic checks for updates. For more information
 see: https://github.com/seqan/seqan3/wiki/Update-Notifications
#######################################################################

needle-ibf - Constructs the Needle index.
=========================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (List of std::filesystem::path)
          Please provide at least one sequence file. Default: [].

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -k, --kmer (unsigned 8 bit integer)
          Define k-mer size for the minimisers. Default: 20. Default: 20.
    -w, --window (unsigned 32 bit integer)
          Define window size for the minimisers. Default: 60. Default: 0.
    --shape (unsigned 64 bit integer)
          Define a shape for the minimisers by the decimal of a bitvector,
          where 0 symbolizes a position to be ignored, 1 a position
          considered. Default: ungapped. Default: 0.
    --seed (unsigned 64 bit integer)
          Define seed for the minimisers. Default: 0.
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default: "./".
    -t, --threads (unsigned 8 bit integer)
          Number of threads to use. Default: 1. Default: 1.
    -c, --compressed
          If c is set, the IBFS are compressed. Default: Not compressed.
    -f, --fpr (List of double)
          List of bin false positive rate per expression level. If only one is
          given, then that fpr is used for all expression levels. Default: [].
    -e, --expression_thresholds (List of unsigned 16 bit integer)
          Which expression thresholds should be used for constructing the
          IBFs. Default: [].
    -l, --number_expression_thresholds (unsigned 8 bit integer)
          Number of expression thresholds. Can be set alternatively to
          expression_thresholds, then the expression thresholds are determined
          automatically. Default: 0.
    -n, --hash (unsigned 64 bit integer)
          Number of hash functions that should be used when constructing one
          IBF. Default: 1.
    --include (std::filesystem::path)
          Sequence file containing minimizers, only those minimizers will be
          considered. Default: "".
    --exclude (std::filesystem::path)
          Sequence file containing minimizers that should not be stored.
          Default: "".
    --samples (List of signed 32 bit integer)
          Define which samples belong together, sum has to be equal to number
          of sequence files. Default: Every sequence file is one sample from
          one experiment. Default: [].
    -p, --paired
          If set, experiments are paired. Default: Not paired.
    --cutoff (List of unsigned 8 bit integer)
          Define for each sample, what number of found minimisers should be
          considered the result of a sequencing error and therefore be
          ignored. Default: Every sample has anautomatically genereated
          cutoff, which is based on the file size. Default: [].
    --experiment-names (bool)
          If set, names of the experiments are stored in a txt file. Default:
          0.
    --levels-by-genome (std::filesystem::path)
          Sequence file containing minimizers, only those minimizers will be
          considered for determining the expression thresholds. Default: "".

VERSION
    Last update:
    needle-ibf version:
    SeqAn version: 3.0.3
```

## needle_ibfmin

### Tool Description
Constructs the Needle index from the minimiser files created by needle minimiser.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
#######################################################################
   Automatic Update Notifications
#######################################################################
 This app performs automatic checks for updates. For more information
 see: https://github.com/seqan/seqan3/wiki/Update-Notifications
#######################################################################

needle-ibfmin - Constructs the Needle index from the minimiser files created by needle minimiser.
=================================================================================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (List of std::filesystem::path)
          Please provide at least one minimiser file. It is assumed that the
          header file exits in the same directory. Default: [].

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default: "./".
    -t, --threads (unsigned 8 bit integer)
          Number of threads to use. Default: 1. Default: 1.
    --levels-by-genome (std::filesystem::path)
          Sequence file containing minimizers, only those minimizers will be
          considered for determining the expression thresholds. Default: "".
    -c, --compressed
          If c is set, the IBFS are compressed. Default: Not compressed.
    -f, --fpr (List of double)
          List of bin false positive rate per expression level. If only one is
          given, then that fpr is used for all expression levels. Default: [].
    -e, --expression_thresholds (List of unsigned 16 bit integer)
          Which expression thresholds should be used for constructing the
          IBFs. Default: [].
    -l, --number_expression_thresholds (unsigned 8 bit integer)
          Number of expression thresholds. Can be set alternatively to
          expression_thresholds, then the expression thresholds are determined
          automatically. Default: 0.
    -n, --hash (unsigned 64 bit integer)
          Number of hash functions that should be used when constructing one
          IBF. Default: 1.

VERSION
    Last update:
    needle-ibfmin version:
    SeqAn version: 3.0.3
```

## needle_minimiser

### Tool Description
Calculates minimiser for given experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
#######################################################################
   Automatic Update Notifications
#######################################################################
 This app performs automatic checks for updates. For more information
 see: https://github.com/seqan/seqan3/wiki/Update-Notifications
#######################################################################

needle-minimiser - Calculates minimiser for given experiments.
==============================================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (List of std::filesystem::path)
          Please provide at least one sequence file. Default: [].

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -k, --kmer (unsigned 8 bit integer)
          Define k-mer size for the minimisers. Default: 20. Default: 20.
    -w, --window (unsigned 32 bit integer)
          Define window size for the minimisers. Default: 60. Default: 0.
    --shape (unsigned 64 bit integer)
          Define a shape for the minimisers by the decimal of a bitvector,
          where 0 symbolizes a position to be ignored, 1 a position
          considered. Default: ungapped. Default: 0.
    --seed (unsigned 64 bit integer)
          Define seed for the minimisers. Default: 0.
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default: "./".
    -t, --threads (unsigned 8 bit integer)
          Number of threads to use. Default: 1. Default: 1.
    --include (std::filesystem::path)
          Sequence file containing minimizers, only those minimizers will be
          considered. Default: "".
    --exclude (std::filesystem::path)
          Sequence file containing minimizers that should not be stored.
          Default: "".
    --samples (List of signed 32 bit integer)
          Define which samples belong together, sum has to be equal to number
          of sequence files. Default: Every sequence file is one sample from
          one experiment. Default: [].
    -p, --paired
          If set, experiments are paired. Default: Not paired.
    --cutoff (List of unsigned 8 bit integer)
          Define for each sample, what number of found minimisers should be
          considered the result of a sequencing error and therefore be
          ignored. Default: Every sample has anautomatically genereated
          cutoff, which is based on the file size. Default: [].

VERSION
    Last update:
    needle-minimiser version:
    SeqAn version: 3.0.3
```

## Metadata
- **Skill**: generated
