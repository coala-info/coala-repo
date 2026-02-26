# adam CWL Generation Report

## adam_adam-submit

### Tool Description
ADAM is a genomics analysis platform which leverages Apache Spark. This tool provides various actions for transforming, converting, and analyzing genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/adam:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/bigdatagenomics/adam
- **Package**: https://anaconda.org/channels/bioconda/packages/adam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/adam/overview
- **Total Downloads**: 60.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bigdatagenomics/adam
- **Stars**: N/A
### Original Help Text
```text
e        888~-_         e            e    e
      d8b       888   \       d8b          d8b  d8b
     /Y88b      888    |     /Y88b        d888bdY88b
    /  Y88b     888    |    /  Y88b      / Y88Y Y888b
   /____Y88b    888   /    /____Y88b    /   YY   Y888b
  /      Y88b   888_-~    /      Y88b  /          Y888b

Usage: adam-submit [<spark-args> --] <adam-args>

Choose one of the following commands:

ADAM ACTIONS
          countKmers : Counts the k-mers/q-mers from a read dataset.
     countSliceKmers : Counts the k-mers/q-mers from a slice dataset.
 transformAlignments : Convert SAM/BAM to ADAM format and optionally perform read pre-processing transformations
   transformFeatures : Convert a file with sequence features into corresponding ADAM format and vice versa
  transformGenotypes : Convert a file with genotypes into corresponding ADAM format and vice versa
  transformSequences : Convert a FASTA file as sequences into corresponding ADAM format and vice versa
     transformSlices : Convert a FASTA file as slices into corresponding ADAM format and vice versa
   transformVariants : Convert a file with variants into corresponding ADAM format and vice versa
         mergeShards : Merges the shards of a file
            coverage : Calculate the coverage from a given ADAM file

CONVERSION OPERATIONS
          adam2fastq : Convert BAM to FASTQ files
  transformFragments : Convert alignments into fragment records.

PRINT
               print : Print an ADAM formatted file
            flagstat : Print statistics on reads in an ADAM file (similar to samtools flagstat)
                view : View certain reads from an alignment-record file.
```

