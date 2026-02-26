# rdp-readseq CWL Generation Report

## rdp-readseq_random-sample

### Tool Description
ResampleSeqFile

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdp-readseq/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ResampleSeqFile [options] <infile(dir)> <outdir>
 -n,--num-selection <arg>      number of sequence to select for each sample. Default is the smallest sample size. Limit
                               to the default value.
 -s,--subregion_length <arg>   If specified, radomly choose a subregion with the required length from the sequence.  If
                               a selected sequence is shorter than the specified length, that sequence will not be
                               included in the output,  which may result in not equal number of sequences in some
                               samples.
ERROR: Incorrect number of command line arguments
```


## rdp-readseq_reverse-comp

### Tool Description
Reverse complement a DNA sequence

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: RevComplement [options]
 -c,--check           If set, will check orientation of the rRNA sequenc, only reverse complement if needed
 -f,--format <arg>    output format, fasta or fastq. Default is fasta
 -i,--infile <arg>    input fasta file
 -o,--outfile <arg>   output fasta file
```


## rdp-readseq_rm-dupseq

### Tool Description
Remove redundant sequences from a FASTA file.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: RmRedundantSeqs [options]
 -d,--duplicates             remove identical sequence, or sequence contained by another sequence
 -g,--debug                  output the ids that are contained by other sequences to standard out
 -i,--infile <arg>           input fasta file
 -l,--min_seq_length <arg>   filter sequence by minimum sequence length, default is 0
 -o,--outfile <arg>          output fasta file
```


## rdp-readseq_select-seqs

### Tool Description
Selects sequences from input files based on a list of IDs.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE: SequenceSelector ids_file outfile outputformat keep[Y|N] seqfile(s) 
Input format is fasta or fastq. The outputformat can be either fasta or fastq if inputs are fastq
Default is to keep the sequences in the ids_file. If keep is false or N, the sequences will be removed from output
```


## rdp-readseq_split

### Tool Description
Splits a sequence file into smaller files.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: SeqFileSplitter infile outdir seq_per_split
```


## rdp-readseq_to-fasta

### Tool Description
Converts RDP readseq format to FASTA format.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: USAGE: to-fasta <input-file>
 -m,--mask <arg>   Mask sequence name indicating columns to drop
```


## rdp-readseq_to-fastq

### Tool Description
Converts sequence files to FASTQ format.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Exception in thread "main" java.io.FileNotFoundException: --help
	at edu.msu.cme.rdp.readseq.utils.SeqUtils.guessFileFormat(SeqUtils.java:327)
	at edu.msu.cme.rdp.readseq.utils.SeqUtils.getSeqReaderCore(SeqUtils.java:261)
	at edu.msu.cme.rdp.readseq.readers.SequenceReader.<init>(SequenceReader.java:46)
	at edu.msu.cme.rdp.readseq.ToFastq.main(ToFastq.java:45)
	at edu.msu.cme.rdp.readseq.ReadSeqMain.main(ReadSeqMain.java:62)
```


## rdp-readseq_to-stk

### Tool Description
Converts a readseq file to a Stockholm format file.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: USAGE: to-stk <input-file> <out-file>
 -h,--header <arg>   the header of the output file in case a differenet
                     stk version, default is # STOCKHOLM 1.0
 -r,--removeref      is set, do not write the GC reference sequences to
                     output
```


## Metadata
- **Skill**: generated

## rdp-readseq

### Tool Description
Main entry point for ReadSeq operations. Use with a subcommand.

### Metadata
- **Docker Image**: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
ERROR: wrong subcommand
USAGE: ReadSeqMain <subcommand> <subcommand args ...>
	random-sample  - random select a subset or subregion of sequences
	reverse-comp   - reverse complement sequences
	rm-dupseq      - remove identical or substring of sequences
	select-seqs    - select or deselect sequences from a file
	split          - split sequences
	to-fasta       - convert to fasta format
	to-fastq       - convert to fastq format
	to-stk         - convert to stk format
```

