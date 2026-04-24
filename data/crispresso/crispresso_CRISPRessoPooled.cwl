cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoPooled
label: crispresso_CRISPRessoPooled
doc: "Analysis of CRISPR/Cas9 outcomes from POOLED deep sequencing data\n\nTool homepage:
  https://github.com/lucapinello/CRISPResso"
inputs:
  - id: amplicons_file
    type:
      - 'null'
      - File
    doc: 'Amplicons description file. In particular, this file, is a tab delimited
      text file with up to 5 columns (2 required): AMPLICON_NAME: an identifier for
      the amplicon (must be unique) AMPLICON_SEQUENCE: amplicon sequence used in the
      design of the experiment sgRNA_SEQUENCE (OPTIONAL): sgRNA sequence used for
      this amplicon without the PAM sequence. If more than one separate them by commas
      and not spaces. If not available enter NA. EXPECTED_AMPLICON_AFTER_HDR (OPTIONAL):
      expected amplicon sequence in case of HDR. If not available enter NA. CODING_SEQUENCE
      (OPTIONAL): Subsequence(s) of the amplicon corresponding to coding sequences.
      If more than one separate them by commas and not spaces. If not available enter
      NA.'
    inputBinding:
      position: 101
      prefix: --amplicons_file
  - id: bowtie2_index
    type:
      - 'null'
      - string
    doc: Basename of Bowtie2 index for the reference genome
    inputBinding:
      position: 101
      prefix: --bowtie2_index
  - id: bowtie2_options_string
    type:
      - 'null'
      - string
    doc: Override options for the Bowtie2 alignment command
    inputBinding:
      position: 101
      prefix: --bowtie2_options_string
  - id: cleavage_offset
    type:
      - 'null'
      - int
    doc: Cleavage offset to use within respect to the 3' end of the provided 
      sgRNA sequence. Remember that the sgRNA sequence must be entered without 
      the PAM. The default is -3 and is suitable for the SpCas9 system. For 
      alternate nucleases, other cleavage offsets may be appropriate, for 
      example, if using Cpf1 this parameter would be set to 1.
    inputBinding:
      position: 101
      prefix: --cleavage_offset
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump numpy arrays and pandas dataframes to file for debugging purposes
    inputBinding:
      position: 101
      prefix: --dump
  - id: exclude_bp_from_left
    type:
      - 'null'
      - int
    doc: Exclude bp from the left side of the amplicon sequence for the 
      quantification of the indels
    inputBinding:
      position: 101
      prefix: --exclude_bp_from_left
  - id: exclude_bp_from_right
    type:
      - 'null'
      - int
    doc: Exclude bp from the right side of the amplicon sequence for the 
      quantification of the indels
    inputBinding:
      position: 101
      prefix: --exclude_bp_from_right
  - id: fastq_r1
    type: File
    doc: First fastq file
    inputBinding:
      position: 101
      prefix: --fastq_r1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: Second fastq file for paired end reads
    inputBinding:
      position: 101
      prefix: --fastq_r2
  - id: gene_annotations
    type:
      - 'null'
      - File
    doc: Gene Annotation Table from UCSC Genome Browser Tables 
      (http://genome.ucsc.edu/cgi-bin/hgTables?command=start), please select as 
      table "knowGene", as output format "all fields from selected table" and as
      file returned "gzip compressed"
    inputBinding:
      position: 101
      prefix: --gene_annotations
  - id: hdr_perfect_alignment_threshold
    type:
      - 'null'
      - float
    doc: Sequence homology % for an HDR occurrence
    inputBinding:
      position: 101
      prefix: --hdr_perfect_alignment_threshold
  - id: hide_mutations_outside_window_nhej
    type:
      - 'null'
      - boolean
    doc: This parameter allows to visualize only the mutations overlapping the 
      cleavage site and used to classify a read as NHEJ. This parameter has no 
      effect on the quanitification of the NHEJ. It may be helpful to mask a 
      pre-existing and known mutations or sequencing errors outside the window 
      used for quantification of NHEJ events.
    inputBinding:
      position: 101
      prefix: --hide_mutations_outside_window_NHEJ
  - id: ignore_deletions
    type:
      - 'null'
      - boolean
    doc: Ignore deletions events for the quantification and visualization
    inputBinding:
      position: 101
      prefix: --ignore_deletions
  - id: ignore_insertions
    type:
      - 'null'
      - boolean
    doc: Ignore insertions events for the quantification and visualization
    inputBinding:
      position: 101
      prefix: --ignore_insertions
  - id: ignore_substitutions
    type:
      - 'null'
      - boolean
    doc: Ignore substitutions events for the quantification and visualization
    inputBinding:
      position: 101
      prefix: --ignore_substitutions
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: Keep all the intermediate files
    inputBinding:
      position: 101
      prefix: --keep_intermediate
  - id: max_paired_end_reads_overlap
    type:
      - 'null'
      - int
    doc: parameter for the flash merging step, this parameter is the maximum 
      overlap length expected in approximately 90% of read pairs. Please see the
      flash manual for more information.
    inputBinding:
      position: 101
      prefix: --max_paired_end_reads_overlap
  - id: min_average_read_quality
    type:
      - 'null'
      - int
    doc: Minimum average quality score (phred33) to keep a read
    inputBinding:
      position: 101
      prefix: --min_average_read_quality
  - id: min_identity_score
    type:
      - 'null'
      - float
    doc: Min identity score for the alignment
    inputBinding:
      position: 101
      prefix: --min_identity_score
  - id: min_paired_end_reads_overlap
    type:
      - 'null'
      - int
    doc: Minimum required overlap length between two reads to provide a 
      confident overlap.
    inputBinding:
      position: 101
      prefix: --min_paired_end_reads_overlap
  - id: min_reads_to_use_region
    type:
      - 'null'
      - int
    doc: Minimum number of reads that align to a region to perform the 
      CRISPResso analysis
    inputBinding:
      position: 101
      prefix: --min_reads_to_use_region
  - id: min_single_bp_quality
    type:
      - 'null'
      - int
    doc: Minimum single bp score (phred33) to keep a read
    inputBinding:
      position: 101
      prefix: --min_single_bp_quality
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Specify the number of processes to use for the quantification. Please 
      use with caution since increasing this parameter will increase 
      significantly the memory required to run CRISPResso.
    inputBinding:
      position: 101
      prefix: --n_processes
  - id: name
    type:
      - 'null'
      - string
    doc: Output name
    inputBinding:
      position: 101
      prefix: --name
  - id: needle_options_string
    type:
      - 'null'
      - string
    doc: Override options for the Needle aligner
    inputBinding:
      position: 101
      prefix: --needle_options_string
  - id: save_also_png
    type:
      - 'null'
      - boolean
    doc: Save also .png images additionally to .pdf files
    inputBinding:
      position: 101
      prefix: --save_also_png
  - id: trim_sequences
    type:
      - 'null'
      - boolean
    doc: Enable the trimming of Illumina adapters with Trimmomatic
    inputBinding:
      position: 101
      prefix: --trim_sequences
  - id: trimmomatic_options_string
    type:
      - 'null'
      - string
    doc: Override options for Trimmomatic
      ILLUMINACLIP:/usr/local/lib/python2.7/site-packages/CRISPResso/data/NexteraPE-PE.fa:0:90:10:0:true
      MINLEN:40
    inputBinding:
      position: 101
      prefix: --trimmomatic_options_string
  - id: window_around_sgrna
    type:
      - 'null'
      - int
    doc: Window(s) in bp around the cleavage position (half on on each side) as 
      determined by the provide guide RNA sequence to quantify the indels. Any 
      indels outside this window are excluded. A value of 0 disables this 
      filter.
    inputBinding:
      position: 101
      prefix: --window_around_sgrna
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
