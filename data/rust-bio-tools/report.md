# rust-bio-tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rust-bio-tools_bam-anonymize | Failed | tool bug: without --keep-only-pairs it writes a corrupt BAM when a read's mate maps to another contig (samtools stops at that record); with --keep-only-pairs the output is valid. |
| rust-bio-tools_bam-depth | PASS |  |
| rust-bio-tools_collapse-reads-to-fragments_bam | PASS |  |
| rust-bio-tools_collapse-reads-to-fragments_fastq | PASS |  |
| rust-bio-tools_csv-report | PASS |  |
| rust-bio-tools_fastq-filter | PASS |  |
| rust-bio-tools_fastq-split | PASS |  |
| rust-bio-tools_plot-bam | PASS |  |
| rust-bio-tools_sequence-stats | PASS |  |
| rust-bio-tools_vcf-annotate-dgidb | Failed | external service gone: the DGIdb v2 JSON API now returns an HTML page, so rbt stops with 'expected value at line 1 column 1'. |
| rust-bio-tools_vcf-baf | PASS |  |
| rust-bio-tools_vcf-fix-iupac-alleles | PASS |  |
| rust-bio-tools_vcf-match | PASS |  |
| rust-bio-tools_vcf-report | PASS |  |
| rust-bio-tools_vcf-split | PASS |  |
| rust-bio-tools_vcf-to-txt | PASS |  |

## rust-bio-tools_bam-anonymize

### Tool Description
Tool to build artifical reads from real BAM files with identical properties

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Total Downloads**: 312.7K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/rust-bio/rust-bio-tools
- **Stars**: N/A
### Original Help Text
```text
rbt-bam-anonymize 0.42.2
Felix Mölder <felix.moelder@uni-due.de>
Tool to build artifical reads from real BAM files with identical properties

USAGE:
    rbt bam-anonymize [FLAGS] <bam> <input-ref> <output-bam> <output-ref> <chr> <start> <end>

FLAGS:
    -h, --help               Prints help information
    -p, --keep-only-pairs    Only simulates reads whos mates are both in defined range.
    -V, --version            Prints version information

ARGS:
    <bam>           Input BAM file
    <input-ref>     Input reference as fasta file
    <output-bam>    Output BAM file with artificial reads
    <output-ref>    Output fasta file with artificial reference
    <chr>           chromosome name
    <start>         1-based start position
    <end>           1-based exclusive end position
```

## rust-bio-tools_csv-report

### Tool Description
Creates report from a given csv file containing a table with the given data

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-csv-report 0.42.2
Felix Wiegand <felix.wiegand@tu-dortmund.de>
Creates report from a given csv file containing a table with the given data Examples: With current directory as default
ouput path: rbt csv-report path/to/table.csv --rows-per-page 100 --sort-column "p-value" --sort-order ascending

USAGE:
    rbt csv-report [OPTIONS] <csv-path> [output-path]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -f, --formatter <formatter>            Configure a custom formatter function for each column by providing a file
                                           containing a javascript object with csv column title as the key and a format
                                           function as the value. More information on the formatting functions and how
                                           to use them here: https://bootstrap-table.com/docs/api/column-
                                           options/#formatter
    -p, --pin-until <pin-until>            Pins the table until the given column such that scrolling to the right does
                                           not hide the given column and those before
    -r, --rows-per-page <rows-per-page>    Sets the numbers of rows of each table per page. Default is 100 [default:
                                           100]
    -s, --separator <separator>            Change the separator of the csv file to tab or anything else. Default is ","
                                           [default: ,]
    -c, --sort-column <sort-column>        Column that the data should be sorted by
    -o, --sort-order <sort-order>          Order the data ascending or descending. Default is descending [default:
                                           descending]  [possible values: ascending, descending]

ARGS:
    <csv-path>       CSV file including the data for the report
    <output-path>    Relative output path for the report files. Default value is the current directory [default: .]
```

## rust-bio-tools_fastq-filter

### Tool Description
Remove records from a FASTQ file (from STDIN), output to STDOUT.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-fastq-filter 0.42.2
Erik Clarke <ecl@pennmedicine.upenn.edu>
Remove records from a FASTQ file (from STDIN), output to STDOUT.

Example: rbt fastq-filter ids.txt < test.fastq > filtered.fastq

USAGE:
    rbt fastq-filter <ids>

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

ARGS:
    <ids>    
            File with list of record IDs to remove, one per line
```

## rust-bio-tools_plot-bam

### Tool Description
Creates a html file with a vega visualization of the given bam region that is then written to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-plot-bam 0.42.2
Felix Wiegand <felix.wiegand@tu-dortmund.de>
Creates a html file with a vega visualization of the given bam region that is then written to stdout.

EXAMPLE:
    rbt plot-bam -b input.bam -g 2:132424-132924 -r input.fa > plot.html

USAGE:
    rbt plot-bam [OPTIONS] --bam-path <bam-path>... --reference <reference> --region <region> > plot.html

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

OPTIONS:
    -b, --bam-path <bam-path>...             
            BAM file to be visualized

    -d, --max-read-depth <max-read-depth>    
            Set the maximum rows that will be shown in the alignment plots [default: 500]

    -r, --reference <reference>              
            Path to the reference fasta file

    -g, --region <region>                    
            Chromosome and region for the visualization. Example: 2:132424-132924
```

## rust-bio-tools_sequence-stats

### Tool Description
Tool to compute stats on sequence file (from STDIN), output is in YAML with fields: min, max, average, median, nb_reads, nb_bases, n50.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-sequence-stats 0.42.2
Pierre Marijon <pmarijon@mpi-inf.mpg.de>
Tool to compute stats on sequence file (from STDIN), output is in YAML with fields: - min: length of shortest sequence -
max: length of longest sequence - average: average length of sequence - median: median length of sequence - nb_reads:
number of reads - nb_bases: number of bases - n50: N50 of sequences

Example: rbt sequence-stats < test.fasta rbt sequence-stats -q < test.fastq

USAGE:
    rbt sequence-stats [FLAGS]

FLAGS:
    -q, --fastq      
            Flag to indicate the sequence in stdin is in fastq format.

    -h, --help       
            Prints help information

    -V, --version    
            Prints version information
```

## rust-bio-tools_vcf-annotate-dgidb

### Tool Description
Looks for interacting drugs in DGIdb and annotates them for every gene in every record.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-annotate-dgidb 0.42.2
Felix Mölder <felix.moelder@uni-due.de>
Looks for interacting drugs in DGIdb and annotates them for every gene in every record.

Example: rbt vcf-annotate-dgidb input.vcf > output.vcf

USAGE:
    rbt vcf-annotate-dgidb [OPTIONS] <vcf>

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

OPTIONS:
    -p, --api-path <api-path>
            Url prefix for requesting interaction drugs by gene names [default:
            https://dgidb.org/api/v2/interactions.json?genes=]
    -s, --datasources <STR>...
            A list of data sources included in query. If omitted all sources are considered. A list of all sources can
            be found at http://dgidb.org/api/v2/interaction_sources.json
    -f, --field <field>                            
            Info field name to be used for annotation [default: dgiDB_drugs]

    -g, --genes-per-request <genes-per-request>
            Number of genes to submit per api request. A lower value increases the number of api requests in return. Too
            many requests could be rejected by the DGIdb server [default: 500]

ARGS:
    <vcf>    
            VCF/BCF file to be extended by dgidb drug entries
```

## rust-bio-tools_vcf-baf

### Tool Description
Annotate b-allele frequency for each single nucleotide variant and sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-baf 0.42.2
Johannes Köster <johannes.koester@uni-due.de>, Jan Forster <j.forster@dkfz.de>
Annotate b-allele frequency for each single nucleotide variant and sample.

Example: rbt vcf-baf < calls.bcf > annotated.bcf

USAGE:
    rbt vcf-baf

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information
```

## rust-bio-tools_vcf-match

### Tool Description
Annotate for each variant in a VCF/BCF at STDIN whether it is contained in a given second VCF/BCF. The matching is fuzzy for indels and exact for SNVs. Results are printed as BCF to STDOUT, with an additional INFO tag MATCHING. The two vcfs do not have to be sorted.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-match 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
Annotate for each variant in a VCF/BCF at STDIN whether it is contained in a given second VCF/BCF. The matching is fuzzy
for indels and exact for SNVs. Results are printed as BCF to STDOUT, with an additional INFO tag MATCHING. The two vcfs
do not have to be sorted.

Example: rbt vcf-match dbsnp.vcf < calls.vcf | bcftools view

USAGE:
    rbt vcf-match [OPTIONS] <vcf>

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

OPTIONS:
    -d, --max-dist <INT>        
            Maximum distance between centres of two indels considered to match [default: 20]

    -l, --max-len-diff <INT>    
            Maximum difference between lengths of two indels [default: 10]

ARGS:
    <vcf>    
            VCF/BCF file to match against
```

## rust-bio-tools_vcf-report

### Tool Description
Creates report from a given VCF file including a visual plot for every variant with the given BAM and FASTA file. The VCF file has to be annotated with VEP, using the options --hgvs and --hgvsg.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-report 0.42.2
Johannes Köster <johannes.koester@uni-due.de>, Felix Wiegand <felix.wiegand@tu-dortmund.de>
Creates report from a given VCF file including a visual plot for every variant with the given BAM and FASTA file. The
VCF file has to be annotated with VEP, using the options --hgvs and --hgvsg.

Examples: With current directory as default ouput path: rbt vcf-report fasta.fa --vcfs a=a.vcf b=b.vcf --bams
a:sample1=a.bam b:sample1=b.bam With custom directory as default ouput path: rbt vcf-report fasta.fa --vcfs a=a.vcf
b=b.vcf --bams a:sample1=a.bam b:sample1=b.bam -- my/output/path/ With custom info tags in table report: rbt vcf-report
fasta.fa --vcfs a=a.vcf b=b.vcf --bams a:sample1=a.bam b:sample1=b.bam --info PROB_SOMATIC PROB_GERMLINE

USAGE:
    rbt vcf-report [OPTIONS] <fasta> [--] [output-path]

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

OPTIONS:
    -a, --annotation-field <annotation-field>    
            Set the name of the annotation field generated by VEP [default: ANN]

    -b, --bams <GROUP:SAMPLE=BAM_FILE>...
            VCF files to include (multi-sample). Group is the name that will be used in the oncoprint. There needs to be
            one corresponding BAM file for each sample of a VCF/BCF file. Please only use VCF/BCF files annotated by VEP
    -c, --cells <cells>
            Set the maximum number of cells in the oncoprint per page. Lowering max-cells should improve the performance
            of the plots in the browser. Default value is 1000 [default: 1000]
    -l, --custom-js-files <JS_FILE_PATH>...
            Add one or multiple js file (e.g. libraries) for usage in the custom-js-file. The ordering of the arguments
            will be the same as they will be imported
    -j, --custom-js-template <JS_FILE_PATH>
            Change the default javascript file for the table-report to a custom one to add own plots or tables to the
            sidebar by appending these to an empty div in the HTML template
    -f, --formats <FORMAT_TAG>...
            Add custom values from the format field to each variant as a data attribute to access them via the custom
            javascript. All given format values will also be inserted into the main table
    -i, --infos <INFO_TAG>...
            Add custom values from the info field to each variant as a data attribute to access them via the custom
            javascript. Multiple fields starting with the same prefix can be added by placing '*' at the end of a prefix
    -d, --max-read-depth <max-read-depth>
            Set the maximum lines of reads that will be shown in the alignment plots. Default value is 500 [default:
            500]
        --plot-info <PLOT_INFO>...
            Add multiple keys from the info field of your vcf to the plots of the first and second stage of the report

        --threads <threads>                      
            Sets the number of threads used to build the table reports [default: 0]

    -t, --tsv <TSV_FILE_PATH>
            Add a TSV file that contains one or multiple custom values for each sample for the oncoprint. First column
            has to be the sample name, followed by one or more columns with custom values. Make sure you include one row
            for each given sample
    -v, --vcfs <GROUP=VCF_FILE>...
            VCF files to include (multi-sample). Group is the name that will be used in the oncoprint. There needs to be
            one corresponding BAM file for each sample of a VCF/BCF file. Please only use VCF/BCF files annotated by VEP

ARGS:
    <fasta>          
            FASTA file containing the reference genome for the visual plot

    <output-path>    
            Relative output path for the report files. Default value is the current directory [default: .]
```

## rust-bio-tools_vcf-split

### Tool Description
Split a given VCF/BCF file into N chunks of approximately the same size. Breakends are kept together. Output type is always BCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-split 0.42.2
Johannes Köster <johannes.koester@uni-due.de>
Split a given VCF/BCF file into N chunks of approximately the same size. Breakends are kept together. Output type is
always BCF.

Example: rbt vcf-split input.bcf output1.bcf output2.bcf output3.bcf ... outputN.bcf

USAGE:
    rbt vcf-split <input> [output]...

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

ARGS:
    <input>        
            Input VCF/BCF that shall be splitted.

    <output>...    
            BCF files to split into. Breakends are kept together. Each file will contain approximately the same number
            of records.
```

## rust-bio-tools_vcf-to-txt

### Tool Description
Convert VCF/BCF file from STDIN to tab-separated TXT file at STDOUT. INFO and FORMAT tags have to be selected explicitly.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-to-txt 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
Convert VCF/BCF file from STDIN to tab-separated TXT file at STDOUT. INFO and FORMAT tags have to be selected
explicitly.

Example: rbt vcf-to-txt --genotypes --fmt S --info T X SOMATIC < test.vcf > variant-table.txt

The resulting table can be e.g. parsed with PANDAS in Python:

pd.read_table("variants.txt", header=[0, 1])

USAGE:
    rbt vcf-to-txt [FLAGS] [OPTIONS]

FLAGS:
    -g, --genotypes      
            Display genotypes

    -h, --help           
            Prints help information

    -V, --version        
            Prints version information

        --with-filter    
            Include FILTER field

OPTIONS:
    -f, --fmt <NAME>...     
            Select FORMAT tags

    -i, --info <NAME>...    
            Select INFO tags
```

## rust-bio-tools_bam-depth

### Tool Description
Print depth of BAM or CRAM file at given positions from STDIN (tab separated: chrom, pos)

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-bam-depth 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
Print depth of BAM or CRAM file at given positions from STDIN (tab separated: chrom, pos).

Usage: $ rbt bam-depth test.bam < pos.txt > depth.txt

The positions file contains the name of one reference sequence and one position per line (tab separated). Example:

16    1 17    38 17    39

Depths are written to stdout as tab-separated lines, similar to the positions input. Example:

16    1    0 17    38    14 17    39    13

USAGE:
    rbt bam-depth [OPTIONS] <bam-path>

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information


OPTIONS:
    -e, --excl-flags <exclude-flags>           
            Skip reads with mask bits set [UNMAP, SECONDARY, QCFAIL, DUP] [default: 1796]

    -i, --incl-flags <include-flags>           
            Skip reads with mask bits unset [] [default: 0]

    -m, --max-read-length <max-read-length>    
            Maximum read length to consider. This affects the speed of the involved pileup. Reads longer than this
            length can be missed when calculating the depth [default: 1000]
    -q, --min-mapq <min-mapq>                  
            Minimum mapping quality [default: 0]


ARGS:
    <bam-path>    
            Path to indexed BAM file
```

## rust-bio-tools_fastq-split

### Tool Description
Split FASTQ file from STDIN into N chunks

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-fastq-split 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
Split FASTQ file from STDIN into N chunks.

Example: rbt fastq-split A.fastq B.fastq < test.fastq

USAGE:
    rbt fastq-split [chunks]...

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <chunks>...    File name(s) for the chunks to create.
```

## rust-bio-tools_vcf-fix-iupac-alleles

### Tool Description
Convert any IUPAC codes in alleles into Ns (in order to comply with VCF 4 specs)

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-vcf-fix-iupac-alleles 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
Convert any IUPAC codes in alleles into Ns (in order to comply with VCF 4 specs). Reads VCF/BCF from STDIN and writes
BCF to STDOUT.

Example: rbt vcf-fix-iupac-alleles < test.vcf > fixed.bcf

USAGE:
    rbt vcf-fix-iupac-alleles

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
```

## rust-bio-tools_collapse-reads-to-fragments_bam

### Tool Description
Tool to merge sets of PCR duplicate reads from a BAM file into one maximum likelihood fragment sequence each with accordingly improved base quality scores

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-collapse-reads-to-fragments-bam 0.42.2
Felix Mölder <felix.moelder@uni-due.de>
Tool to merge sets of PCR duplicate reads from a BAM file into one maximum likelihood fragment sequence each with
accordingly improved base quality scores.

Takes a BAM file and returns a BAM file in which all PCR duplicates have been merged into a consensus read. Duplicates
must be marked by Picard Tools using the TAG_DUPLICATE_SET_MEMBERS option.

Assumptions: - Reads are of equal length - Reads are marked by Picard Tools

USAGE:
    rbt collapse-reads-to-fragments bam [FLAGS] <bam> <consensus-fq1> <consensus-fq2> <consensus-fq-se> <skipped-bam>

FLAGS:
        --annotate-record-ids    Add list of reads that were merged for each consensus read. Note that this can yield
                                 very long FASTQ name lines which cannot be handled by some tools.
    -h, --help                   Prints help information
    -V, --version                Prints version information

ARGS:
    <bam>                Input BAM file with marked duplicates
    <consensus-fq1>      Output FASTQ file with forward reads
    <consensus-fq2>      Output FASTQ file with reverse reads
    <consensus-fq-se>    Output FASTQ file for overlapping consensus reads.
    <skipped-bam>        Output FASTQ file for overlapping consensus reads.
```

## rust-bio-tools_collapse-reads-to-fragments_fastq

### Tool Description
Tool to merge sets of reads from paired FASTQ files that share the UMI and have similar read sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

### Original Help Text
```text
rbt-collapse-reads-to-fragments-fastq 0.42.2
Johannes Köster <johannes.koester@uni-due.de>, Henning Timm <henning.timm@tu-dortmund.de>, Felix Mölder
<felix.moelder@uni-due.de>
Tool to merge sets of reads from paired FASTQ files that share the UMI and have similar read sequence. The result is a
maximum likelihood fragment sequence per set with base quality scores improved accordingly.

Takes two FASTQ files (forward and reverse) and returns two FASTQ files in which all PCR duplicates have been merged
into a consensus read. Duplicates are identified by a Unique Molecular Identifier (UMI).

Assumptions: - Reads are of equal length - UMI is the prefix of the reads

Example: rbt collapse-reads-to-fragments fastq \ reads_1.fq reads_2.fq \    # input files merged_1.fq merged_2.fq \  #
output files -l 13 \                    # length of UMI -d 1 \                     # max hamming distance of UMIs within
a cluster -D 2 \                     # max hamming distance of sequences within a cluster --umi-on-reverse           #
UMI is the prefix of the reverse read

USAGE:
    rbt collapse-reads-to-fragments fastq [FLAGS] [OPTIONS] <fq1> <fq2> <consensus-fq1> <consensus-fq2> [consensus-fq3]

FLAGS:
    -h, --help                  Prints help information
    -u, --umi-on-reverse        Set if UMI is on reverse read
    -V, --version               Prints version information
        --verbose-read-names    Add list of reads that were merged for each consensus read. Note that this can yield
                                very long FASTQ name lines which cannot be handled by some tools.

OPTIONS:
    -i, --insert-size <insert-size>      Expected insert size of sequenced fragment (Required for calculating
                                         overlapping consensus only)
    -D, --max-seq-dist <max-seq-dist>    Maximum hamming distance between the sequences of any pair of reads in the same
                                         cluster. [default: 2]  [possible values: 1, 2, 3, 4, 5, 6, 7, 8]
    -d, --max-umi-dist <max-umi-dist>    Maximum hamming distance between the UMIs of any pair of reads in the same
                                         cluster. [default: 1]
    -s, --std-dev <std-dev>              Standard deviation of expected insert size. Defines search space of the most
                                         likely overlap. (Required for calculating overlapping consensus only)
    -l, --umi-len <umi-len>              Length of UMI in read. [default: 8]

ARGS:
    <fq1>              Input FASTQ file with forward reads.
    <fq2>              Input FASTQ file with reverse reads.
    <consensus-fq1>    Output FASTQ file with forward reads
    <consensus-fq2>    Output FASTQ file with reverse reads
    <consensus-fq3>    Output FASTQ file for overlapping consensus reads  (Required for calculating overlapping
                       consensus only)
```

## Metadata
- **Skill**: generated
