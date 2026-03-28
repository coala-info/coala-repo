# pycrac CWL Generation Report

## pycrac_pyBarcodeFilter.py

### Tool Description
Filters FASTQ/FASTA files based on barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
- **Homepage**: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pycrac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycrac/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: pyBarcodeFilter.py [options] -f filename -b barcode_list

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -f FILE, --input_file=FILE
                        name of the FASTQ or FASTA input file
  -r FILE, --reverse_input_file=FILE
                        name of the paired (or reverse) FASTQ or FASTA input
                        file
  --file_type=FASTQ     type of file, uncompressed (fasta or fastq) or
                        compressed (fasta.gz or fastq.gz, gzip/gunzip
                        compressed). Default is fastq
  -b FILE, --barcode_list=FILE
                        name of tab-delimited file containing barcodes and
                        barcode names
  -k, --keep_barcode    in case you do not want to remove the in read barcode
                        from the sequences. Useful when uploading data to
                        repositories.
  -v, --verbose         prints all the status messages to a file rather than
                        the standard output.
  --search=SEARCH       use this flag if barcode sequences need to be removed
                        from the forward or the reverse reads. The tool
                        assumes. Default=forward
  -m 1, --mismatches=1  to set the number of allowed mismatches in a barcode.
                        Only one mismatch is allowed. Default = 0
  -i, --index           use this option if you want to split the data using
                        the Illumina indexing barcode information
  --gz, --gzip          use this option to compress all the output files using
                        gunzip or gzip (compression level 9). Note that this
                        can significantly slow down the program
```


## pycrac_pyReadAligner.py

### Tool Description
Aligns reads to genomic or coding sequences, with options for various input file types and analysis parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
- **Homepage**: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pycrac/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyReadAligner.py [options] -f filename -g gene_list

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit

  File input options:
    -f FILE, --input_file=FILE
                        As input files you can use Novoalign native output or
                        SAM files as input file. By default it expects data
                        from the standard input. Make sure to specify the file
                        type of the file you want to have analyzed using the
                        --file_type option!
    -o OUTPUT_FILE, --output_file=OUTPUT_FILE
                        Use this flag to override the standard output file
                        names. All alignments will be written to one output
                        file.
    -g FILE, --genes_file=FILE
                        here you need to type in the name of your gene list
                        file (1 column) or the hittable file
    --chr=FILE          if you simply would like to align reads against a
                        genomic sequence you should generate a tab delimited
                        file containing an identifyer, chromosome name, start
                        position, end position and strand ('-' or '+')
    --gtf=annotation_file.gtf
                        type the path to the gtf annotation file that you want
                        to use
    --tab=tab_file.tab  type the path to the tab file that contains the
                        genomic reference sequence
    --file_type=FILE_TYPE
                        use this option to specify the file type (i.e. 'novo',
                        'sam', 'gtf'). This will tell the program which
                        parsers to use for processing the files. Default =
                        'novo'

  pyReadAligner specific options:
    --limit=500         with this option you can select how many reads mapped
                        to a particular gene/ORF/region you want to count.
                        Default = All

  Common options:
    -v, --verbose       prints all the status messages to a file rather than
                        the standard output
    --ignorestrand      this flag tells the program to ignore strand
                        information and all overlapping reads will considered
                        sense reads. Useful for analysing ChIP or RIP data
    --zip=FILE          use this option to compress all the output files in a
                        single zip file
    --overlap=1         sets the number of nucleotides a read has to overlap
                        with a gene before it is considered a hit. Default =
                        1 nucleotide
    -s genomic, --sequence=genomic
                        with this option you can select whether you want the
                        reads aligned to the genomic or the coding sequence.
                        Default = genomic
    -r 100, --range=100
                        allows you to set the length of the UTR regions. If
                        you set '-r 50' or '--range=50', then the program will
                        set a fixed length (50 bp) regardless of whether the
                        GTF file has genes with annotated UTRs.

  Options for novo, SAM and BAM files:
    --align_quality=100, --mapping_quality=100
                        with these options you can set the alignment quality
                        (Novoalign) or mapping quality (SAM) threshold. Reads
                        with qualities lower than the threshold will be
                        ignored. Default = 0
    --align_score=100   with this option you can set the alignment score
                        threshold. Reads with alignment scores lower than the
                        threshold will be ignored. Default = 0
    -l 100, --length=100
                        to set read length threshold. Default = 1000
    -m 100000, --max=100000
                        maximum number of mapped reads that will be analyzed.
                        Default = All
    --unique            with this option reads with multiple alignment
                        locations will be removed. Default = Off
    --blocks            with this option reads with the same start and end
                        coordinates on a chromosome will only be counted once.
                        Default = Off
    --discarded=FILE    prints the lines from the alignments file that were
                        discarded by the parsers. This file contains reads
                        that were unmapped (NM), of poor quality (i.e. QC) or
                        paired reads that were mapped to different chromosomal
                        locations or were too far apart on the same
                        chromosome. Useful for debugging purposes
    -d 1000, --distance=1000
                        this option allows you to set the maximum number of
                        base-pairs allowed between two non-overlapping paired
                        reads. Default = 1000
    --mutations=delsonly
                        Use this option to only track mutations that are of
                        interest. For CRAC data this is usually deletions
                        (--mutations=delsonly). For PAR-CLIP data this is
                        usually T-C mutations (--mutations=TC). Other options
                        are: do not report any mutations: --mutations=nomuts.
                        Only report specific base mutations, for example only
                        in T's, C's and G's :--mutations=[TCG]. The brackets
                        are essential. Other nucleotide combinations are also
                        possible
```


## pycrac_pyReadCounters.py

### Tool Description
Analyze novo, SAM/BAM or gtf data

### Metadata
- **Docker Image**: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
- **Homepage**: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pycrac/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyReadCounters.py [options] -f filename

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit

  File input options:
    -f FILE, --input_file=FILE
                        provide the path to your novo, SAM/BAM or gtf data
                        file. Default is standard input. Make sure to specify
                        the file type of the file you want to have analyzed
                        using the --file_type option!
    -o OUTPUT_FILE, --output_file=OUTPUT_FILE
                        Use this flag to override the standard file names. Do
                        NOT add an extension.
    --file_type=FILE_TYPE
                        use this option to specify the file type (i.e.
                        'novo','sam' or 'gtf'). This will tell the program
                        which parsers to use for processing the files. Default
                        = 'novo'
    --gtf=annotation_file.gtf
                        type the path to the gtf annotation file that you want
                        to use

  Common pyCRAC options:
    -a protein_coding, --annotation=protein_coding
                        select which annotation (i.e. protein_coding, ncRNA,
                        sRNA, rRNA, tRNA, snoRNA) you would like to focus your
                        search on. Default = all.
    -v, --verbose       prints all the status messages to a file rather than
                        the standard output
    --ignorestrand      To ignore strand information and all reads overlapping
                        with genomic features will be considered sense reads.
                        Useful for analysing ChIP or RIP data
    --overlap=1         sets the number of nucleotides a read has to overlap
                        with a gene before it is considered a hit. Default =
                        1 nucleotide
    -r 100, --range=100
                        allows you to add regions flanking the genomic
                        feature. If you set '-r 50' or '--range=50', then the
                        program will add 50 nucleotides to each feature on
                        each side regardless of whether the GTF file has genes
                        with annotated UTRs.
    --rpkm              to include a column showing reads per kilobase per 1
                        million mapped reads for each gene. Default is False.
    --nucdensities      With this flag nucleotide densities are calculated
                        (i.e. the total number of nucleotides overlapping with
                        a feature). Default is False.
    --properpairs       In case you have paired-end data, you can use this
                        flag to analyze only properly paired reads. Default is
                        False
    --sense             this option instructs pyReadCounters to only consider
                        reads overlapping sense with genomic features. Default
                        is False
    --anti_sense        this option instructs pyReadCounters to only consider
                        reads overlapping anti-sense with genomic features.
                        Default is False

  Options for SAM/BAM and Novo files:
    --force_single_end  To consider all reads unpaired, even if it is paired
                        end data.Default is False.
    --hittable          use this flag if you only want to print a hit table
                        for your data
    --gtffile           use this flag if you only want to print the
                        pyReadCounters gtf file for your data
    --stats             use this flag if you only want to print a the
                        statistics showing the complexity of your data
    -s intron, --sequence=intron
                        with this option you can select whether you want to
                        count reads overlapping coding or genomic sequence or
                        intron, exon, CDS, 5UTR or 3UTR coordinates. Default =
                        genomic.
    --mutations=delsonly
                        Use this option to only track mutations that are of
                        interest. For CRAC data this is usually deletions
                        (--mutations=delsonly). For PAR-CLIP data this is
                        usually T-C mutations (--mutations=TC). Other options
                        are: do not report any mutations: --mutations=nomuts.
                        Only report specific base mutations, for example only
                        in T's, C's and G's :--mutations=[TCG]. The brackets
                        are essential. Other nucleotide combinations are also
                        possible
    --align_quality=100, --mapping_quality=100
                        with these options you can set the alignment quality
                        (Novoalign) or mapping quality (SAM) threshold. Reads
                        with qualities lower than the threshold will be
                        ignored. Default = 0
    --align_score=100   with this option you can set the alignment score
                        threshold. Reads with alignment scores lower than the
                        threshold will be ignored. Default = 0
    --unique            with this option reads with multiple alignment
                        locations will be removed. Default = Off
    --blocks            with this option reads with the same start and end
                        coordinates on a chromosome will be counted as one
                        cDNA. Default = Off
    -d 1000, --distance=1000
                        this option allows you to set the maximum number of
                        base-pairs allowed between two non-overlapping paired
                        reads. Default = 1000
    --discarded=FILE    prints the lines from the alignments file that were
                        discarded by the parsers. This file contains reads
                        that were unmapped (NM), of poor quality (i.e. QC) or
                        paired reads that were mapped to different chromosomal
                        locations or were too far apart on the same
                        chromosome. Useful for debugging purposes
    -l 100, --length=100
                        to set read length threshold. Default = 1000
    -m 100000, --max=100000
                        maximum number of mapped reads that will be analyzed.
                        Default = All
    --zip=FILE          use this option to compress all the output files in a
                        single zip file
```


## pycrac_pyMotif.py

### Tool Description
pyMotif.py

### Metadata
- **Docker Image**: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
- **Homepage**: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pycrac/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyMotif.py [options] -f filename --gtf=yeast.gtf --tab=yeast.tab

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit

  File input options:
    -f intervals.gtf, --input_file=intervals.gtf
                        Provide the path to an interval gtf file. By default
                        it expects data from the standard input.
    -o OUTPUT_FILE, --output_file=OUTPUT_FILE
                        Use this flag to override the standard file names. Do
                        NOT add an extension.
    --gtf=annotation_file.gtf
                        type the path to the gtf annotation file that you want
                        to use
    --tab=tab_file.tab  type the path to the tab file that contains the
                        genomic reference sequence

  pyMotif specific options:
    --k_min=4           this option allows you to set the shortest k-mer
                        length. Default = 4.
    --k_max=6           this option allows you to set the longest k-mer
                        length. Default = 8.
    -n 100, --numberofkmers=100
                        choose the maximum number of enriched k-mer sequences
                        you want to have reported in output files. Default =
                        1000

  pyCRAC common options:
    -a protein_coding, --annotation=protein_coding
                        select which annotation (i.e. protein_coding, ncRNA,
                        sRNA, rRNA,snoRNA,snRNA, depending on the source of
                        your GTF file) you would like to focus your search on.
                        Default = all annotations
    -r 100, --range=100
                        allows you to add regions flanking the genomic
                        feature. If you set '-r 50' or '--range=50', then the
                        program will add 50 nucleotides to each feature on
                        each side regardless of whether the GTF file has genes
                        with annotated UTRs.
    -v, --verbose       prints all the status messages to a file rather than
                        the standard output
    --overlap=1         sets the number of nucleotides a motif has to overlap
                        with a genomic feature before it is considered a hit.
                        Default =  1 nucleotide
    --zip=FILE          use this option to compress all the output files in a
                        single zip file
```


## Metadata
- **Skill**: generated
