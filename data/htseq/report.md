# htseq CWL Generation Report

## htseq_htseq-count

### Tool Description
This script takes one or more alignment files in SAM/BAM format and a feature file in GFF format and calculates for each feature the number of reads mapping to it.

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0
- **Homepage**: https://github.com/htseq/htseq
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/htseq/overview
- **Total Downloads**: 792.1K
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/htseq/htseq
- **Stars**: N/A
### Original Help Text
```text
usage: htseq-count [-h] [--version] [-f {sam,bam,auto}] [-r {pos,name}]
                   [--max-reads-in-buffer MAX_BUFFER_SIZE]
                   [-s {yes,no,reverse}] [-a MINAQUAL] [-t FEATURE_TYPE]
                   [-i IDATTR] [--additional-attr ADDITIONAL_ATTRIBUTES]
                   [--add-chromosome-info]
                   [-m {union,intersection-strict,intersection-nonempty}]
                   [--nonunique {none,all,fraction,random}]
                   [--secondary-alignments {score,ignore}]
                   [--supplementary-alignments {score,ignore}] [-o SAMOUTS]
                   [-p {SAM,BAM,sam,bam}] [-d OUTPUT_DELIMITER]
                   [-c OUTPUT_FILENAME] [--counts-output-sparse]
                   [--append-output] [-n NPROCESSES]
                   [--feature-query FEATURE_QUERY] [-q] [--with-header]
                   samfilenames [samfilenames ...] featuresfilename

This script takes one or more alignment files in SAM/BAM format and a feature
file in GFF format and calculates for each feature the number of reads mapping
to it. See http://htseq.readthedocs.io/en/master/count.html for details.

positional arguments:
  samfilenames          Path to the SAM/BAM files containing the mapped reads.
                        If '-' is selected, read from standard input
  featuresfilename      Path to the GTF file containing the features

options:
  -h, --help            show this help message and exit
  --version             Show software version and exit
  -f {sam,bam,auto}, --format {sam,bam,auto}
                        Type of <alignment_file> data. DEPRECATED: file format
                        is detected automatically. This option is ignored.
  -r {pos,name}, --order {pos,name}
                        'pos' or 'name'. Sorting order of <alignment_file>
                        (default: name). Paired-end sequencing data must be
                        sorted either by position or by read name, and the
                        sorting order must be specified. Ignored for single-
                        end data.
  --max-reads-in-buffer MAX_BUFFER_SIZE
                        When <alignment_file> is paired end sorted by
                        position, allow only so many reads to stay in memory
                        until the mates are found (raising this number will
                        use more memory). Has no effect for single end or
                        paired end sorted by name
  -s {yes,no,reverse}, --stranded {yes,no,reverse}
                        Whether the data is from a strand-specific assay.
                        Specify 'yes', 'no', or 'reverse' (default: yes).
                        'reverse' means 'yes' with reversed strand
                        interpretation
  -a MINAQUAL, --minaqual MINAQUAL
                        Skip all reads with MAPQ alignment quality lower than
                        the given minimum value (default: 10). MAPQ is the 5th
                        column of a SAM/BAM file and its usage depends on the
                        software used to map the reads.
  -t FEATURE_TYPE, --type FEATURE_TYPE
                        Feature type (3rd column in GTF file) to be used, all
                        features of other type are ignored (default, suitable
                        forEnsembl GTF files: exon). If you can call this
                        option multiple times, features of all specified types
                        will be included, e.g. to include both genes and
                        pseudogenes you might use -t gene -t pseudogene.
                        Calling this option multiple times is a rare need and
                        might result in excessive numbers of ambiguous counts:
                        only use if you know what you are doing.
  -i IDATTR, --idattr IDATTR
                        GTF attribute to be used as feature ID (default,
                        suitable for Ensembl GTF files: gene_id). All feature
                        of the right type (see -t option) within the same GTF
                        attribute will be added together. The typical way of
                        using this option is to count all exonic reads from
                        each gene and add the exons but other uses are
                        possible as well. You can call this option multiple
                        times: in that case, the combination of all attributes
                        separated by colons (:) will be used as a unique
                        identifier, e.g. for exons you might use -i gene_id -i
                        exon_number.
  --additional-attr ADDITIONAL_ATTRIBUTES
                        Additional feature attributes (default: none, suitable
                        for Ensembl GTF files: gene_name). Use multiple times
                        for more than one additional attribute. These
                        attributes are only used as annotations in the output,
                        while the determination of how the counts are added
                        together is done based on option -i.
  --add-chromosome-info
                        Store information about the chromosome of each feature
                        as an additional attribute (e.g. colunm in the TSV
                        output file).
  -m {union,intersection-strict,intersection-nonempty}, --mode {union,intersection-strict,intersection-nonempty}
                        Mode to handle reads overlapping more than one feature
                        (choices: union, intersection-strict, intersection-
                        nonempty; default: union)
  --nonunique {none,all,fraction,random}
                        Whether and how to score reads that are not uniquely
                        aligned or ambiguously assigned to features (choices:
                        none, all, fraction, random; default: none)
  --secondary-alignments {score,ignore}
                        Whether to score secondary alignments (0x100 flag)
  --supplementary-alignments {score,ignore}
                        Whether to score supplementary alignments (0x800 flag)
  -o SAMOUTS, --samout SAMOUTS
                        Write out all SAM alignment records into SAM/BAM files
                        (one per input file needed), annotating each line with
                        its feature assignment (as an optional field with tag
                        'XF'). See the -p option to use BAM instead of SAM.
  -p {SAM,BAM,sam,bam}, --samout-format {SAM,BAM,sam,bam}
                        Format to use with the --samout option.
  -d OUTPUT_DELIMITER, --delimiter OUTPUT_DELIMITER
                        Column delimiter in output (default: TAB).
  -c OUTPUT_FILENAME, --counts_output OUTPUT_FILENAME
                        Filename to output the counts to instead of stdout.
  --counts-output-sparse
                        Store the counts as a sparse matrix (mtx, h5ad, loom).
  --append-output       Append counts output to an existing file instead of
                        creating a new one. This option is useful if you have
                        already creates a TSV/CSV/similar file with a header
                        for your samples (with additional columns for the
                        feature name and any additionl attributes) and want to
                        fill in the rest of the file.
  -n NPROCESSES, --nprocesses NPROCESSES
                        Number of parallel CPU processes to use (default: 1).
                        This option is useful to process several input files
                        at once. Each file will use only 1 CPU. It is
                        possible, of course, to split a very large input
                        SAM/BAM files into smaller chunks upstream to make use
                        of this option.
  --feature-query FEATURE_QUERY
                        Restrict to features descibed in this expression.
                        Currently supports a single kind of expression:
                        attribute == "one attr" to restrict the GFF to a
                        single gene or transcript, e.g. --feature-query
                        'gene_name == "ACTB"' - notice the single quotes
                        around the argument of this option and the double
                        quotes around the gene name. Broader queries might
                        become available in the future.
  -q, --quiet           Suppress progress report
  --with-header         Whether to add a column header to the output TSV file
                        indicating which column corresponds to which input BAM
                        file. Only used if output to console or tsv or csv
                        file. Default to False.

Written by Simon Anders (sanders@fs.tum.de), European Molecular Biology
Laboratory (EMBL), Givanna Putri (g.putri@unsw.edu.au) and Fabio Zanini
(fabio.zanini@unsw.edu.au), UNSW Sydney. (c) 2010-2021. Released under the
terms of the GNU General Public License v3. Please cite the following paper if
you use this script: G. Putri et al. Analysing high-throughput sequencing data
in Python with HTSeq 2.0. Bioinformatics (2022).
https://doi.org/10.1093/bioinformatics/btac166. Part of the 'HTSeq' framework,
version 2.1.2.
```


## htseq_htseq-qa

### Tool Description
This script takes a file with high-throughput sequencing reads and performs a simple quality assessment by producing plots showing the distribution of called bases and base-call quality scores by position within the reads. The plots are output as a PDF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0
- **Homepage**: https://github.com/htseq/htseq
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-qa [-h] [-t {sam,bam,solexa-export,fastq,solexa-fastq}]
                [-o OUTFILE] [-r READLEN] [-g GAMMA] [-n] [-m MAXQUAL]
                [--primary-only] [--max-records MAX_RECORDS]
                readfilename

This script take a file with high-throughput sequencing reads (supported
formats: SAM, Solexa _export.txt, FASTQ, Solexa _sequence.txt) and performs a
simply quality assessment by producing plots showing the distribution of
called bases and base-call quality scores by position within the reads. The
plots are output as a PDF file.

positional arguments:
  readfilename          The file to count reads in (SAM/BAM or Fastq)

options:
  -h, --help            show this help message and exit
  -t {sam,bam,solexa-export,fastq,solexa-fastq}, --type {sam,bam,solexa-export,fastq,solexa-fastq}
                        type of read_file (one of: sam [default], bam, solexa-
                        export, fastq, solexa-fastq)
  -o OUTFILE, --outfile OUTFILE
                        output filename (default is <read_file>.pdf)
  -r READLEN, --readlength READLEN
                        the maximum read length (when not specified, the
                        script guesses from the file
  -g GAMMA, --gamma GAMMA
                        the gamma factor for the contrast adjustment of the
                        quality score plot
  -n, --nosplit         do not split reads in unaligned and aligned ones
  -m MAXQUAL, --maxqual MAXQUAL
                        the maximum quality score that appears in the data
                        (default: 41)
  --primary-only        For SAM/BAM input files, ignore alignments that are
                        not primary. This only affects 'multimapper' reads
                        that align to several regions in the genome. By
                        choosing this option, each read will only count as
                        one; without this option, each of its alignments
                        counts as one.
  --max-records MAX_RECORDS
                        Limit the analysis to the first N reads/alignments.
```


## htseq_htseq-count-barcodes

### Tool Description
This script takes one alignment file in SAM/BAM format and a feature file in GFF format and calculates for each feature the number of reads mapping to it, accounting for barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0
- **Homepage**: https://github.com/htseq/htseq
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-count-barcodes [-h] [--version] [-f {sam,bam,auto}]
                            [-r {pos,name}]
                            [--max-reads-in-buffer MAX_BUFFER_SIZE]
                            [-s {yes,no,reverse}] [-a MINAQUAL]
                            [-t FEATURETYPE] [-i IDATTR]
                            [--additional-attr ADDITIONAL_ATTR]
                            [--add-chromosome-info]
                            [-m {union,intersection-strict,intersection-nonempty}]
                            [--nonunique {none,all}]
                            [--secondary-alignments {score,ignore}]
                            [--supplementary-alignments {score,ignore}]
                            [-o SAMOUT] [-p {SAM,BAM,sam,bam}]
                            [-d OUTPUT_DELIMITER] [-c OUTPUT_FILENAME]
                            [--counts_output_sparse] [--cell-barcode CB_TAG]
                            [--UMI UB_TAG] [--correct-UMI-distance {0,1,2}]
                            [-q]
                            samfilename featuresfilename

This script takes one alignment file in SAM/BAM format and a feature file in
GFF format and calculates for each feature the number of reads mapping to it,
accounting for barcodes. See http://htseq.readthedocs.io/en/master/count.html
for details.

positional arguments:
  samfilename           Path to the SAM/BAM file containing the barcoded,
                        mapped reads. If '-' is selected, read from standard
                        input
  featuresfilename      Path to the GTF file containing the features

options:
  -h, --help            show this help message and exit
  --version             Show software version and exit
  -f {sam,bam,auto}, --format {sam,bam,auto}
                        Type of <alignment_file> data. DEPRECATED: file format
                        is detected automatically. This option is ignored.
  -r {pos,name}, --order {pos,name}
                        'pos' or 'name'. Sorting order of <alignment_file>
                        (default: name). Paired-end sequencing data must be
                        sorted either by position or by read name, and the
                        sorting order must be specified. Ignored for single-
                        end data.
  --max-reads-in-buffer MAX_BUFFER_SIZE
                        When <alignment_file> is paired end sorted by
                        position, allow only so many reads to stay in memory
                        until the mates are found (raising this number will
                        use more memory). Has no effect for single end or
                        paired end sorted by name
  -s {yes,no,reverse}, --stranded {yes,no,reverse}
                        Whether the data is from a strand-specific assay.
                        Specify 'yes', 'no', or 'reverse' (default: yes).
                        'reverse' means 'yes' with reversed strand
                        interpretation
  -a MINAQUAL, --minaqual MINAQUAL
                        Skip all reads with MAPQ alignment quality lower than
                        the given minimum value (default: 10). MAPQ is the 5th
                        column of a SAM/BAM file and its usage depends on the
                        software used to map the reads.
  -t FEATURETYPE, --type FEATURETYPE
                        Feature type (3rd column in GTF file) to be used, all
                        features of other type are ignored (default, suitable
                        forEnsembl GTF files: exon). You can call this option
                        multiple times. Features of all specified types will
                        be included. E.g. to include both genes and
                        pseudogenes you might use -t gene -t pseudogene
  -i IDATTR, --idattr IDATTR
                        GTF attribute to be used as feature ID (default,
                        suitable for Ensembl GTF files: gene_id)
  --additional-attr ADDITIONAL_ATTR
                        Additional feature attributes (default: none, suitable
                        for Ensembl GTF files: gene_name). Use multiple times
                        for each different attribute
  --add-chromosome-info
                        Store information about the chromosome of each feature
                        as an additional attribute (e.g. colunm in the TSV
                        output file).
  -m {union,intersection-strict,intersection-nonempty}, --mode {union,intersection-strict,intersection-nonempty}
                        Mode to handle reads overlapping more than one feature
                        (choices: union, intersection-strict, intersection-
                        nonempty; default: union)
  --nonunique {none,all}
                        Whether to score reads that are not uniquely aligned
                        or ambiguously assigned to features
  --secondary-alignments {score,ignore}
                        Whether to score secondary alignments (0x100 flag)
  --supplementary-alignments {score,ignore}
                        Whether to score supplementary alignments (0x800 flag)
  -o SAMOUT, --samout SAMOUT
                        Write out all SAM alignment records into aSAM/BAM
                        file, annotating each line with its feature assignment
                        (as an optional field with tag 'XF'). See the -p
                        option to use BAM instead of SAM.
  -p {SAM,BAM,sam,bam}, --samout-format {SAM,BAM,sam,bam}
                        Format to use with the --samout option.
  -d OUTPUT_DELIMITER, --delimiter OUTPUT_DELIMITER
                        Column delimiter in output (default: TAB).
  -c OUTPUT_FILENAME, --counts_output OUTPUT_FILENAME
                        TSV/CSV filename to output the counts to instead of
                        stdout.
  --counts_output_sparse
                        Store the counts as a sparse matrix (mtx, h5ad, loom).
  --cell-barcode CB_TAG
                        BAM tag used for the cell barcode (default compatible
                        with 10X Genomics Chromium is CB).
  --UMI UB_TAG          BAM tag used for the unique molecular identifier, also
                        known as molecular barcode (default compatible with
                        10X Genomics Chromium is UB).
  --correct-UMI-distance {0,1,2}
                        Correct for sequencing errors in the UMI tag, based on
                        Hamming distance. For each UMI, if another UMI with
                        more reads within 1 or 2 mutations is found, merge
                        this UMI's reads into the more popular one. The
                        default is to not correct UMIs.
  -q, --quiet           Suppress progress report

Written by Simon Anders (sanders@fs.tum.de), European Molecular Biology
Laboratory (EMBL) and Fabio Zanini (fabio.zanini@unsw.edu.au), UNSW Sydney.
(c) 2010-2020. Released under the terms of the GNU General Public License v3.
Please cite the following paper if you use this script: G. Putri et al.
Analysing high-throughput sequencing data in Python with HTSeq 2.0.
Bioinformatics (2022). https://doi.org/10.1093/bioinformatics/btac166. Part of
the 'HTSeq' framework, version 2.1.2.
```


## Metadata
- **Skill**: generated
