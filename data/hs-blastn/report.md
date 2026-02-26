# hs-blastn CWL Generation Report

## hs-blastn_index

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hs-blastn:0.0.5--h9948957_6
- **Homepage**: https://github.com/chenying2016/queries
- **Package**: https://anaconda.org/channels/bioconda/packages/hs-blastn/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/hs-blastn/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chenying2016/queries
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[IndexBuilder] A genomic database index builder.

[DbInfoGenerator] building DbInfo.
[StreamLineReader] Fatal Error: Cannot open file --help for reading.
```


## hs-blastn_align

### Tool Description
Nucleotide-Nucleotide Aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/hs-blastn:0.0.5--h9948957_6
- **Homepage**: https://github.com/chenying2016/queries
- **Package**: https://anaconda.org/channels/bioconda/packages/hs-blastn/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
  hs-blastn align [-h] [-help] [-db database_name]
    [-query input_file]
    [-evalue evalue] [-word_size int_value]
    [-gapoptn open_penalty] [-gapextend extend_penalty]
    [-perc_identity float_value] [-xdrop_ungap float_value]
    [-xdrop_gap float_value] [-xdrop_gap_final float_value]
    [-penalty penalty] [-reward reward]
    [-min_raw_gapped_score int_value] [-dust DUST_options]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-num_threads int_value]

    [-max_target_seqs num_sequences]

DESCRIPTION
    Nucleotide-Nucleotide Aligner

OPTIONAL ARGUMENTS
 -h
    Print USAGE and DESCRIPTION; ignore all other parameters
 -help
    Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
 -version
    Print version number; ignore other arguments

 *** Input query options
 -query <File_In>
    Input file name (FASTA or FASTQ format),
    the base qualities in FASTQ formated files will be ignored.
 *** General search options
 -db <File_In>
    database name
 -out <File_Out>
    Output file name
    Default = standard output
 -evalue <Real>
    Expectation value (E) threshold for saving hits
    Default = '10'
 -word_size <Integer, >= 12>
    Word size for wordfiner algorithm (length of best perfect match)
 -gapopen <Integer>
    Cost to open a gap
 -gapextend <Integer>
    Cost to extend a gap
 -penalty <Integer, <=0>
    Penalty for a nucleotide mismatch
 -reward <Interger, >=0>
    Reward for a nucleotide match
[Note] Not all the combinations [gapopen, gapextend, penalty, reward]
       are supported by NCBI-BLASTN. And so is HS-BLASTN.

 *** Formatting options
 -outfmt <String>
    alignment view options
      0 = pairwise,
      6 = tabular,
      7 = tabular with comment lines
 -num_descriptions <Integer, >=0>
    Number of database sequences to show one-line descriptions for
    Not applicable for outfmt >= 6
    Default = '500'
 -num_alignments <Integer, >=0>
    Number of database sequences to show alignments for
    Default = '250'

 -dust <String>
    Filter query sequence with DUST (Format: 'yes', 'level window linker', or
    'no' to disable)
    Default = '20 64 1'
 -perc_identity <Real, 0..100>
    Percent identity

-max_target_seqs <Integer, >=1>
    Maxinum number of aligned sequences to keep
    Not applicable for outfmt <= 4
    Default = '500'
     * Incompatable with: num_descriptions, num_alignments

 *** Extension options
 -xdrop_ungap <Real>
    X-dropoff value (in bits) for ungapped extensions
 -xdrop_gap <Real>
    X-dropoff value (in bits) for preliminary gapped extensions
 -xdrop_gap_final
    X-dropoff value (in bits) for final gapped alignment
 -min_raw_gapped_score <Integer>
    Minimum raw gapped score to keep an alignment in the preliminary gapped and
    traceback stages

 *** Miscellaneous options
 -num_threads <Integer, >=1>
    Number of threads (CPUs) to use in the search
    Default = '1'
```

