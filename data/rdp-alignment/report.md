# rdp-alignment CWL Generation Report

## rdp-alignment_alignment-merger

### Tool Description
This program reads in all the files from the input directory and merges the alignment into one single file

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdp-alignment/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Stars**: N/A
### Original Help Text
```text
Exception in thread "main" java.lang.IllegalArgumentException: Usage: java AlignmentMerger <alignfiledir> <outfile.fasta> [ <mask_file>] 
  This program reads in all the files from the input directory and merges the alignment into one single file
  stkdir contains a list of aligned stk files to be merged 
  maskfile contains the model positions to be ignored
	at edu.msu.cme.rdp.alignment.AlignmentMerger.main(AlignmentMerger.java:291)
	at edu.msu.cme.rdp.alignment.AlignmentToolsMain.main(AlignmentToolsMain.java:49)
```


## rdp-alignment_pairwise-knn

### Tool Description
Pairwise alignment tool using k-nearest neighbors

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: PairwiseKNN <options> <queryFile> <dbFile>
 -k <arg>               K-nearest neighbors to return. (default = 1)
 -m,--mode <arg>        Alignment mode {global, glocal, local, overlap,
                        overlap_trimmed} (default= glocal)
 -o,--out <arg>         Redirect output to file instead of stdout
 -p,--prefilter <arg>   The top p closest targets from kmer prefilter
                        step. Set p=0 to disable the prefilter step.
                        (default = 10)
 -w,--word-size <arg>   The word size used to find closest targets during
                        prefilter. (default 4 for protein, 8 for
                        nucleotide)
```


## rdp-alignment_compare-error-type

### Tool Description
Compare error types in alignments

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: CompareErrorType [options] <ref_nucl> (<query_nucl> |
                        <query_nucl.fasta> <query_nucl.qual>)
 -s,--stem <arg>   Output stem (default <query_nucl.fasta>)
```


## rdp-alignment_align-nucl-to-prot

### Tool Description
Aligns nucleotide sequences to a protein alignment.

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE: AlignNucleotideToProtein <aligned prot seqs> <unaligned_nucl_seqs> <aligned nucl out> <stats out>
```


## rdp-alignment_rm-partialseq

### Tool Description
Performs alignment of sequences, marking partial sequences based on gap count.

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage:  [options] fulllengthSeqFile queryFile passedSeqOutFile
  sequences can be either protein or nucleotide
 -a,--alignment-mode <arg>   Alignment mode: overlap, glocal, local or global.
                             default = overlap
 -g,--min_gaps <arg>         The minimum number of continuous gaps in the
                             beginning or end of the query alignment. If above
                             the cutoff, the query is marked as partial. default
                             = 50
 -k,--knn <arg>              The top k closest targets using a heuristic method.
                             (default = 20)
 -o,--alignment-out <arg>    The output file containing the pairwise alignment
```


## Metadata
- **Skill**: not generated

## rdp-alignment

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
- **Homepage**: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations
- **Package**: Not found
- **Validation**: FAIL (generation failed)
### Generation Failed

No inputs — do not generate CWL.

### Validation Errors
- No inputs — do not generate CWL.

### Original Help Text
```text
USAGE: AlignmentToolsMain <subcommand> <options>
	alignment-merger     - Merge alignments
	pairwise-knn         - Compute k-nearest-neighbors by pairwise alignment
	compare-error-type   - Detect insertion, deletion and substitution errors in sequences comparing to reference sequences
	align-nucl-to-prot   - Transfer a sequence alignment from protein sequences to nucleotide sequences
	rm-partialseq        - remove partial sequences based on pairwise alignment to reference sequences
```

