# kpop CWL Generation Report

## kpop_KPopCount

### Tool Description
KPopCount version 14 (18-Mar-2024)

### Metadata
- **Docker Image**: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
- **Homepage**: https://github.com/PaoloRibeca/KPop
- **Package**: https://anaconda.org/channels/bioconda/packages/kpop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kpop/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PaoloRibeca/KPop
- **Stars**: N/A
### Original Help Text
```text
[38;5;7m╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗[0m
[38;5;7m┃                                              ┃[0m
[38;5;7m┃[0m  [1mThis is[0m [38;5;2mKPopCount[0m [1mversion[0m [38;5;2m14[0m [[38;5;4m18-Mar-2024[0m]  [38;5;7m┃[0m
[38;5;7m┃                                              ┃[0m
[38;5;7m╚┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝[0m
 [38;5;7m│[0m compiled against: [38;5;2mBiOCamLib[0m version [38;5;2m248[0m [[38;5;4m18-Mar-2024[0m];
                     [38;5;2mKPop[0m version [38;5;2m429[0m [[38;5;4m18-Mar-2024[0m]
 [38;5;7m│[0m (c) 2017-2024 [1mPaolo Ribeca[0m <[4mpaolo.ribeca@gmail.com[0m>
[38;5;1m Usage:[0m
  [1mKPopCount[0m [38;5;4m-l <output_vector_label>|-L [OPTIONS][0m
 [38;5;2mAlgorithmic parameters[0m
  [38;5;4m-k[0m[38;5;7m|[0m[38;5;4m-K[0m[38;5;7m|[0m[38;5;4m--k-mer-size[0m[38;5;7m|[0m[38;5;4m--k-mer-length[0m
    [1m<k_mer_length>[0m
   [38;5;7m│[0m k-mer length
   [38;5;7m│[0m (must be positive, and <= 30 for DNA or <= 12 for protein)
   [38;5;7m│[0m (default='[4m[1m12[0m[0m')
  [38;5;4m-M[0m[38;5;7m|[0m[38;5;4m--max-results-size[0m
    [1m<positive_integer>[0m
   [38;5;7m│[0m maximum number of k-mer hashes to be kept in memory at any given time.
   [38;5;7m│[0m If more are present, the ones corresponding to the lowest cardinality
   [38;5;7m│[0m will be removed from memory and printed out, and there will be
   [38;5;7m│[0m repeated hashes in the output
   [38;5;7m│[0m (default='[4m[1m16777216[0m[0m')
 [38;5;2mInput/Output[0m
  [38;5;4m-C[0m[38;5;7m|[0m[38;5;4m--content[0m
    [1m'DNA-ss'|'DNA-single-stranded'|'DNA-ds'|'DNA-double-stranded'|'protein'[0m
   [38;5;7m│[0m how file contents should be interpreted.
   [38;5;7m│[0m When content is 'DNA-ss' or 'protein', the sequence is hashed;
   [38;5;7m│[0m when content is 'DNA-ds', both sequence and reverse complement are hashed.
   [38;5;7m│[0m 'DNA-ss' prevents automatic matching of reverse-complemented sequences;
   [38;5;7m│[0m use it only when comparing a set of single, homogeneus sequences
   [38;5;7m│[0m (default='[4m[1mDNA-ds[0m[0m')
  [38;5;4m-f[0m[38;5;7m|[0m[38;5;4m--fasta[0m
    [1m<fasta_file_name>[0m
   [38;5;7m│[0m FASTA input file containing sequences.
   [38;5;7m│[0m You can specify more than one FASTA input, but not FASTA and FASTQ inputs
   [38;5;7m│[0m at the same time. Contents are expected to be homogeneous across inputs
  [38;5;4m-s[0m[38;5;7m|[0m[38;5;4m--single-end[0m
    [1m<fastq_file_name>[0m
   [38;5;7m│[0m FASTQ input file containing single-end sequencing reads
   [38;5;7m│[0m You can specify more than one FASTQ input, but not FASTQ and FASTA inputs
   [38;5;7m│[0m at the same time. Contents are expected to be homogeneous across inputs
  [38;5;4m-p[0m[38;5;7m|[0m[38;5;4m--paired-end[0m
    [1m<fastq_file_name1> <fastq_file_name2>[0m
   [38;5;7m│[0m FASTQ input files containing paired-end sequencing reads
   [38;5;7m│[0m You can specify more than one FASTQ input, but not FASTQ and FASTA inputs
   [38;5;7m│[0m at the same time. Contents are expected to be homogeneous across inputs
  [38;5;4m-l[0m[38;5;7m|[0m[38;5;4m--label[0m
    [1m<output_vector_label>[0m
   [38;5;7m│[0m label to be given to the k-mer spectrum in the output file.
   [38;5;7m│[0m It must not contain double quote '"' characters.
   [38;5;7m│[0m Either option '-l' or option '-L' is mandatory
  [38;5;4m-L[0m[38;5;7m|[0m[38;5;4m--one-spectrum-per-sequence[0m
   [38;5;7m│[0m output one spectrum per input sequence, using the sequence name as label.
   [38;5;7m│[0m Sequence names must not contain double quote '"' characters.
   [38;5;7m│[0m Either option '-l' or option '-L' is mandatory
  [38;5;4m-o[0m[38;5;7m|[0m[38;5;4m--output[0m
    [1m<output_file_name>[0m
   [38;5;7m│[0m name of generated output file
   [38;5;7m│[0m (default='[4m[1m<stdout>[0m[0m')
 [38;5;2mMiscellaneous[0m
  [38;5;4m-v[0m[38;5;7m|[0m[38;5;4m--verbose[0m
   [38;5;7m│[0m set verbose execution
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m-V[0m[38;5;7m|[0m[38;5;4m--version[0m
   [38;5;7m│[0m print version and exit
  [38;5;4m-h[0m[38;5;7m|[0m[38;5;4m--help[0m
   [38;5;7m│[0m print syntax and exit
(BiOCamLib__Tools.Argv.parse_error): [38;5;1mOne of options '-l' and '-L' is mandatory[0m
```


## kpop_KPopCountDB

### Tool Description
KPopCountDB version 41 (18-Mar-2024)

### Metadata
- **Docker Image**: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
- **Homepage**: https://github.com/PaoloRibeca/KPop
- **Package**: https://anaconda.org/channels/bioconda/packages/kpop/overview
- **Validation**: PASS

### Original Help Text
```text
[38;5;7m╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗[0m
[38;5;7m┃                                                ┃[0m
[38;5;7m┃[0m  [1mThis is[0m [38;5;2mKPopCountDB[0m [1mversion[0m [38;5;2m41[0m [[38;5;4m18-Mar-2024[0m]  [38;5;7m┃[0m
[38;5;7m┃                                                ┃[0m
[38;5;7m╚┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝[0m
 [38;5;7m│[0m compiled against: [38;5;2mBiOCamLib[0m version [38;5;2m248[0m [[38;5;4m18-Mar-2024[0m];
                     [38;5;2mKPop[0m version [38;5;2m429[0m [[38;5;4m18-Mar-2024[0m]
 [38;5;7m│[0m (c) 2020-2024 [1mPaolo Ribeca[0m <[4mpaolo.ribeca@gmail.com[0m>
[38;5;1m Usage:[0m
  [1mKPopCountDB[0m [38;5;4m[ACTIONS][0m
 [38;5;2mActions.[0m
 [38;5;7m│[0m [38;5;2mThey are executed delayed and in order of specification.[0m
 [38;5;7m│[0m [38;5;2mActions on the database register:[0m
  [38;5;4m-e[0m[38;5;7m|[0m[38;5;4m--empty[0m
   [38;5;7m│[0m put an empty database into the register
  [38;5;4m-i[0m[38;5;7m|[0m[38;5;4m--input[0m
    [1m<binary_file_prefix>[0m
   [38;5;7m│[0m load into the register the database present in the specified file
   [38;5;7m│[0m  (which must have extension .KPopCounter)
  [38;5;4m-m[0m[38;5;7m|[0m[38;5;4m--metadata[0m[38;5;7m|[0m[38;5;4m--add-metadata[0m
    [1m<metadata_table_file_name>[0m
   [38;5;7m│[0m add to the database present in the register metadata from the specified file.
   [38;5;7m│[0m Metadata field names and values must not contain double quote '"' characters
  [38;5;4m-k[0m[38;5;7m|[0m[38;5;4m--kmers[0m[38;5;7m|[0m[38;5;4m--add-kmers[0m[38;5;7m|[0m[38;5;4m--add-kmer-files[0m
    [1m<k-mer_table_file_name>[','...','<k-mer_table_file_name>][0m
   [38;5;7m│[0m add to the database present in the register k-mers from the specified files
  [38;5;4m--summary[0m
   [38;5;7m│[0m print a summary of the database present in the register
  [38;5;4m-o[0m[38;5;7m|[0m[38;5;4m--output[0m
    [1m<binary_file_prefix>[0m
   [38;5;7m│[0m dump the database present in the register to the specified file
   [38;5;7m│[0m  (which will be given extension .KPopCounter)
  [38;5;4m--distance[0m[38;5;7m|[0m[38;5;4m--distance-function[0m
    [1m'euclidean'|'minkowski(<non_negative_float>)'[0m
   [38;5;7m│[0m set the function to be used when computing distances.
   [38;5;7m│[0m The parameter for 'minkowski()' is the power
   [38;5;7m│[0m (default='[4m[1meuclidean[0m[0m')
  [38;5;4m--distance-normalize[0m[38;5;7m|[0m[38;5;4m--normalize-distances[0m[38;5;7m|[0m[38;5;4m--distance-normalization[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether spectra should be normalized prior to computing distances
  [38;5;4m-d[0m[38;5;7m|[0m[38;5;4m--distances[0m[38;5;7m|[0m[38;5;4m--compute-distances[0m[38;5;7m|[0m[38;5;4m--compute-spectral-distances[0m
    [1mREGEXP_SELECTOR REGEXP_SELECTOR <binary_file_prefix>[0m
   [38;5;7m│[0m where REGEXP_SELECTOR :=
   [38;5;7m│[0m  <metadata_field>'~'<regexp>[','...','<metadata_field>'~'<regexp>]
   [38;5;7m│[0m and regexps are defined according to <https://ocaml.org/api/Str.html>:
   [38;5;7m│[0m select two sets of spectra from the register
   [38;5;7m│[0m and compute and output distances between all possible pairs
   [38;5;7m│[0m  (metadata fields must match the regexps specified in the selector;
   [38;5;7m│[0m   an empty metadata field makes the regexp match labels.
   [38;5;7m│[0m   The result will have extension .KPopDMatrix)
  [38;5;4m--table-output-row-names[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to output row names for the database present in the register
   [38;5;7m│[0m when writing it as a tab-separated file
   [38;5;7m│[0m (default='[4m[1mtrue[0m[0m')
  [38;5;4m--table-output-col-names[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to output column names for the database present in the register
   [38;5;7m│[0m when writing it as a tab-separated file
   [38;5;7m│[0m (default='[4m[1mtrue[0m[0m')
  [38;5;4m--table-output-metadata[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to output metadata for the database present in the register
   [38;5;7m│[0m when writing it as a tab-separated file
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m--table-transpose[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to transpose the database present in the register
   [38;5;7m│[0m before writing it as a tab-separated file
   [38;5;7m│[0m  (if 'true': rows are spectrum names, columns [metadata and] k-mer names;
   [38;5;7m│[0m   if 'false': rows are [metadata and] k-mer names, columns spectrum names)
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m--table-threshold[0m
    [1m<non_negative_integer>[0m
   [38;5;7m│[0m set to zero all counts that are less than this threshold
   [38;5;7m│[0m before transforming and outputting them.
   [38;5;7m│[0m A fractional threshold between 0. and 1. is taken as a relative one
   [38;5;7m│[0m with respect to the sum of all counts in the spectrum
   [38;5;7m│[0m (default='[4m[1m1.[0m[0m')
  [38;5;4m--table-power[0m
    [1m<non_negative_float>[0m
   [38;5;7m│[0m raise counts to this power before transforming and outputting them.
   [38;5;7m│[0m A power of 0 when the 'pseudocounts' method is used
   [38;5;7m│[0m performs a logarithmic transformation
   [38;5;7m│[0m (default='[4m[1m1.[0m[0m')
  [38;5;4m--table-transform[0m[38;5;7m|[0m[38;5;4m--table-transformation[0m
    [1m'binary'|'power'|'pseudocounts'|'clr'[0m
   [38;5;7m│[0m transformation to apply to table elements before outputting them
   [38;5;7m│[0m (default='[4m[1mpower[0m[0m')
  [38;5;4m--table-output-zero-rows[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to output rows whose elements are all zero
   [38;5;7m│[0m when writing the database as a tab-separated file
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m--table-precision[0m
    [1m<positive_integer>[0m
   [38;5;7m│[0m set the number of precision digits to be used when outputting counts
   [38;5;7m│[0m (default='[4m[1m15[0m[0m')
  [38;5;4m-t[0m[38;5;7m|[0m[38;5;4m--table[0m
    [1m<file_prefix>[0m
   [38;5;7m│[0m write the database present in the register as a tab-separated file
   [38;5;7m│[0m  (rows are k-mer names, columns are spectrum names;
   [38;5;7m│[0m   the file will be given extension .KPopCounter.txt)
 [38;5;7m│[0m [38;5;2mActions involving the selection register:[0m
  [38;5;4m-L[0m[38;5;7m|[0m[38;5;4m--labels[0m[38;5;7m|[0m[38;5;4m--selection-from-labels[0m
    [1m<spectrum_label>[','...','<spectrum_label>][0m
   [38;5;7m│[0m put into the selection register the specified labels
  [38;5;4m-R[0m[38;5;7m|[0m[38;5;4m--regexps[0m[38;5;7m|[0m[38;5;4m--selection-from-regexps[0m
    [1m<metadata_field>'~'<regexp>[','...','<metadata_field>'~'<regexp>][0m
   [38;5;7m│[0m put into the selection register the labels of the spectra
   [38;5;7m│[0m whose metadata fields match the specified regexps
   [38;5;7m│[0m and where regexps are defined according to <https://ocaml.org/api/Str.html>.
   [38;5;7m│[0m An empty metadata field makes the regexp match labels
  [38;5;4m--selection-combination-criterion[0m[38;5;7m|[0m[38;5;4m--combination-criterion[0m
    [1m'mean'|'median'[0m
   [38;5;7m│[0m set the criterion used to combine the k-mer frequencies of selected spectra.
   [38;5;7m│[0m To avoid rounding issues, each k-mer frequency is also rescaled
   [38;5;7m│[0m by the largest normalization across spectra
   [38;5;7m│[0m  ('mean' averages frequencies across spectra;
   [38;5;7m│[0m   'median' computes the median across spectra)
   [38;5;7m│[0m (default='[4m[1mmean[0m[0m')
  [38;5;4m-A[0m[38;5;7m|[0m[38;5;4m--add-combined-selection[0m[38;5;7m|[0m[38;5;4m--selection-combine-and-add[0m
    [1m<spectrum_label>[0m
   [38;5;7m│[0m combine the spectra whose labels are in the selection register 
   [38;5;7m│[0m and add the result (or replace it if a spectrum named <spectrum_label>
   [38;5;7m│[0m already exists) to the database present in the database register
  [38;5;4m-D[0m[38;5;7m|[0m[38;5;4m--delete[0m[38;5;7m|[0m[38;5;4m--selection-delete[0m
   [38;5;7m│[0m drop the spectra whose labels are in the selection register
   [38;5;7m│[0m from the database present in the register
  [38;5;4m-N[0m[38;5;7m|[0m[38;5;4m--selection-negate[0m
   [38;5;7m│[0m negate the labels that are present in the selection register
  [38;5;4m-P[0m[38;5;7m|[0m[38;5;4m--selection-print[0m
   [38;5;7m│[0m print the labels that are present in the selection register
  [38;5;4m-C[0m[38;5;7m|[0m[38;5;4m--selection-clear[0m
   [38;5;7m│[0m purge the selection register
  [38;5;4m-F[0m[38;5;7m|[0m[38;5;4m--selection-to-table-filter[0m
   [38;5;7m│[0m filter out spectra whose labels are present in the selection register
   [38;5;7m│[0m when writing the database as a tab-separated file
 [38;5;2mMiscellaneous options.[0m
 [38;5;7m│[0m [38;5;2mThey are set immediately[0m
  [38;5;4m-T[0m[38;5;7m|[0m[38;5;4m--threads[0m
    [1m<computing_threads>[0m
   [38;5;7m│[0m number of concurrent computing threads to be spawned
   [38;5;7m│[0m  (default automatically detected from your configuration)
   [38;5;7m│[0m (default='[4m[1m20[0m[0m')
  [38;5;4m-v[0m[38;5;7m|[0m[38;5;4m--verbose[0m
   [38;5;7m│[0m set verbose execution
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m-V[0m[38;5;7m|[0m[38;5;4m--version[0m
   [38;5;7m│[0m print version and exit
  [38;5;4m-h[0m[38;5;7m|[0m[38;5;4m--help[0m
   [38;5;7m│[0m print syntax and exit
```


## kpop_KPopTwist

### Tool Description
This is KPopTwist version 20 [29-Feb-2024]

### Metadata
- **Docker Image**: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
- **Homepage**: https://github.com/PaoloRibeca/KPop
- **Package**: https://anaconda.org/channels/bioconda/packages/kpop/overview
- **Validation**: PASS

### Original Help Text
```text
[38;5;7m╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗[0m
[38;5;7m┃                                              ┃[0m
[38;5;7m┃[0m  [1mThis is[0m [38;5;2mKPopTwist[0m [1mversion[0m [38;5;2m20[0m [[38;5;4m29-Feb-2024[0m]  [38;5;7m┃[0m
[38;5;7m┃                                              ┃[0m
[38;5;7m╚┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝[0m
 [38;5;7m│[0m compiled against: [38;5;2mBiOCamLib[0m version [38;5;2m248[0m [[38;5;4m18-Mar-2024[0m];
                     [38;5;2mKPop[0m version [38;5;2m429[0m [[38;5;4m18-Mar-2024[0m]
 [38;5;7m│[0m (c) 2022-2024 [1mPaolo Ribeca[0m <[4mpaolo.ribeca@gmail.com[0m>
[38;5;1m Usage:[0m
  [1mKPopTwist_[0m [38;5;4m-i|--input <binary_input_prefix> -o|--output <binary_output_prefix> [OPTIONS][0m
 [38;5;2mAlgorithmic parameters[0m
  [38;5;4m-f[0m[38;5;7m|[0m[38;5;4m-F[0m[38;5;7m|[0m[38;5;4m-s[0m[38;5;7m|[0m[38;5;4m-S[0m[38;5;7m|[0m[38;5;4m--fraction[0m[38;5;7m|[0m[38;5;4m--sampling[0m[38;5;7m|[0m[38;5;4m--sampling-fraction[0m
    [1m<fractional_float>[0m
   [38;5;7m│[0m fraction of the k-mers to be considered and resampled before twisting
   [38;5;7m│[0m (default='[4m[1m1.[0m[0m')
  [38;5;4m--threshold-counts[0m
    [1m<non_negative_integer>[0m
   [38;5;7m│[0m set to zero all counts that are less than this threshold
   [38;5;7m│[0m before transforming them.
   [38;5;7m│[0m A fractional threshold between 0. and 1. is taken as a relative one
   [38;5;7m│[0m with respect to the sum of all counts in the spectrum
   [38;5;7m│[0m (default='[4m[1m1.[0m[0m')
  [38;5;4m--power[0m
    [1m<non_negative_float>[0m
   [38;5;7m│[0m raise counts to this power before transforming them.
   [38;5;7m│[0m A power of 0 when the 'pseudocounts' method is used
   [38;5;7m│[0m performs a logarithmic transformation
   [38;5;7m│[0m (default='[4m[1m1.[0m[0m')
  [38;5;4m--transform[0m[38;5;7m|[0m[38;5;4m--transformation[0m
    [1m'binary'|'power'|'pseudocounts'|'clr'[0m
   [38;5;7m│[0m transformation to apply to table elements
   [38;5;7m│[0m (default='[4m[1mpower[0m[0m')
  [38;5;4m-n[0m[38;5;7m|[0m[38;5;4m--normalize[0m[38;5;7m|[0m[38;5;4m--normalize-counts[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m whether to normalize spectra after transformation and before twisting
   [38;5;7m│[0m (default='[4m[1mtrue[0m[0m')
  [38;5;4m--threshold-kmers[0m
    [1m<non_negative_integer>[0m
   [38;5;7m│[0m compute the sum of all transformed (and possibly normalized) counts
   [38;5;7m│[0m for each k-mer, and eliminate k-mers such that the corresponding sum
   [38;5;7m│[0m is less than the largest sum rescaled by this threshold.
   [38;5;7m│[0m This filters out k-mers having low frequencies across all spectra
   [38;5;7m│[0m (default='[4m[1m0.[0m[0m')
 [38;5;2mInput/Output[0m
  [38;5;4m-i[0m[38;5;7m|[0m[38;5;4m--input[0m
    [1m<binary_file_prefix>[0m
   [38;5;7m│[0m load the specified k-mer database in the register and twist it.
   [38;5;7m│[0m File extension is automatically determined
   [38;5;7m│[0m  (will be .KPopCounter).
   [38;5;7m│[0m The prefix is then re-used for output
   [38;5;7m│[0m  (and the output files will be given extensions
   [38;5;7m│[0m   .KPopTwister and .KPopTwisted)
   [38;5;7m*[0m ([38;5;1mmandatory[0m)
  [38;5;4m-o[0m[38;5;7m|[0m[38;5;4m--output[0m
    [1m<binary_file_prefix>[0m
   [38;5;7m│[0m use this prefix when dumping generated twister and twisted sequences.
   [38;5;7m│[0m File extensions are automatically determined
   [38;5;7m│[0m  (will be .KPopTwister and .KPopTwisted)
   [38;5;7m*[0m ([38;5;1mmandatory[0m)
 [38;5;2mMiscellaneous[0m
  [38;5;4m-T[0m[38;5;7m|[0m[38;5;4m--threads[0m
    [1m<computing_threads>[0m
   [38;5;7m│[0m number of concurrent computing threads to be spawned
   [38;5;7m│[0m  (default automatically detected from your configuration)
   [38;5;7m│[0m (default='[4m[1m20[0m[0m')
  [38;5;4m--keep-temporaries[0m
   [38;5;7m│[0m keep temporary files rather than deleting them in the end
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m-v[0m[38;5;7m|[0m[38;5;4m--verbose[0m
   [38;5;7m│[0m set verbose execution
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m-V[0m[38;5;7m|[0m[38;5;4m--version[0m
   [38;5;7m│[0m print version and exit
  [38;5;4m-h[0m[38;5;7m|[0m[38;5;4m--help[0m
   [38;5;7m│[0m print syntax and exit
(BiOCamLib__Tools.Argv.parse.(fun)): [38;5;1mOption '-i|--input' is mandatory[0m
```


## kpop_KPopTwistDB

### Tool Description
This is KPopTwistDB version 29 (18-Mar-2024)

### Metadata
- **Docker Image**: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
- **Homepage**: https://github.com/PaoloRibeca/KPop
- **Package**: https://anaconda.org/channels/bioconda/packages/kpop/overview
- **Validation**: PASS

### Original Help Text
```text
[38;5;7m╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗[0m
[38;5;7m┃                                                ┃[0m
[38;5;7m┃[0m  [1mThis is[0m [38;5;2mKPopTwistDB[0m [1mversion[0m [38;5;2m29[0m [[38;5;4m18-Mar-2024[0m]  [38;5;7m┃[0m
[38;5;7m┃                                                ┃[0m
[38;5;7m╚┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝[0m
 [38;5;7m│[0m compiled against: [38;5;2mBiOCamLib[0m version [38;5;2m248[0m [[38;5;4m18-Mar-2024[0m];
                     [38;5;2mKPop[0m version [38;5;2m429[0m [[38;5;4m18-Mar-2024[0m]
 [38;5;7m│[0m (c) 2022-2024 [1mPaolo Ribeca[0m <[4mpaolo.ribeca@gmail.com[0m>
[38;5;1m Usage:[0m
  [1mKPopTwistDB[0m [38;5;4m[ACTIONS][0m
 [38;5;2mActions.[0m
 [38;5;7m│[0m [38;5;2mThey are executed delayed and in order of specification.[0m
  [38;5;4m-e[0m[38;5;7m|[0m[38;5;4m--empty[0m
    [1m'T'|'t'|'d'[0m
   [38;5;7m│[0m load an empty database into the specified register
   [38;5;7m│[0m  (T=twister; t=twisted; d=distance)
  [38;5;4m-i[0m[38;5;7m|[0m[38;5;4m--input[0m
    [1m'T'|'t'|'d' <binary_file_prefix>[0m
   [38;5;7m│[0m load the specified binary database into the specified register
   [38;5;7m│[0m  (T=twister; t=twisted; d=distance).
   [38;5;7m│[0m File extension is automatically determined depending on database type
   [38;5;7m│[0m  (will be: .KPopTwister; .KPopTwisted; or .KPopDMatrix, respectively)
  [38;5;4m-I[0m[38;5;7m|[0m[38;5;4m--Input[0m
    [1m'T'|'t'|'d' <table_file_prefix>[0m
   [38;5;7m│[0m load the specified tabular database(s) into the specified register
   [38;5;7m│[0m  (T=twister; t=twisted; d=distance).
   [38;5;7m│[0m File extension is automatically determined depending on database type
   [38;5;7m│[0m  (will be: .KPopTwister.txt and .KPopInertia.txt; .KPopTwisted.txt;
   [38;5;7m│[0m   or .KPopDMatrix.txt, respectively)
  [38;5;4m-a[0m[38;5;7m|[0m[38;5;4m--add[0m
    [1m't'|'d' <binary_file_prefix>[0m
   [38;5;7m│[0m add the contents of the specified binary database to the specified register
   [38;5;7m│[0m  (t=twisted; d=distance).
   [38;5;7m│[0m File extension is automatically determined depending on database type
   [38;5;7m│[0m  (will be: .KPopTwisted; or .KPopDMatrix, respectively)
  [38;5;4m-A[0m[38;5;7m|[0m[38;5;4m--Add[0m
    [1m't'|'d' <table_file_prefix>[0m
   [38;5;7m│[0m add the contents of the specified tabular database to the specified register
   [38;5;7m│[0m  (t=twisted; d=distance).
   [38;5;7m│[0m File extension is automatically determined depending on database type
   [38;5;7m│[0m  (will be: .KPopTwisted.txt; or .KPopDMatrix.txt, respectively)
  [38;5;4m-k[0m[38;5;7m|[0m[38;5;4m--kmers[0m[38;5;7m|[0m[38;5;4m--add-kmers[0m[38;5;7m|[0m[38;5;4m--add-kmer-files[0m
    [1m<k-mer_table_file_name>[','...','<k-mer_table_file_name>][0m
   [38;5;7m│[0m twist k-mers from the specified files through the transformation
   [38;5;7m│[0m present in the twister register, and add the results
   [38;5;7m│[0m to the database present in the twisted register
  [38;5;4m--distance[0m[38;5;7m|[0m[38;5;4m--distance-function[0m[38;5;7m|[0m[38;5;4m--set-distance[0m[38;5;7m|[0m[38;5;4m--set-distance-function[0m
    [1m'euclidean'|'cosine'|'minkowski(<non_negative_float>)'[0m
   [38;5;7m│[0m set the function to be used when computing distances.
   [38;5;7m│[0m The parameter for 'minkowski' is the power.
   [38;5;7m│[0m Note that 'euclidean' is the same as 'minkowski(2)',
   [38;5;7m│[0m and 'cosine' is the same as ('euclidean'^2)/2
   [38;5;7m│[0m (default='[4m[1meuclidean[0m[0m')
  [38;5;4m--distance-normalization[0m[38;5;7m|[0m[38;5;4m--set-distance-normalization[0m
    [1m'true'|'false'[0m
   [38;5;7m│[0m set whether twisted vectors should be normalized prior to computing distances
   [38;5;7m│[0m (default='[4m[1mtrue[0m[0m')
  [38;5;4m-m[0m[38;5;7m|[0m[38;5;4m--metric[0m[38;5;7m|[0m[38;5;4m--metric-function[0m[38;5;7m|[0m[38;5;4m--set-metric[0m[38;5;7m|[0m[38;5;4m--set-metric-function[0m
    [1m'flat'|'powers('POWERS_PARAMETERS')'[0m
   [38;5;7m│[0m where POWERS_PARAMETERS :=
   [38;5;7m│[0m  <non_negative_float>','<fractional_float>','<non_negative_float> :
   [38;5;7m│[0m set the metric function to be used when computing distances.
   [38;5;7m│[0m Parameters are:
   [38;5;7m│[0m  internal power; fractional accumulative threshold; external power.
   [38;5;7m│[0m (default='[4m[1mpowers(1,1,2)[0m[0m')
  [38;5;4m-d[0m[38;5;7m|[0m[38;5;4m--distances[0m[38;5;7m|[0m[38;5;4m--compute-distances[0m[38;5;7m|[0m[38;5;4m--compute-twisted-distances[0m
    [1m<twisted_binary_file_prefix>[0m
   [38;5;7m│[0m compute distances between all the vectors present in the twisted register
   [38;5;7m│[0m and all the vectors present in the specified twisted binary file
   [38;5;7m│[0m  (which must have extension .KPopTwisted)
   [38;5;7m│[0m using the metric provided by the twister present in the twister register.
   [38;5;7m│[0m The result will be placed in the distance register
  [38;5;4m-o[0m[38;5;7m|[0m[38;5;4m--output[0m
    [1m'T'|'t'|'d' <binary_file_prefix>[0m
   [38;5;7m│[0m dump the database present in the specified register
   [38;5;7m│[0m  (T=twister; t=twisted; d=distance)
   [38;5;7m│[0m to the specified binary file.
   [38;5;7m│[0m File extension is automatically assigned depending on database type
   [38;5;7m│[0m  (will be: .KPopTwister; .KPopTwisted; or .KPopDMatrix, respectively)
  [38;5;4m--precision[0m[38;5;7m|[0m[38;5;4m--set-precision[0m[38;5;7m|[0m[38;5;4m--set-table-precision[0m
    [1m<positive_integer>[0m
   [38;5;7m│[0m set the number of precision digits to be used when outputting numbers
   [38;5;7m│[0m (default='[4m[1m15[0m[0m')
  [38;5;4m-O[0m[38;5;7m|[0m[38;5;4m--Output[0m
    [1m'T'|'t'|'d'|'m' <table_file_prefix>[0m
   [38;5;7m│[0m dump the database present in the specified register
   [38;5;7m│[0m  (T=twister; t=twisted; d=distance; m=metric)
   [38;5;7m│[0m to the specified tabular file(s).
   [38;5;7m│[0m File extension is automatically assigned depending on database type
   [38;5;7m│[0m  (will be: .KPopTwister.txt and .KPopInertia.txt; .KPopTwisted.txt;
   [38;5;7m│[0m   .KPopDMatrix.txt; or .KPopMetrics.txt, respectively)
  [38;5;4m-K[0m[38;5;7m|[0m[38;5;4m--keep-at-most[0m[38;5;7m|[0m[38;5;4m--set-keep-at-most[0m[38;5;7m|[0m[38;5;4m--summary-keep-at-most[0m
    [1m<positive_integer>|'all'[0m
   [38;5;7m│[0m set the maximum number of closest target sequences
   [38;5;7m│[0m to be kept when summarizing distances.
   [38;5;7m│[0m Note that more might be printed anyway in case of ties
   [38;5;7m│[0m (default='[4m[1m2[0m[0m')
  [38;5;4m-s[0m[38;5;7m|[0m[38;5;4m--compute-and-summarize-distances[0m[38;5;7m|[0m[38;5;4m--compute-and-summarize-twisted-distances[0m
    [1m<twisted_binary_file_prefix> <summary_file_prefix>[0m
   [38;5;7m│[0m compute distances between all the vectors present in the twisted register
   [38;5;7m│[0m and all the vectors present in the specified twisted binary file
   [38;5;7m│[0m  (which must have extension .KPopTwisted)
   [38;5;7m│[0m using the metric provided by the twister present in the twister register;
   [38;5;7m│[0m summarize them and write the result to the specified tabular file.
   [38;5;7m│[0m File extension is automatically assigned
   [38;5;7m│[0m  (will be .KPopSummary.txt)
  [38;5;4m-S[0m[38;5;7m|[0m[38;5;4m--summarize-distances[0m[38;5;7m|[0m[38;5;4m--summarize-twisted-distances[0m
    [1m<summary_file_prefix>[0m
   [38;5;7m│[0m summarize the distances present in the distance register
   [38;5;7m│[0m and write the result to the specified tabular file.
   [38;5;7m│[0m File extension is automatically assigned
   [38;5;7m│[0m  (will be .KPopSummary.txt)
 [38;5;2mMiscellaneous options.[0m
 [38;5;7m│[0m [38;5;2mThey are set immediately.[0m
  [38;5;4m-T[0m[38;5;7m|[0m[38;5;4m--threads[0m
    [1m<computing_threads>[0m
   [38;5;7m│[0m number of concurrent computing threads to be spawned
   [38;5;7m│[0m  (default automatically detected from your configuration)
   [38;5;7m│[0m (default='[4m[1m20[0m[0m')
  [38;5;4m-v[0m[38;5;7m|[0m[38;5;4m--verbose[0m
   [38;5;7m│[0m set verbose execution
   [38;5;7m│[0m (default='[4m[1mfalse[0m[0m')
  [38;5;4m-V[0m[38;5;7m|[0m[38;5;4m--version[0m
   [38;5;7m│[0m print version and exit
  [38;5;4m-h[0m[38;5;7m|[0m[38;5;4m--help[0m
   [38;5;7m│[0m print syntax and exit
```


## Metadata
- **Skill**: generated
