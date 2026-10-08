# conduit-assembler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| conduit-assembler_conduitUtils_bed2gtf | PASS | Converted the nf-core chr22 genome.bed12 (trailing commas removed, which the parser cannot read); exon coordinates match genome.gtf exactly. |
| conduit-assembler_conduitUtils_callNonCanonical | PASS | On bedtools getfasta intron sequences from the yeast data, it reports exactly the two non GT-AG introns (TRN1 and SUP56 tRNA introns). |
| conduit-assembler_conduitUtils_callNovelNonCanonical | PASS | Yeast intron IDs with read counts added to the names: against the full yeast GTF 0 novel, against the GTF without SNC1 exactly the SNC1 intron; the intron with 2 reads is skipped. |
| conduit-assembler_conduitUtils_callOverlapping | PASS | Comparing all 5 yeast intron IDs with the 4 plus-strand ones reports 4 shared and 1 non-overlapping intron, as expected. |
| conduit-assembler_conduitUtils_compareBLASTP | Failed | tool bug: same BLASTP parser as parseBLASTP; on BLAST+ 2.17 default output of 21 matched proteins it reports TP 0 after 'ERROR PARSING BLASTP OUTPUT'. |
| conduit-assembler_conduitUtils_compareFASTA | PASS | Compared CONDUIT proteins translated with min length 75 (query) and 50 (reference): TP 23, FP 0, FN 3, as counted independently. |
| conduit-assembler_conduitUtils_extractIntrons | PASS | Extracted the 5 introns of the nf-core yeast genome_gfp.bed12; e.g. the SNC1 intron 87387-87500 lies exactly between its GTF exons. |
| conduit-assembler_conduitUtils_filterFASTA | PASS | Kept the 8 CONDUIT consensus records with at least 5 supporting reads, as counted independently. |
| conduit-assembler_conduitUtils_parseBLASTP | Failed | tool bug: the parser expects a BLASTP header layout ('Score        E') that BLAST+ 2.11 and 2.17 default output does not have, so it stops with 'ERROR PARSING BLASTP OUTPUT' after the first query. |
| conduit-assembler_conduitUtils_splitFASTA | PASS | Split the CONDUIT consensus FASTA into the 10 read-support bins; each record lands in the bin of its _<reads> suffix (1, 2-4, 5-9, 10-19). |
| conduit-assembler_conduitUtils_translate | PASS | Translated the 32 CONDUIT consensus sequences from a conduit hybrid run on SARS-CoV-2 amplicon reads; 27 ORFs of at least 50 aa, which BLASTP maps to ORF1ab and N. |
| conduit-assembler_conduit_hybrid | PASS |  |

## conduit-assembler_conduit_hybrid

### Tool Description
CONsensus Decomposition Utility In Transcriptome-assembly: hybrid mode corrects nanopore scaffold reads, separated by gene cluster, with Illumina reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
Usage:
  ./conduit hybrid [options] <clustersDirectory> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | -b <bam>}
  <clustersDirectory>   Directory containing the .fasta/.fa or .fastq/.fq files of reads separated by gene cluster
                         NOTE: .gz support coming for nanopore scaffold data, but is not an option at this time

  Illumina data is aligned with Bowtie2, therefore Illumina data is provided in the same format as Bowtie2, namely:

    <m1>                   Files with #1 mates, paired with files in <m2>
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <m2>                   Files with #2 mates, paired with files in <m1>
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <r>                    Files with unpaired reads
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <i>                    File with interleaved paired-end FASTQ/FASTA reads
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <bam>                  Files are unaligned BAM sorted by read name.

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be specified many times.
  E.g. '-U file1.fq,file2.fq -U file3.fq'.

Options (defaults in parentheses):
  Scaffold Type:
    --drna (default)
        Scaffold reads are stranded forward relative to coding strand, enforces --UtoT
    --cdna-rev-stranded
        Scaffold reads are stranded reverse complemented relative to coding strand
    --cdna
        Scaffold reads are NOT stranded
    --sfq (default)
        Scaffold reads are in FASTQ format, enforces --UtoT
    --sfa
        Scaffold reads are in FASTA format
    --UtoT (default)
        Scaffold reads contain Us instead of Ts. Converts U nucleotides to Ts in the sequences
        NOTE: This adds a bit of I/O overhead but doesn't affect things if your sequences are already U free
    --noUtoT
        Scaffold reads do not contain Us and do not need to be converted.
  Illumina Type:
    -u, --unstranded
        Illumina reads are unstranded
    -f, --fwd-stranded
        Illumina reads are stranded s.t. the first mate originates from the RNA strand
        Ignored if scaffold reads are not stranded
    -r, --rev-stranded (default)
        Illumina reads are stranded s.t. the first mate is the reverse complement of the RNA strand
        Ignored if scaffold reads are not stranded
    --ifq (default)
        Illumina reads are in FASTQ format; Mutually exclusive with --ifa
    --ifa
        Illumina reads are in FASTA format; Mutually exclusive with --ifq
  Consensus Collapsing:
    -m, --score-matrix <path>
        Provide an alternative scoring matrix to use in partial order alignment
        Example formatting for the score matrix can be found at poaV2/myNUC3.4.4.mat
    -d, --isoform-delta (35)
        Maximum indel size to be 'corrected', beyond this size a new isoform is declared. Must be between 2 and 255
    -e, --ends-delta (35)
        Maximum size at the ends of isoforms to 'correct' before splitting. Must be between 2 and 255
    -i, --max-iterations (5)
        Maximum number of iterations to align to and correct scaffolds. Does not include optional final polshing step
        Note: Providing a value of 0 will not perform any graph based illumina correction
    -w, --illumina-weight (10)
        Weight of illumina reads relative to nanopore reads when generating consensus
    --final-polish (default)
        Include a final correction of individual isoforms, not in a splice graph
    --no-final-polish
        Do not do a final correction of individual isoforms, not in a splice graph
    --stringent (default)
        Enforce that every base / edge in each final reported isoform is supported by an Illumina read, excluding --stringent-tolerance bp on each end of each isoform
    --no-stringent
        Do not enforce that every base / edge in each final reported isoform is supported by an Illumina read
    --stringent-tolerance (100)
        Number of bases at the end of each isoform that do not have to have Illumina reads supporting them when run in --stringent mode; ignored when run with --no-stringents
  Ouput:
    -o, --output-dir <path> (conduit/)
        <path> where corrected clusters will be written
        NOTE: THIS WILL OVERWRITE EXISTING FILES!
    -n, --no-intermediates (default)
        Does not save FASTA file generated for intermediate rounds of polishing
    -s, --save-intermediates
        Saves the FASTA file generated for intermediate rounds of polishing
  Bowtie2:
    --end-to-end (default)
        Align Illumina reads to ONT scaffolds in end-to-end alignment mode
    --local
        Align Illumina reads to ONT scaffolds in local alignment mode
    -k,--bowtie2-max-alignments (50)
        Maximum number of alignments per Illumina read to be used in final polishing step
  SAMtools:
    --samtools-thread-memory (768 MiB)
        Memory amount to use per SAMtools thread
        Specified either in bytes or with a K, M, or G suffix
  Miscellaneous:
    -h, --help
        Display this help message and exit
    -v, --version
        Display the installed version number of CONDUIT and exit
    --tmp-dir <path> (conduit-tmp/)
        <path> where temporary files will be created
    -t, --threads (4)
        Number of threads to run in parallel (used for both Bowtie2 and Partial Order Graph correction)
```


## conduit-assembler_conduitUtils_translate

### Tool Description
Translates FASTA/Q nucleotide sequences into protein based on their longest ORF

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
translate   - Translates FASTA/Q nucleotide sequences into protein based on their longest ORF
Usage:
  ./conduitUtils translate [options] -i <transcripts.fa> -o <predicted_protein.fa>
  <transcripts.fa>         FASTA/Q infile containing putative transcripts to be translated
  <predicted_protein.fa>   FASTA outfile containing in silico translated ORFs from transcripts.fa

Options (defaults in parentheses):
  Input Options:
    -a, --fasta (default)
        Input file is in FASTA format
    -q, --fastq
        Input file is in FASTQ format
    -s, --stranded
        Input reads are forward stranded
  Filtering Options:
    -l, --min-length (75)
        Minimum length in Amino Acids necessary for a putative ORF to be reported
```


## conduit-assembler_conduitUtils_bed2gtf

### Tool Description
Converts BED12 files to well structured GTF file suitable for use in GFFcompare

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
bed2gtf     - Converts BED12 files to well structured GTF file suitable for use in GFFcompare
Usage:
  ./conduitUtils bed2gtf -i <infile.bed> -o <outfile.gtf>
  <infile.bed>    BED12 infile to be converted in to GTF format
  <outfile.gtf>   GTF outfile

Options (defaults in parentheses):
  Input Options:
    -s, --stranded
        Report gtf fields with strand information
```


## conduit-assembler_conduitUtils_parseBLASTP

### Tool Description
Parses BLASTP output and outputs closest match for each query transcript as determined by BLASTP

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
parseBLASTP   - Parses BLASTP output and outputs closest match for each query transcript as determined by BLASTP
Usage:
  ./conduitUtils parseBLASTP -i <inBLASTP.txt> -o <outPutativeOrthologs.tsv>
  <inBLASTP.txt>              Default output of BLASTP search of translated protein products vs some reference proteome
  <outPutativeOrthologs.tsv>  Tab separated file of putative ortholog matches
                              In format: <Query ID>	<Reference proteome top match ID>	<E value>
```


## conduit-assembler_conduitUtils_compareBLASTP

### Tool Description
Compares BLASTP output and reference proteome to determine the # of true positives, false positives, and false negatives for a sample

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
compareBLASTP - Compares BLASTP output and reference proteome to determine the # of true positives, false positives, and false negatives for a sample
Usage:
  ./conduitUtils compareBLASTP -r <reference_proteome.fa> -i <inBLASTP.txt>
  <reference_proteome.fa>     FASTA file describing the reference proteome used in the BLASTP search
  <inBLASTP.txt>              Default output of BLASTP search of translated protein products vs some reference proteome
```


## conduit-assembler_conduitUtils_compareFASTA

### Tool Description
Compares two FASTA files, an input and a reference, to determine the # of true positives, false positives, and false negatives for a sample

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
compareFASTA  - Compares two FASTA files, an input and a reference, to determine the # of true positives, false positives, and false negatives for a sample
Usage:
  ./conduitUtils compareFASTA -r <reference.fa> -i <query.fa>
  <reference.fa>              Reference FASTA file defining the truth set
  <query.fa>                  Query FASTA files defining the query set
```


## conduit-assembler_conduitUtils_splitFASTA

### Tool Description
Splits CONDUIT produced FASTA file based on the number of reads supporting each isoform

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
splitFASTA    - Splits CONDUIT produced FASTA file based on the number of reads supporting each isoform
Usage:
  ./conduitUtils splitFASTA -i <conduit_output.fa> -o <outprefix>
  <conduit_output.fa>         CONDUIT produced FASTA file to be split based on number of reads supporting each isoform
  <outprefix>                 Prefix for the fasta files to be output, suffix will describe the bin being reported
```


## conduit-assembler_conduitUtils_filterFASTA

### Tool Description
Filters CONDUIT produced FASTA file based on number of reads supporting each isoform

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
filterFASTA   - Filters CONDUIT produced FASTA file based on number of reads supporting each isoform
Usage:
  ./conduitUtils filterFASTA -i <inBLASTP.txt> -o <outPutativeOrthologs.tsv>
  <conduit_output.fa>         CONDUIT produced FASTA file to be filtered based on number of reads supporting each isoform
  <filtered.fa>               Output FASTA file for filtered reads
Options: (defaults in parentheses)
  Filtering options:
     -n (5)
        Minimum number of reads that must support an isoform for it to be reported in the filtered FASTA
```


## conduit-assembler_conduitUtils_extractIntrons

### Tool Description
Extracts out intronic sequences from BED12 formatted input and outputs as BED6

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
extractIntrons   - Extracts out intronic sequences from BED12 formatted input and outputs as BED6
Usage:
  ./conduitUtils extractIntrons -i <transcripts.bed12> -o <introns.bed>
  <transcripts.bed12>         Transcripts in BED12 format to extract introns from
  <introns.bed>               BED6 output of extracted introns
```


## conduit-assembler_conduitUtils_callNonCanonical

### Tool Description
Reads in a FASTA file and reports the readIDs of sequences that dont begin with GT and end with AG

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
callNonCanonical - Reads in a FASTA file and reports the readIDs of sequences that dont begin with GT and end with AG
Usage:
  ./conduitUtils callNonCanonical -i <introns.fa> -o <noncanonical.txt>
  <introns.fa>              FASTA describing the stranded sequence of introns extracted from `extractIntrons`
                            Introns sequences can be obtained using `bedtools getfasta -name -s`
  <noncanonical.txt>        Read IDs of the sequences that didn't begin with GT and end with AG
```


## conduit-assembler_conduitUtils_callNovelNonCanonical

### Tool Description
Compares introns described by reference GTF file to introns described by a list of readIDs in the format produced by bedtools getfasta -name, outputs the novel introns in BED format

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
callNovelNonCanonical - Compares introns described by reference GTF file to introns described by a list of readIDs in the format produced by `bedtools getfasta -name` function, outputs the novel introns in BED format
Usage:
  ./conduitUtils callNovelNonCanonical -r <reference.gtf> -i <noncanonical.txt> -o <novel.bed>
  <reference.gtf>              Reference GTF file specifying the introns to compare against
  <noncanonical.txt>           Read IDs specifying intron structure in the format produced by `bedtools getfasta -name`
  <novel.bed>                  Output of introns found in the noncanonical.txt file but not found in the reference, in BED6 format
```


## conduit-assembler_conduitUtils_callOverlapping

### Tool Description
Compares two files of readIDs specifying introns in the format produced by bedtools getfasta -name, and reports the introns that are shared between the two files

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Utilities Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
callOverlapping - Compares two files of readIDs specifying introns in the format produced by `bedtools getfasta -name`, and reports the introns that are shared between the two files (not stranded)
Usage:
  ./conduitUtils callOverlapping -r <introns1.txt> -i <introns2.txt> -o <shared_introns.txt>
  <introns1.txt>              Read IDs specifying introns in the format produced by `bedtools getfasta -name`
  <introns2.txt>              Read IDs specifying introns in the format produced by `bedtools getfasta -name`
  <shared_introns.txt>        The introns in common between the two files
```


