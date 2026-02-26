# gefast CWL Generation Report

## gefast_GeFaST

### Tool Description
Cluster amplicons based on sequence similarity and quality scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/gefast:2.0.1--h4ac6f70_3
- **Homepage**: https://github.com/romueller/gefast
- **Package**: https://anaconda.org/channels/bioconda/packages/gefast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gefast/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/romueller/gefast
- **Stars**: N/A
### Original Help Text
```text
##### GeFaST (2.0.1) #####
Copyright (C) 2016 - 2021 Robert Mueller
https://github.com/romueller/gefast

Usage: GeFaST <mode> <input> <config> [option]...

The first three arguments are mandatory and fixed in their order:
 <mode>     The abbreviation of the mode. 
 <input>    By default, GeFaST expects a comma-separated list of file paths as its second argument.
            This behaviour can be changed with the --list_file option (see input / output options below).
 <config>   The file path of the configuration file containing the (basic) configuration for this execution of GeFaST.
These arguments are followed by an arbitrary list of options described below.

Modes:
 lev     Cluster amplicons based on the number of edit operations in optimal pairwise alignments.
 as      Cluster amplicons based on the score of optimal pairwise alignments.
 qlev    Cluster amplicons based on the number of edit operations in optimal pairwise alignments considering the quality scores associated with the sequences.
 qas     Cluster amplicons based on the score of optimal pairwise alignments considering the quality scores associated with the sequences
 cons    Cluster amplicons using a notion of consistency considering the quality and abundance of amplicons.
 derep   Group amplicons based on exact sequence equality

Configuration file:
The configuration file is a (possibly empty) plain-text file containing key-value pairs.
Each configuration parameter is written in its own line and has the form <key>=<value>.
Empty lines and comment lines (starting with #) are allowed.
When an option is specified in the configuration file and on the command line, the value provided on the command line is used.

Input / output options:
 -a, --alphabet STRING                 discard sequences with other characters (default: ACGT)
 -i, --output_internal STRING          output links underlying the cluster to file (default: not created)
 -o, --output_otus STRING              output clusters to file (default: not created)
 -s, --output_statistics STRING        output statistics to file (defaut: not created)
 -w, --output_seeds STRING             output seeds to file (default: not created)
 -u, --output_uclust STRING            create UCLUST-like output file (default: not created)
 --sep_abundance STRING                change separator symbol between identifier and abundance (default: _)
 --min_length INTEGER                  discard shorter sequences (default: deactivated)
 --max_length INTEGER                  discard longer sequences (default: deactivated)
 --min_abundance INTEGER               discard less abundant sequences (default: deactivated)
 --max_abundance INTEGER               discard more abundant sequences (default: deactivated)
 --mothur                              output clusters in mothur list file format
 --quality_encoding STRING             change expected quality encoding (FASTQ inputs, default: sanger)
 --list_file STRING                    consider <input> option as path to file containing list of actual input files (one path per line)

Clustering / refinement options:
 -t, --threshold NUMERIC               distance threshold in clustering phase (default: mode-dependent)
 -r, --refinement_threshold NUMERIC    distance threshold in refinement phase (default: 0, i.e. no refinement)
 -b, --boundary INTEGER                mass boundary distinguishing between light and heavy clusters during refinement (default: 3)
 -n, --break_swarms BINARY             do not extend cluster when the new amplicon has a larger abundance than the current subseed (default: 1)
 -m, --match_reward INTEGER            reward for nucleotide match during pairwise global alignment computation (default: 5)
 -p, --mismatch_penalty INTEGER        penalty for nucleotide mismatch during pairwise global alignment computation (default: -4)
 -g, --gap_opening_penalty INTEGER     penalty for opening a gap during pairwise global alignment computation (default: -12)
 -e, --gap_extension_penalty INTEGER   penalty for extending a gap during pairwise global alignment computation (default: -4)

Component options:
 --preprocessor STRING                 use the specified component to perform the preprocessing (default: mode-dependent)
 --clusterer STRING                    use the specified component to cluster the amplicons (default: mode-dependent)
 --refiner STRING                      use the specified component to refine the clusters (default: mode-dependent)
 --output_generator STRING             use the specified component to generate the requested outputs (default: mode-dependent)

See the manual for more details and mode-specific options.
```

