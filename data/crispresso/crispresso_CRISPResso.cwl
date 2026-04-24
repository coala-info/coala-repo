cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPResso
label: crispresso_CRISPResso
doc: "Analysis of CRISPR/Cas9 outcomes from deep sequencing data\n\nTool homepage:
  https://github.com/lucapinello/CRISPResso"
inputs:
  - id: amplicon_seq
    type: string
    doc: Amplicon Sequence
    inputBinding:
      position: 101
      prefix: --amplicon_seq
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
  - id: coding_seq
    type:
      - 'null'
      - string
    doc: Subsequence/s of the amplicon sequence covering one or more coding 
      sequences for the frameshift analysis.If more than one (for example, split
      by intron/s), please separate by comma.
    inputBinding:
      position: 101
      prefix: --coding_seq
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print stack trace on error.
    inputBinding:
      position: 101
      prefix: --debug
  - id: donor_seq
    type:
      - 'null'
      - string
    doc: Donor Sequence. This optional input comprises a subsequence of the 
      expected HDR amplicon to be highlighted in plots.
    inputBinding:
      position: 101
      prefix: --donor_seq
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
  - id: expected_hdr_amplicon_seq
    type:
      - 'null'
      - string
    doc: Amplicon sequence expected after HDR
    inputBinding:
      position: 101
      prefix: --expected_hdr_amplicon_seq
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
  - id: guide_seq
    type:
      - 'null'
      - string
    doc: sgRNA sequence, if more than one, please separate by comma/s. Note that
      the sgRNA needs to be input as the guide RNA sequence (usually 20 nt) 
      immediately adjacent to but not including the PAM sequence (5' of NGG for 
      SpCas9). If the PAM is found on the opposite strand with respect to the 
      Amplicon Sequence, ensure the sgRNA sequence is also found on the opposite
      strand. The CRISPResso convention is to depict the expected cleavage 
      position using the value of the parameter cleavage_offset nt 3' from the 
      end of the guide. In addition, the use of alternate nucleases to SpCas9 is
      supported. For example, if using the Cpf1 system, enter the sequence 
      (usually 20 nt) immediately 3' of the PAM sequence and explicitly set the 
      cleavage_offset parameter to 1, since the default setting of -3 is 
      suitable only for SpCas9.
    inputBinding:
      position: 101
      prefix: --guide_seq
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
    doc: Parameter for the FLASH merging step. Maximum overlap length expected 
      in approximately 90% of read pairs. Please see the FLASH manual for more 
      information.
    inputBinding:
      position: 101
      prefix: --max_paired_end_reads_overlap
  - id: max_rows_alleles_around_cut_to_plot
    type:
      - 'null'
      - int
    doc: Maximum number of rows to report in the alleles table plot.
    inputBinding:
      position: 101
      prefix: --max_rows_alleles_around_cut_to_plot
  - id: min_average_read_quality
    type:
      - 'null'
      - int
    doc: Minimum average quality score (phred33) to keep a read
    inputBinding:
      position: 101
      prefix: --min_average_read_quality
  - id: min_frequency_alleles_around_cut_to_plot
    type:
      - 'null'
      - float
    doc: Minimum % reads required to report an allele in the alleles table plot.
    inputBinding:
      position: 101
      prefix: --min_frequency_alleles_around_cut_to_plot
  - id: min_identity_score
    type:
      - 'null'
      - float
    doc: Minimum identity score for the alignment
    inputBinding:
      position: 101
      prefix: --min_identity_score
  - id: min_paired_end_reads_overlap
    type:
      - 'null'
      - int
    doc: Parameter for the FLASH read merging step. Minimum required overlap 
      length between two reads to provide a confident overlap.
    inputBinding:
      position: 101
      prefix: --min_paired_end_reads_overlap
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
  - id: offset_around_cut_to_plot
    type:
      - 'null'
      - int
    doc: Offset to use to summarize alleles around the cut site in the alleles 
      table plot.
    inputBinding:
      position: 101
      prefix: --offset_around_cut_to_plot
  - id: save_also_png
    type:
      - 'null'
      - boolean
    doc: Save also .png images additionally to .pdf files
    inputBinding:
      position: 101
      prefix: --save_also_png
  - id: split_paired_end
    type:
      - 'null'
      - boolean
    doc: Splits a single fastq file contating paired end reads in two files 
      before running CRISPResso
    inputBinding:
      position: 101
      prefix: --split_paired_end
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
