# metaplex CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metaplex_Metaplex-calculate-IJR | Failed | image problem: qiime2 is not installed in the image (ModuleNotFoundError at start) |
| metaplex_Metaplex-length-filter | Failed | image problem: qiime2 is not installed in the image (ModuleNotFoundError at start) |
| metaplex_Metaplex-per-sample-filter | Failed | image problem: qiime2 is not installed in the image (ModuleNotFoundError at start) |
| metaplex_Metaplex-remultiplex | PASS | 20000 real reads from the tool repo are remultiplexed: each read starts with the forward index plus reverse index (F01R11 checked) |

## metaplex_Metaplex-remultiplex

### Tool Description
Remultiplexes dual-indexed reads: trims the reads past the indexes and moves the 3' index next to the 5' index.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Metaplex-remultiplex raw_seqs.fastq.gz indexes.csv

Takes dual-indexed reads, trims the 5' and 3' ends of the reads past the indexes, and moves the 3' index to
immediately follow the 5' index (i.e. ['MultiplexedSingleEndBarcodeInSequence'] format)

  sequenceFile : path to raw sequence file of type .fastq, .fastq.gz, or .bam
  indexFile    : path to .csv containing all the index tag sequences that are present in the sequencing pool
                 (columns: ID, seq, orientation)

Output: remultiplexed_seqs.fastq.gz
```

## metaplex_Metaplex-calculate-IJR

### Tool Description
Calculates the index jump rate from calibrator tag pairs of demultiplexed QIIME2 reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Metaplex-calculate-IJR demultiplexed_seqs.qza Sample_Map.txt 01,11

Calculate Index Jump Rate based off calibrator Tags

  demultiplexed_seqs   : path to demultiplexed QIIME2 qza file of data type SampleData[SequencesWithQuality]
  sample_map           : path to tab delimited QIIME2 sample map file
  calibrator_tag_pairs : pairs of calibrator tags, each index a 2 digit zero padded string, e.g. 01,11 (one argument per pair)

Output: Expected_False_Reads_Per_Index.csv (number of false reads expected in each sample), log.txt (summary statistics)
```

## metaplex_Metaplex-length-filter

### Tool Description
Removes sequences shorter than a length threshold from a QIIME2 feature table and its representative sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Metaplex-length-filter feature_table.qza rep_seqs.qza LENGTH

Length filter of QIIME2 feature table and representative sequences

  feature_table            : path to QIIME2 qza file of data type FeatureTable[Frequency]
  representative_sequences : path to QIIME2 qza file of data type FeatureData[Sequence]
  length_to_filter         : an integer threshold for sequence length. All sequences shorter than the specified length are removed.

Output: length_filt_table_LENGTH.qza, length_filt_seqs_LENGTH.qza
```

## metaplex_Metaplex-per-sample-filter

### Tool Description
Filters reads out of a QIIME2 feature table with a minimum read count requirement per sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Metaplex-per-sample-filter feature_table.qza Expected_False_Reads_Per_Index.csv

Filters reads out of a QIIME2 feature table according to a minimum read count requirement per sample

  feature_table     : path to QIIME2 feature table
  filtering_integer : either an integer for even filtering across samples, or path to the
                      Expected_False_Reads_Per_Index.csv output by Metaplex-calculate-IJR

Output: freq_filt_table.qza
```
