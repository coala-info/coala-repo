# crispresso CWL Generation Report

## crispresso_CRISPResso

### Tool Description
Analysis of CRISPR/Cas9 outcomes from deep sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
- **Homepage**: https://github.com/lucapinello/CRISPResso
- **Package**: https://anaconda.org/channels/bioconda/packages/crispresso/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispresso/overview
- **Total Downloads**: 28.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lucapinello/CRISPResso
- **Stars**: N/A
### Original Help Text
```text
~~~CRISPResso~~~
-Analysis of CRISPR/Cas9 outcomes from deep sequencing data-

                      )
                     (
                    __)__
                 C\|     |
                   \     /
                    \___/
             

[Luca Pinello 2015, send bugs, suggestions or *green coffee* to lucapinello AT gmail DOT com]

Version 1.0.13

usage: CRISPResso [-h] -r1 FASTQ_R1 [-r2 FASTQ_R2] -a AMPLICON_SEQ
                  [-g GUIDE_SEQ] [-e EXPECTED_HDR_AMPLICON_SEQ] [-d DONOR_SEQ]
                  [-c CODING_SEQ] [-q MIN_AVERAGE_READ_QUALITY]
                  [-s MIN_SINGLE_BP_QUALITY]
                  [--min_identity_score MIN_IDENTITY_SCORE] [-n NAME]
                  [-o OUTPUT_FOLDER] [--split_paired_end] [--trim_sequences]
                  [--trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING]
                  [--min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP]
                  [--max_paired_end_reads_overlap MAX_PAIRED_END_READS_OVERLAP]
                  [--hide_mutations_outside_window_NHEJ]
                  [-w WINDOW_AROUND_SGRNA] [--cleavage_offset CLEAVAGE_OFFSET]
                  [--exclude_bp_from_left EXCLUDE_BP_FROM_LEFT]
                  [--exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT]
                  [--hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD]
                  [--ignore_substitutions] [--ignore_insertions]
                  [--ignore_deletions]
                  [--needle_options_string NEEDLE_OPTIONS_STRING]
                  [--keep_intermediate] [--dump] [--save_also_png]
                  [-p N_PROCESSES]
                  [--offset_around_cut_to_plot OFFSET_AROUND_CUT_TO_PLOT]
                  [--min_frequency_alleles_around_cut_to_plot MIN_FREQUENCY_ALLELES_AROUND_CUT_TO_PLOT]
                  [--max_rows_alleles_around_cut_to_plot MAX_ROWS_ALLELES_AROUND_CUT_TO_PLOT]
                  [--debug]

CRISPResso Parameters

optional arguments:
  -h, --help            show this help message and exit
  -r1 FASTQ_R1, --fastq_r1 FASTQ_R1
                        First fastq file (default: Fastq filename)
  -r2 FASTQ_R2, --fastq_r2 FASTQ_R2
                        Second fastq file for paired end reads (default: )
  -a AMPLICON_SEQ, --amplicon_seq AMPLICON_SEQ
                        Amplicon Sequence (default: None)
  -g GUIDE_SEQ, --guide_seq GUIDE_SEQ
                        sgRNA sequence, if more than one, please separate by
                        comma/s. Note that the sgRNA needs to be input as the
                        guide RNA sequence (usually 20 nt) immediately
                        adjacent to but not including the PAM sequence (5' of
                        NGG for SpCas9). If the PAM is found on the opposite
                        strand with respect to the Amplicon Sequence, ensure
                        the sgRNA sequence is also found on the opposite
                        strand. The CRISPResso convention is to depict the
                        expected cleavage position using the value of the
                        parameter cleavage_offset nt 3' from the end of the
                        guide. In addition, the use of alternate nucleases to
                        SpCas9 is supported. For example, if using the Cpf1
                        system, enter the sequence (usually 20 nt) immediately
                        3' of the PAM sequence and explicitly set the
                        cleavage_offset parameter to 1, since the default
                        setting of -3 is suitable only for SpCas9. (default: )
  -e EXPECTED_HDR_AMPLICON_SEQ, --expected_hdr_amplicon_seq EXPECTED_HDR_AMPLICON_SEQ
                        Amplicon sequence expected after HDR (default: )
  -d DONOR_SEQ, --donor_seq DONOR_SEQ
                        Donor Sequence. This optional input comprises a
                        subsequence of the expected HDR amplicon to be
                        highlighted in plots. (default: )
  -c CODING_SEQ, --coding_seq CODING_SEQ
                        Subsequence/s of the amplicon sequence covering one or
                        more coding sequences for the frameshift analysis.If
                        more than one (for example, split by intron/s), please
                        separate by comma. (default: )
  -q MIN_AVERAGE_READ_QUALITY, --min_average_read_quality MIN_AVERAGE_READ_QUALITY
                        Minimum average quality score (phred33) to keep a read
                        (default: 0)
  -s MIN_SINGLE_BP_QUALITY, --min_single_bp_quality MIN_SINGLE_BP_QUALITY
                        Minimum single bp score (phred33) to keep a read
                        (default: 0)
  --min_identity_score MIN_IDENTITY_SCORE
                        Minimum identity score for the alignment (default:
                        60.0)
  -n NAME, --name NAME  Output name (default: )
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
  --split_paired_end    Splits a single fastq file contating paired end reads
                        in two files before running CRISPResso (default:
                        False)
  --trim_sequences      Enable the trimming of Illumina adapters with
                        Trimmomatic (default: False)
  --trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING
                        Override options for Trimmomatic (default:
                        ILLUMINACLIP:/usr/local/lib/python2.7/site-
                        packages/CRISPResso/data/NexteraPE-
                        PE.fa:0:90:10:0:true MINLEN:40)
  --min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP
                        Parameter for the FLASH read merging step. Minimum
                        required overlap length between two reads to provide a
                        confident overlap. (default: 4)
  --max_paired_end_reads_overlap MAX_PAIRED_END_READS_OVERLAP
                        Parameter for the FLASH merging step. Maximum overlap
                        length expected in approximately 90% of read pairs.
                        Please see the FLASH manual for more information.
                        (default: 100)
  --hide_mutations_outside_window_NHEJ
                        This parameter allows to visualize only the mutations
                        overlapping the cleavage site and used to classify a
                        read as NHEJ. This parameter has no effect on the
                        quanitification of the NHEJ. It may be helpful to mask
                        a pre-existing and known mutations or sequencing
                        errors outside the window used for quantification of
                        NHEJ events. (default: False)
  -w WINDOW_AROUND_SGRNA, --window_around_sgrna WINDOW_AROUND_SGRNA
                        Window(s) in bp around the cleavage position (half on
                        on each side) as determined by the provide guide RNA
                        sequence to quantify the indels. Any indels outside
                        this window are excluded. A value of 0 disables this
                        filter. (default: 1)
  --cleavage_offset CLEAVAGE_OFFSET
                        Cleavage offset to use within respect to the 3' end of
                        the provided sgRNA sequence. Remember that the sgRNA
                        sequence must be entered without the PAM. The default
                        is -3 and is suitable for the SpCas9 system. For
                        alternate nucleases, other cleavage offsets may be
                        appropriate, for example, if using Cpf1 this parameter
                        would be set to 1. (default: -3)
  --exclude_bp_from_left EXCLUDE_BP_FROM_LEFT
                        Exclude bp from the left side of the amplicon sequence
                        for the quantification of the indels (default: 15)
  --exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT
                        Exclude bp from the right side of the amplicon
                        sequence for the quantification of the indels
                        (default: 15)
  --hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD
                        Sequence homology % for an HDR occurrence (default:
                        98.0)
  --ignore_substitutions
                        Ignore substitutions events for the quantification and
                        visualization (default: False)
  --ignore_insertions   Ignore insertions events for the quantification and
                        visualization (default: False)
  --ignore_deletions    Ignore deletions events for the quantification and
                        visualization (default: False)
  --needle_options_string NEEDLE_OPTIONS_STRING
                        Override options for the Needle aligner (default:
                        -gapopen=10 -gapextend=0.5 -awidth3=5000)
  --keep_intermediate   Keep all the intermediate files (default: False)
  --dump                Dump numpy arrays and pandas dataframes to file for
                        debugging purposes (default: False)
  --save_also_png       Save also .png images additionally to .pdf files
                        (default: False)
  -p N_PROCESSES, --n_processes N_PROCESSES
                        Specify the number of processes to use for the
                        quantification. Please use with caution since
                        increasing this parameter will increase significantly
                        the memory required to run CRISPResso. (default: 1)
  --offset_around_cut_to_plot OFFSET_AROUND_CUT_TO_PLOT
                        Offset to use to summarize alleles around the cut site
                        in the alleles table plot. (default: 20)
  --min_frequency_alleles_around_cut_to_plot MIN_FREQUENCY_ALLELES_AROUND_CUT_TO_PLOT
                        Minimum % reads required to report an allele in the
                        alleles table plot. (default: 0.2)
  --max_rows_alleles_around_cut_to_plot MAX_ROWS_ALLELES_AROUND_CUT_TO_PLOT
                        Maximum number of rows to report in the alleles table
                        plot. (default: 50)
  --debug               Print stack trace on error. (default: False)
```


## crispresso_CRISPRessoPooled

### Tool Description
Analysis of CRISPR/Cas9 outcomes from POOLED deep sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
- **Homepage**: https://github.com/lucapinello/CRISPResso
- **Package**: https://anaconda.org/channels/bioconda/packages/crispresso/overview
- **Validation**: PASS

### Original Help Text
```text
~~~CRISPRessoPooled~~~
-Analysis of CRISPR/Cas9 outcomes from POOLED deep sequencing data-

              )                                            )
             (           _______________________          (
            __)__       | __  __  __     __ __  |        __)__
         C\|     \      ||__)/  \/  \|  |_ |  \ |     C\|     \
           \     /      ||   \__/\__/|__|__|__/ |       \     /
            \___/       |_______________________|        \___/
        

[Luca Pinello 2015, send bugs, suggestions or *green coffee* to lucapinello AT gmail DOT com]

Version 1.0.13

usage: CRISPRessoPooled [-h] -r1 FASTQ_R1 [-r2 FASTQ_R2] [-f AMPLICONS_FILE]
                        [-x BOWTIE2_INDEX]
                        [--gene_annotations GENE_ANNOTATIONS] [-p N_PROCESSES]
                        [--bowtie2_options_string BOWTIE2_OPTIONS_STRING]
                        [--min_reads_to_use_region MIN_READS_TO_USE_REGION]
                        [-q MIN_AVERAGE_READ_QUALITY]
                        [-s MIN_SINGLE_BP_QUALITY]
                        [--min_identity_score MIN_IDENTITY_SCORE] [-n NAME]
                        [-o OUTPUT_FOLDER] [--trim_sequences]
                        [--trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING]
                        [--min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP]
                        [--max_paired_end_reads_overlap MAX_PAIRED_END_READS_OVERLAP]
                        [--hide_mutations_outside_window_NHEJ]
                        [-w WINDOW_AROUND_SGRNA]
                        [--cleavage_offset CLEAVAGE_OFFSET]
                        [--exclude_bp_from_left EXCLUDE_BP_FROM_LEFT]
                        [--exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT]
                        [--hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD]
                        [--ignore_substitutions] [--ignore_insertions]
                        [--ignore_deletions]
                        [--needle_options_string NEEDLE_OPTIONS_STRING]
                        [--keep_intermediate] [--dump] [--save_also_png]

CRISPRessoPooled Parameters

optional arguments:
  -h, --help            show this help message and exit
  -r1 FASTQ_R1, --fastq_r1 FASTQ_R1
                        First fastq file (default: Fastq filename)
  -r2 FASTQ_R2, --fastq_r2 FASTQ_R2
                        Second fastq file for paired end reads (default: )
  -f AMPLICONS_FILE, --amplicons_file AMPLICONS_FILE
                        Amplicons description file. In particular, this file,
                        is a tab delimited text file with up to 5 columns (2
                        required): AMPLICON_NAME: an identifier for the
                        amplicon (must be unique) AMPLICON_SEQUENCE: amplicon
                        sequence used in the design of the experiment
                        sgRNA_SEQUENCE (OPTIONAL): sgRNA sequence used for
                        this amplicon without the PAM sequence. If more than
                        one separate them by commas and not spaces. If not
                        available enter NA. EXPECTED_AMPLICON_AFTER_HDR
                        (OPTIONAL): expected amplicon sequence in case of HDR.
                        If not available enter NA. CODING_SEQUENCE (OPTIONAL):
                        Subsequence(s) of the amplicon corresponding to coding
                        sequences. If more than one separate them by commas
                        and not spaces. If not available enter NA. (default: )
  -x BOWTIE2_INDEX, --bowtie2_index BOWTIE2_INDEX
                        Basename of Bowtie2 index for the reference genome
                        (default: )
  --gene_annotations GENE_ANNOTATIONS
                        Gene Annotation Table from UCSC Genome Browser Tables
                        (http://genome.ucsc.edu/cgi-
                        bin/hgTables?command=start), please select as table
                        "knowGene", as output format "all fields from selected
                        table" and as file returned "gzip compressed"
                        (default: )
  -p N_PROCESSES, --n_processes N_PROCESSES
                        Specify the number of processes to use for the
                        quantification. Please use with caution since
                        increasing this parameter will increase significantly
                        the memory required to run CRISPResso. (default: 1)
  --bowtie2_options_string BOWTIE2_OPTIONS_STRING
                        Override options for the Bowtie2 alignment command
                        (default: -k 1 --end-to-end -N 0 --np 0 )
  --min_reads_to_use_region MIN_READS_TO_USE_REGION
                        Minimum number of reads that align to a region to
                        perform the CRISPResso analysis (default: 1000)
  -q MIN_AVERAGE_READ_QUALITY, --min_average_read_quality MIN_AVERAGE_READ_QUALITY
                        Minimum average quality score (phred33) to keep a read
                        (default: 0)
  -s MIN_SINGLE_BP_QUALITY, --min_single_bp_quality MIN_SINGLE_BP_QUALITY
                        Minimum single bp score (phred33) to keep a read
                        (default: 0)
  --min_identity_score MIN_IDENTITY_SCORE
                        Min identity score for the alignment (default: 60.0)
  -n NAME, --name NAME  Output name (default: )
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
  --trim_sequences      Enable the trimming of Illumina adapters with
                        Trimmomatic (default: False)
  --trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING
                        Override options for Trimmomatic (default:
                        ILLUMINACLIP:/usr/local/lib/python2.7/site-
                        packages/CRISPResso/data/NexteraPE-
                        PE.fa:0:90:10:0:true MINLEN:40)
  --min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP
                        Minimum required overlap length between two reads to
                        provide a confident overlap. (default: 4)
  --max_paired_end_reads_overlap MAX_PAIRED_END_READS_OVERLAP
                        parameter for the flash merging step, this parameter
                        is the maximum overlap length expected in
                        approximately 90% of read pairs. Please see the flash
                        manual for more information. (default: 100)
  --hide_mutations_outside_window_NHEJ
                        This parameter allows to visualize only the mutations
                        overlapping the cleavage site and used to classify a
                        read as NHEJ. This parameter has no effect on the
                        quanitification of the NHEJ. It may be helpful to mask
                        a pre-existing and known mutations or sequencing
                        errors outside the window used for quantification of
                        NHEJ events. (default: False)
  -w WINDOW_AROUND_SGRNA, --window_around_sgrna WINDOW_AROUND_SGRNA
                        Window(s) in bp around the cleavage position (half on
                        on each side) as determined by the provide guide RNA
                        sequence to quantify the indels. Any indels outside
                        this window are excluded. A value of 0 disables this
                        filter. (default: 1)
  --cleavage_offset CLEAVAGE_OFFSET
                        Cleavage offset to use within respect to the 3' end of
                        the provided sgRNA sequence. Remember that the sgRNA
                        sequence must be entered without the PAM. The default
                        is -3 and is suitable for the SpCas9 system. For
                        alternate nucleases, other cleavage offsets may be
                        appropriate, for example, if using Cpf1 this parameter
                        would be set to 1. (default: -3)
  --exclude_bp_from_left EXCLUDE_BP_FROM_LEFT
                        Exclude bp from the left side of the amplicon sequence
                        for the quantification of the indels (default: 15)
  --exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT
                        Exclude bp from the right side of the amplicon
                        sequence for the quantification of the indels
                        (default: 15)
  --hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD
                        Sequence homology % for an HDR occurrence (default:
                        98.0)
  --ignore_substitutions
                        Ignore substitutions events for the quantification and
                        visualization (default: False)
  --ignore_insertions   Ignore insertions events for the quantification and
                        visualization (default: False)
  --ignore_deletions    Ignore deletions events for the quantification and
                        visualization (default: False)
  --needle_options_string NEEDLE_OPTIONS_STRING
                        Override options for the Needle aligner (default:
                        -gapopen=10 -gapextend=0.5 -awidth3=5000)
  --keep_intermediate   Keep all the intermediate files (default: False)
  --dump                Dump numpy arrays and pandas dataframes to file for
                        debugging purposes (default: False)
  --save_also_png       Save also .png images additionally to .pdf files
                        (default: False)
```


## crispresso_CRISPRessoWGS

### Tool Description
Analysis of CRISPR/Cas9 outcomes from WGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
- **Homepage**: https://github.com/lucapinello/CRISPResso
- **Package**: https://anaconda.org/channels/bioconda/packages/crispresso/overview
- **Validation**: PASS

### Original Help Text
```text
~~~CRISPRessoWGS~~~
-Analysis of CRISPR/Cas9 outcomes from WGS data-

           )                                 )
          (           ____________          (
         __)__       |     __  __ |        __)__
      C\|     \      ||  |/ _ (_  |     C\|     \
        \     /      ||/\|\__)__) |       \     /
         \___/       |____________|        \___/
        

[Luca Pinello 2015, send bugs, suggestions or *green coffee* to lucapinello AT gmail DOT com]

Version 1.0.13

usage: CRISPRessoWGS [-h] -b BAM_FILE [-f REGION_FILE] [-r REFERENCE_FILE]
                     [--min_reads_to_use_region MIN_READS_TO_USE_REGION]
                     [--gene_annotations GENE_ANNOTATIONS]
                     [-q MIN_AVERAGE_READ_QUALITY] [-s MIN_SINGLE_BP_QUALITY]
                     [--min_identity_score MIN_IDENTITY_SCORE] [-n NAME]
                     [-o OUTPUT_FOLDER] [--trim_sequences]
                     [--trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING]
                     [--min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP]
                     [--hide_mutations_outside_window_NHEJ]
                     [-w WINDOW_AROUND_SGRNA]
                     [--cleavage_offset CLEAVAGE_OFFSET]
                     [--exclude_bp_from_left EXCLUDE_BP_FROM_LEFT]
                     [--exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT]
                     [--hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD]
                     [--ignore_substitutions] [--ignore_insertions]
                     [--ignore_deletions]
                     [--needle_options_string NEEDLE_OPTIONS_STRING]
                     [--keep_intermediate] [--dump] [--save_also_png]
                     [-p N_PROCESSES]

CRISPRessoWGS Parameters

optional arguments:
  -h, --help            show this help message and exit
  -b BAM_FILE, --bam_file BAM_FILE
                        WGS aligned bam file (default: bam filename)
  -f REGION_FILE, --region_file REGION_FILE
                        Regions description file. A BED format file containing
                        the regions to analyze, one per line. The REQUIRED
                        columns are: chr_id(chromosome name), bpstart(start
                        position), bpend(end position), the optional columns
                        are:name (an unique indentifier for the region),
                        guide_seq, expected_hdr_amplicon_seq,coding_seq, see
                        CRISPResso help for more details on these last 3
                        parameters) (default: )
  -r REFERENCE_FILE, --reference_file REFERENCE_FILE
                        A FASTA format reference file (for example hg19.fa for
                        the human genome) (default: )
  --min_reads_to_use_region MIN_READS_TO_USE_REGION
                        Minimum number of reads that align to a region to
                        perform the CRISPResso analysis (default: 10)
  --gene_annotations GENE_ANNOTATIONS
                        Gene Annotation Table from UCSC Genome Browser Tables
                        (http://genome.ucsc.edu/cgi-
                        bin/hgTables?command=start), please select as table
                        "knowGene", as output format "all fields from selected
                        table" and as file returned "gzip compressed"
                        (default: )
  -q MIN_AVERAGE_READ_QUALITY, --min_average_read_quality MIN_AVERAGE_READ_QUALITY
                        Minimum average quality score (phred33) to keep a read
                        (default: 0)
  -s MIN_SINGLE_BP_QUALITY, --min_single_bp_quality MIN_SINGLE_BP_QUALITY
                        Minimum single bp score (phred33) to keep a read
                        (default: 0)
  --min_identity_score MIN_IDENTITY_SCORE
                        Min identity score for the alignment (default: 60.0)
  -n NAME, --name NAME  Output name (default: )
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
  --trim_sequences      Enable the trimming of Illumina adapters with
                        Trimmomatic (default: False)
  --trimmomatic_options_string TRIMMOMATIC_OPTIONS_STRING
                        Override options for Trimmomatic (default:
                        ILLUMINACLIP:/usr/local/lib/python2.7/site-
                        packages/CRISPResso/data/NexteraPE-
                        PE.fa:0:90:10:0:true MINLEN:40)
  --min_paired_end_reads_overlap MIN_PAIRED_END_READS_OVERLAP
                        Minimum required overlap length between two reads to
                        provide a confident overlap. (default: 4)
  --hide_mutations_outside_window_NHEJ
                        This parameter allows to visualize only the mutations
                        overlapping the cleavage site and used to classify a
                        read as NHEJ. This parameter has no effect on the
                        quanitification of the NHEJ. It may be helpful to mask
                        a pre-existing and known mutations or sequencing
                        errors outside the window used for quantification of
                        NHEJ events. (default: False)
  -w WINDOW_AROUND_SGRNA, --window_around_sgrna WINDOW_AROUND_SGRNA
                        Window(s) in bp around the cleavage position (half on
                        on each side) as determined by the provide guide RNA
                        sequence to quantify the indels. Any indels outside
                        this window are excluded. A value of 0 disables this
                        filter. (default: 1)
  --cleavage_offset CLEAVAGE_OFFSET
                        Cleavage offset to use within respect to the 3' end of
                        the provided sgRNA sequence. Remember that the sgRNA
                        sequence must be entered without the PAM. The default
                        is -3 and is suitable for the SpCas9 system. For
                        alternate nucleases, other cleavage offsets may be
                        appropriate, for example, if using Cpf1 this parameter
                        would be set to 1. (default: -3)
  --exclude_bp_from_left EXCLUDE_BP_FROM_LEFT
                        Exclude bp from the left side of the amplicon sequence
                        for the quantification of the indels (default: 5)
  --exclude_bp_from_right EXCLUDE_BP_FROM_RIGHT
                        Exclude bp from the right side of the amplicon
                        sequence for the quantification of the indels
                        (default: 5)
  --hdr_perfect_alignment_threshold HDR_PERFECT_ALIGNMENT_THRESHOLD
                        Sequence homology % for an HDR occurrence (default:
                        98.0)
  --ignore_substitutions
                        Ignore substitutions events for the quantification and
                        visualization (default: False)
  --ignore_insertions   Ignore insertions events for the quantification and
                        visualization (default: False)
  --ignore_deletions    Ignore deletions events for the quantification and
                        visualization (default: False)
  --needle_options_string NEEDLE_OPTIONS_STRING
                        Override options for the Needle aligner (default:
                        -gapopen=10 -gapextend=0.5 -awidth3=5000)
  --keep_intermediate   Keep all the intermediate files (default: False)
  --dump                Dump numpy arrays and pandas dataframes to file for
                        debugging purposes (default: False)
  --save_also_png       Save also .png images additionally to .pdf files
                        (default: False)
  -p N_PROCESSES, --n_processes N_PROCESSES
                        Specify the number of processes to use for the
                        quantification. Please use with caution since
                        increasing this parameter will increase significantly
                        the memory required to run CRISPResso. (default: 1)
```


## crispresso_CRISPRessoCompare

### Tool Description
Comparison of two CRISPResso analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
- **Homepage**: https://github.com/lucapinello/CRISPResso
- **Package**: https://anaconda.org/channels/bioconda/packages/crispresso/overview
- **Validation**: PASS

### Original Help Text
```text
~~~CRISPRessoCompare~~~
-Comparison of two CRISPResso analysis-

    
    
              )                                                )
             (           ___________________________          (
            __)__       | __ __      __      __  __ |        __)__
         C\|     \      |/  /  \|\/||__) /\ |__)|_  |     C\|     \
           \     /      |\__\__/|  ||   /--\| \ |__ |       \     /
            \___/       |___________________________|        \___/
        

[Luca Pinello 2015, send bugs, suggestions or *green coffee* to lucapinello AT gmail DOT com]

Version 1.0.13

usage: CRISPRessoCompare [-h] [-n NAME] [-n1 SAMPLE_1_NAME]
                         [-n2 SAMPLE_2_NAME] [-o OUTPUT_FOLDER]
                         [--save_also_png]
                         crispresso_output_folder_1 crispresso_output_folder_2

CRISPRessoCompare Parameters

positional arguments:
  crispresso_output_folder_1
                        First output folder with CRISPResso analysis
  crispresso_output_folder_2
                        Second output folder with CRISPResso analysis

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  Output name (default: )
  -n1 SAMPLE_1_NAME, --sample_1_name SAMPLE_1_NAME
                        Sample 1 name (default: Sample_1)
  -n2 SAMPLE_2_NAME, --sample_2_name SAMPLE_2_NAME
                        Sample 2 name (default: Sample_2)
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
  --save_also_png       Save also .png images additionally to .pdf files
                        (default: False)
```


## Metadata
- **Skill**: generated
