# dropseq_tools CWL Generation Report

## dropseq_tools_TrimStartingSequence

### Tool Description
Trim the given sequence from the beginning of reads

### Metadata
- **Docker Image**: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
- **Homepage**: http://mccarrolllab.com/dropseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Total Downloads**: 28.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/Drop-seq
- **Stars**: N/A
### Original Help Text
```text
USAGE: TrimStartingSequence [-m <jvm_heap_size>] [-v] program args...

-m <jvm_heap_size> : Heap size to allocate for the JVM.  Default: 4g.
-v                 : Echo final command line before executing.
-h                 : Print usage and exit.

Program options:
USAGE: TrimStartingSequence [arguments]

Trim the given sequence from the beginning of reads
Version:3.0.2


Required Arguments:

--INPUT,-I <File>             The input SAM or BAM file to analyze.  Required. 

--OUTPUT,-O <File>            The output BAM file  Required. 

--SEQUENCE <String>           The sequence to look for at the start of reads.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LEGACY <Boolean>            Enable the old trim algorithm (release <= 2.4.0), which did not match if bases precede the
                              sequence, and had bugs if sequence was longer than read length.    Default value: false.
                              Possible values: {true, false}  Cannot be used in conjunction with argument(s)
                              MISMATCH_RATE LENGTH_TAG

--LENGTH_TAG <String>         Tag containing the length of sequence matched.  If using MISMATCHES algorithm, this will
                              be the same value as stored in TRIM_TAG.  If using MISMATCH_RATE, full-length sequence
                              will match even if something precedes it, so this may be different than TRIM_TAG value. 
                              Not stored if not set.  Default value: null.  Cannot be used in conjunction with
                              argument(s) LEGACY

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MISMATCH_RATE <Double>      What fraction of bases the matched sequence can mismatch.  Must be >=0 and <1.  In
                              contrast to MISMATCHES, this matcher will match the full sequence even if it is preceded
                              by something else in the read.  Default value: null.  Cannot be used in conjunction with
                              argument(s) MISMATCHES LEGACY

--MISMATCHES <Integer>        How many mismatches are acceptable in the sequence.  If neither MISMATCHES nor
                              MISMATCH_RATE is specified, default behavior is MISMATCHES=0  Default value: null.  Cannot
                              be used in conjunction with argument(s) MISMATCH_RATE

--NUM_BASES <Integer>         How many bases at the beginning of the sequence must match before trimming occurs. 
                              Default value: 0. 

--OUTPUT_SUMMARY <File>       The output summary statistics  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRIM_TAG <String>           The tag to set for trimmed reads.  This tags the first base to keep in the read.  6 would
                              mean to trim the first 5 bases.  Default value: ZS. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## dropseq_tools_PolyATrimmer

### Tool Description
Trims poly-A tails from SAM/BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
- **Homepage**: http://mccarrolllab.com/dropseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: PolyATrimmer [-m <jvm_heap_size>] [-v] program args...

-m <jvm_heap_size> : Heap size to allocate for the JVM.  Default: 4g.
-v                 : Echo final command line before executing.
-h                 : Print usage and exit.

Program options:
USAGE: PolyATrimmer [arguments]


Version:3.0.2


Required Arguments:

--INPUT,-I <File>             The input SAM or BAM file to analyze.  Required. 

--OUTPUT,-O <File>            The output BAM file  Required. 


Optional Arguments:

--ADAPTER <AdapterDescriptor> Symbolic & literal specification of adapter sequence.  This is a combination of fixed
                              bases to match,  and references to SAMRecord tag values.  E.g. '~XM^XCACGT' means 'RCed
                              value of XM tag' + 'value of XC tag' + 'ACGT'. Ideally this is at least as long as the
                              read (new trim algo)  Default value: ~XM~XC. 

--ADAPTER_TAG <String>        Tag in which length of adapter is stored.  Not set if adapter length==0.  Default: do not
                              store the tag.  Default value: null. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DUBIOUS_ADAPTER_MATCH_LENGTH <Integer>
                              If adapter match is at end of read, with fewer than this many bases matching the read, and
                              not enough poly A is found preceding it, then ignore the adapter match and try again from
                              the end of the read (new trim algo)  Default value: 6. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LENGTH_TAG <String>         Tag in which length of polyA is stored.  Not set if polyA length==0.  Default: do not
                              store the tag.  Default value: null. 

--MAX_ADAPTER_ERROR_RATE <Double>
                              Fraction of bases that can mismatch when looking for adapter match  (new trim algo) 
                              Default value: 0.1. 

--MAX_POLY_A_ERROR_RATE <Double>
                              When looking for poly A, allow this fraction of bases not to be A (new trim algo)  Default
                              value: 0.1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_ADAPTER_MATCH <Integer> Minimum number of bases for adapter match (new trim algo)  Default value: 4. 

--MIN_POLY_A_LENGTH <Integer> Minimum length of a poly A run, except when start of end of read intervenes (new trim
                              algo)  Default value: 20. 

--MIN_POLY_A_LENGTH_NO_ADAPTER_MATCH <Integer>
                              Minimum length of poly A run at end of read, if there is no adapter match (new trim algo) 
                              Default value: 6. 

--MISMATCHES <Integer>        How many mismatches are acceptable in the sequence (old trim algo).  Default value: 0. 

--NUM_BASES <Integer>         How many bases of polyA qualifies as a run of A's (old trim algo).  Default value: 6. 

--OUTPUT_SUMMARY <File>       The output summary statistics  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRIM_TAG <String>           The tag to set for trimmed reads.  This tags the first base to exclude in the read.  37
                              would mean to retain the first 36 bases.  Default value: ZP. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_NEW_TRIMMER,-NEW <Boolean>
                              The old polyA trimmer looks for the longest run of As that is at least NUM_BASES long and
                              has no more than MISMATCHES bases that are not A.  For the new polyA trimmer, it is
                              assumed that the polyA run either extends to the end of the read, or to the beginning of
                              adapter sequence at the end of the read.  If the entire read is adapter sequence, the
                              entire read is trimmed by setting all base qualities low. If adapter sequence was found,
                              the polyA run must be at least MIN_POLY_A_LENGTH long.  If no adapter sequence was found,
                              the polyA run must be at least MIN_POLY_A_LENGTH_NO_ADAPTER_MATCH long, on the assumption
                              that the polyA tail may extend beyond the end of the read.  The fraction of allowed non-A
                              bases in a polyA run must be <= MAX_POLY_A_ERROR_RATE.  Default value: false. Possible
                              values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## dropseq_tools_TagReadWithGeneFunction

### Tool Description
Tags reads that are exonic for the gene name of the overlapping exon. This is done specifically to solve the case where a read may be tagged with a gene and an exon, but the read may not be exonic for all genes tagged. This limits the list of genes to only those where the read overlaps the exon and the gene.Reads that overlap multiple genes are assigned to the gene that shares the strand with the read. If that assignment is ambiguous (2 or more genes share the strand of the read), then the read is not assigned any genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
- **Homepage**: http://mccarrolllab.com/dropseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: TagReadWithGeneFunction [-m <jvm_heap_size>] [-v] program args...

-m <jvm_heap_size> : Heap size to allocate for the JVM.  Default: 4g.
-v                 : Echo final command line before executing.
-h                 : Print usage and exit.

Program options:
USAGE: TagReadWithGeneFunction [arguments]

A special case tagger.  Tags reads that are exonic for the gene name of the overlapping exon.  This is done specifically
to solve the case where a readmay be tagged with a gene and an exon, but the read may not be exonic for all genes
tagged.  This limits the list of genes to only those where the read overlaps the exon and the gene.Reads that overlap
multiple genes are assigned to the gene that shares the strand with the read.  If that assignment is ambiguous (2 or
more genes share the strand of the read), then the read is not assigned any genes.
Version:3.0.2


Required Arguments:

--ANNOTATIONS_FILE <File>     The annotations set to use to label the read.  This can be a GTF or a refFlat file. 
                              Required. 

--INPUT,-I <File>             The input SAM or BAM file to analyze  Required. 

--OUTPUT,-O <File>            The output BAM, written with new Gene/Exon tag  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--GENE_FUNCTION_TAG <String>  Gene Function tag.  For a given gene name <GENE_NAME_TAG>, this is the function of the
                              gene at this read's position: UTR/CODING/INTRONIC/...  Default value: gf. 

--GENE_NAME_TAG <String>      Gene Name tag.  Takes on the gene name this read overlaps (if any)  Default value: gn. 

--GENE_STRAND_TAG <String>    Gene Strand tag.  For a given gene name <GENE_NAME_TAG>, this is the strand of the gene. 
                              Default value: gs. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--PCT_REQUIRED_OVERLAP <Double>
                              What fraction of the read must overlap a locus function to be included in the annotation. 
                              If this parameter is set to 0, then if anybases are overlap an annotation it is included
                              in the output.  StarSolo / CellRanger would set this to 50.0, then onlyfunctional
                              annotations with > 50% overlap would be included.  This forces a gene to have at most one
                              annotation (coding, intronic, etc) insteadof multiple annotations (coding + intronic). Set
                              to 0 to reproduce the DropSeq standard, or 50 to emulate StarSolo.  Default value: 0.0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_FUNCTION_TAG <String>  READ functional annotation tag.  For this read, what is the function?  This only looks at
                              reads on the right strand, and prioritizes coding over intron over intergenic.  There is
                              only 1 value for this tag.  Default value: XF. 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file.  Default value: null. 

--SUMMARY <File>              The strand specific summary info  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_STRAND_INFO <Boolean>   Use strand info to determine what gene to assign the read to.  If this is on, reads can be
                              assigned to a maximum one one gene.  This is used for the READ_FUNCTION_TAG output only. 
                              Default value: true. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: LENIENT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## dropseq_tools_DetectBeadSubstitutionErrors

### Tool Description
Collapses umambiguously related small barcodes into larger neighbors. Unambiguously related barcodes are situations where a smaller barcode only has 1 neighbor within the edit distance threshold, so the barcode can not be collapsed to the wrong neighbor. These sorts of errors can be due to problems with barcode synthesis. Ambiguous barcodes are situations where a smaller neighbor has multiple larger neighbors. These barcodes can be optionally filtered.

### Metadata
- **Docker Image**: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
- **Homepage**: http://mccarrolllab.com/dropseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: DetectBeadSubstitutionErrors [-m <jvm_heap_size>] [-v] program args...

-m <jvm_heap_size> : Heap size to allocate for the JVM.  Default: 4g.
-v                 : Echo final command line before executing.
-h                 : Print usage and exit.

Program options:
USAGE: DetectBeadSubstitutionErrors [arguments]

Collapses umambiguously related small barcodes into larger neighbors.  Unambiguously related barcodes are situations
where a smaller barcodeonly has 1 neighbor within the edit distance threshold, so the barcode can not be collapsed to
the wrong neighbor.  These sorts of errors can be due to problems with barcode synthesis.Ambiguous barcodes are
situations where a smaller neighbor has multiple larger neighbors.  These barcodes can be optionally filtered.)
Version:3.0.2


Required Arguments:

--INPUT,-I <File>             The input DropSeq BAM file to analyze  This argument must be specified at least once.
                              Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CELL_BARCODE_TAG <String>   The cell barcode tag.  Default value: XC. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EDIT_DISTANCE <Integer>     The edit distance to collapse barcodes  Default value: 1. 

--FILTER_AMBIGUOUS <Boolean>  Remove smaller barcodes that map at the edit distance to multiple larger barcodes. 
                              Default value: true. Possible values: {true, false} 

--FREQ_COMMON_SUBSTITUTION <Double>
                              Only repair substitution patterns that occur at a base as more than
                              <FREQ_COMMON_SUBSTITUTION> of the total changes.  We expect there to be a single dominant
                              barcode change [from say A->C at base 1] due to a synthesis error at that base.  In those
                              cases, we want to perform repair, but we don't want to arbitrarily combine barcodes
                              together.  Set this to 0 to combine everything...but testing has revealed that this will
                              combine barcodes capriciously so we don't recommend it!  Default value: 0.8. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_UMIS_PER_CELL <Integer> The minimum number of UMIs required to consider a cell barcode for collapse.  Setting this
                              number higher speeds up cleanup.  Very small barcodes will not contribute many UMIs, so
                              are not a useful return on investment.  Suggested values range from 20 to 200.  Default
                              value: 20. 

--MOLECULAR_BARCODE_TAG <String>
                              The molecular barcode tag.  Default value: XM. 

--NUM_THREADS <Integer>       Number of threads to use.  Defaults to 1.  Default value: 1. 

--OUT_CELL_BARCODE_TAG <String>
                              The output barcode tag for the newly collapsed barcodes.  Defaults to the CELL_BARCODE_TAG
                              if not set.  Default value: null. 

--OUTPUT,-O <File>            Output BAM file with cell barcodes collapsed.  Default value: null. 

--OUTPUT_REPORT <File>        Output report detailing which barcodes were merged, and what the position of the
                              substitution and intended/changed bases were for each pair of barcordes merged.  Default
                              value: null. 

--OUTPUT_SUMMARY <File>       Output the number of substitutions found at each base, from intended sequence to neighbor
                              sequence.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_MQ <Integer>           Read quality filter.  Filters all reads lower than this mapping quality.  Defaults to 10. 
                              Set to 0 to not filter reads by map quality.  Default value: 10. 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UMI_BIAS_BASE <Integer>     Which base to scan for UMI bias.  This is typically the last base of the UMI.  If set to
                              null, program will use the last base of the UMI.  Default value: null. 

--UMI_BIAS_THRESHOLD <Double> The amount of bias (all UMIs for a cell have the same base) at which a cell barcode is
                              considered biased?  Default value: 0.8. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## dropseq_tools_DigitalExpression

### Tool Description
Measures the digital expression of a library. Method: 1) For each gene, find the molecular barcodes on the exons of that gene. 2) Determine how many HQ mapped reads are assigned to each barcode. 3) Collapse barcodes by edit distance. 4) Throw away barcodes with less than threshold # of reads. 5) Count the number of remaining unique molecular barcodes for the gene.This program requires a tag for what gene a read is on, a molecular barcode tag, and a exon tag. The exon and gene tags may not be present on every read.When filtering the data for a set of barcodes to use, the data is filtered by ONE of the following methods (and if multiple params are filled in, the top one takes precedence):1) CELL_BC_FILE, to filter by the some fixed list of cell barcodes2) MIN_NUM_GENES_PER_CELL 3) MIN_NUM_TRANSCRIPTS_PER_CELL 4) NUM_CORE_BARCODES 5) MIN_NUM_READS_PER_CELL

### Metadata
- **Docker Image**: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
- **Homepage**: http://mccarrolllab.com/dropseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/dropseq_tools/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: DigitalExpression [-m <jvm_heap_size>] [-v] program args...

-m <jvm_heap_size> : Heap size to allocate for the JVM.  Default: 4g.
-v                 : Echo final command line before executing.
-h                 : Print usage and exit.

Program options:
USAGE: DigitalExpression [arguments]

Measures the digital expression of a library.  Method: 1) For each gene, find the molecular barcodes on the exons of
that gene.  2) Determine how many HQ mapped reads are assigned to each barcode.  3) Collapse barcodes by edit distance. 
4) Throw away barcodes with less than threshold # of reads. 5) Count the number of remaining unique molecular barcodes
for the gene.This program requires a tag for what gene a read is on, a molecular barcode tag, and a exon tag.  The exon
and gene tags may not be present on every read.When filtering the data for a set of barcodes to use, the data is
filtered by ONE of the following methods (and if multiple params are filled in, the top one takes precedence):1)
CELL_BC_FILE, to filter by the some fixed list of cell barcodes2) MIN_NUM_GENES_PER_CELL 3) MIN_NUM_TRANSCRIPTS_PER_CELL
4) NUM_CORE_BARCODES 5) MIN_NUM_READS_PER_CELL
Version:3.0.2


Required Arguments:

--INPUT,-I <File>             The input SAM or BAM file to analyze.  Required. 

--OUTPUT,-O <File>            Output file of DGE Matrix.  Genes are in rows, cells in columns.  The first column
                              contains the gene name. This supports zipped formats like gz and bz2.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CELL_BARCODE_TAG <String>   The cell barcode tag.  If there are no reads with this tag, the program will assume that
                              all reads belong to the same cell and process in single sample mode.  Default value: XC. 

--CELL_BC_FILE <File>         Override CELL_BARCODE and MIN_NUM_READS_PER_CELL, and process reads that have the cell
                              barcodes in this file instead.  The file has 1 column with no header.  Default value:
                              null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EDIT_DISTANCE <Integer>     The edit distance that molecular barcodes should be combined at within a gene.  Default
                              value: 1. 

--FUNCTIONAL_STRATEGY <FunctionalDataProcessorStrategy>
                              A strategy for interpreting functional annotations.  DropSeq is the default strategy. 
                              STARSOLO strategy priority is very similar to DropSeq, exceptin cases where a read
                              overlaps both an intron on the sense strand and a coding region on the antisense strand. 
                              In these cases, DropSeq favors the intronic interpretation, while STARSolo interprets this
                              as a technical artifact and labels the read as coming from the antisense coding gene, and
                              the read does not contribute to the expression counts matrix.  Default value: DROPSEQ.
                              Possible values: {DROPSEQ, STARSOLO} 

--GENE_FUNCTION_TAG <String>  Gene Function tag.  For a given gene name <GENE_NAME_TAG>, this is the function of the
                              gene at this read's position: UTR/CODING/INTRONIC/...  Default value: gf. 

--GENE_NAME_TAG <String>      Gene Name tag.  Takes on the gene name this read overlaps (if any)  Default value: gn. 

--GENE_STRAND_TAG <String>    Gene Strand tag.  For a given gene name <GENE_NAME_TAG>, this is the strand of the gene. 
                              Default value: gs. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LOCUS_FUNCTION_LIST <LocusFunction>
                              A list of functional annotations that reads need to be completely contained by to be
                              considered for analysis.  This argument may be specified 0 or more times. Default value:
                              [CODING, UTR]. Possible values: {INTERGENIC, INTRONIC, UTR, CODING, RIBOSOMAL} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_BC_READ_THRESHOLD <Integer>
                              The minimum number of reads a molecular barcode should have to be considered.  This is
                              done AFTER edit distance collapse of barcodes.  Default value: 0. 

--MIN_NUM_GENES_PER_CELL <Integer>
                              The minumum number of genes for a cell barcode to be reported.  Default value: null. 

--MIN_NUM_READS_PER_CELL <Integer>
                              Gather up all cell barcodes that have more than some number of reads.  Default value:
                              null. 

--MIN_NUM_TRANSCRIPTS_PER_CELL <Integer>
                              The minumum number of transcripts for a cell barcode to be reported.  Default value: null.

--MIN_SUM_EXPRESSION <Integer>Output only genes with at least this total expression level, after summing across all
                              cells  Default value: null. 

--MOLECULAR_BARCODE_TAG <String>
                              The molecular barcode tag.  Default value: XM. 

--NUM_CORE_BARCODES <Integer> Number of cells that you think are in the library.  The largest <X> barcodes are used. 
                              Default value: null. 

--OMIT_MISSING_CELLS <Boolean>When using CELL_BC_FILE, do not emit a column for a cell barcode that appears in
                              CELL_BC_FILE if it does not appear in the input BAM.  Default value: false. Possible
                              values: {true, false} 

--OUTPUT_HEADER,-H <Boolean>  If true, write a header in the DGE file.  If not specified, and UEI is specified, it is
                              set to true.  REFERENCE_SEQUENCE only used to write to header.  If it is not present, it
                              is extracted from INPUT header if possible.  Default value: null. Possible values: {true,
                              false} 

--OUTPUT_LONG_FORMAT <File>   An alternate output of expression where each row represents a cell, gene, and count of
                              UMIs.  Cell/Gene pairings with 0 UMIs are not emitted.  Default value: null. 

--OUTPUT_READS_INSTEAD <Boolean>
                              Output number of reads instead of number of unique molecular barcodes.  Default value:
                              false. Possible values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RARE_UMI_FILTER_THRESHOLD <Double>
                              Drop UMIs within a cell/gene pair that occur less than the average number of
                              reads*<FILTER_FREQ> for all UMIs in the cell/gene pair.  For example, if you had on
                              average 1000 reads per UMI and a UMI with 1-10 reads, those small UMIs would be removed
                              when this frequency was set to 0.01.This is off by default.  A sensible value might be
                              0.01.  Default value: 0.0. 

--READ_MQ <Integer>           The map quality of the read to be included.  Experimental: While the default map quality
                              is 10 (uniquereads), lower map quality can now be set to recover reads that map to
                              multiple places in the genome.  This mirrors STARsolo's approach, where all mapping
                              positions for a read are considered, and the read is includedin downstream analysis if the
                              read maps consistently to a single gene given all other thresholds (functional
                              annotations, strand).  To reproduce STARSolo's expression output of these reads, set this
                              value to 0 to include all reads.  Default value: 10. 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file.  Default value: null. 

--STRAND_STRATEGY <StrandStrategy>
                              The strand strategy decides which reads will be used by analysis.  The SENSE strategy
                              requires the read and annotation to have the same strand.  The ANTISENSE strategy requires
                              the read and annotation to be on opposite strands.  The BOTH strategy is permissive, and
                              allows the read to be on either strand.  Default value: SENSE. Possible values: {SENSE,
                              ANTISENSE, BOTH} 

--SUMMARY <File>              A summary of the digital expression output, containing 3 columns - the cell barcode, the
                              #genes, and the #transcripts.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNIQUE_EXPERIMENT_ID,-UEI <String>
                              If OUTPUT_HEADER=true, this is required  Default value: null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## Metadata
- **Skill**: generated
