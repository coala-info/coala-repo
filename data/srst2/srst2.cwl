cwlVersion: v1.2
class: CommandLineTool
baseCommand: srst2
label: srst2
doc: "SRST2 - Short Read Sequence Typer (v2)\n\nTool homepage: https://github.com/katholt/srst2"
inputs:
  - id: baseq
    type:
      - 'null'
      - int
    doc: Samtools -Q parameter (default 20)
    inputBinding:
      position: 101
      prefix: --baseq
  - id: forward
    type:
      - 'null'
      - string
    doc: Designator for forward reads (only used if NOT in MiSeq format 
      sample_S1_L001_R1_001.fastq.gz; otherwise default is _1, i.e. expect 
      forward reads as sample_1.fastq.gz)
    inputBinding:
      position: 101
      prefix: --forward
  - id: gene_db
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta file/s for gene databases (optional)
    inputBinding:
      position: 101
      prefix: --gene_db
  - id: gene_max_mismatch
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches per read for gene detection and allele 
      calling (default 10)
    inputBinding:
      position: 101
      prefix: --gene_max_mismatch
  - id: input_pe
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired end read files for analysing (may be gzipped)
    inputBinding:
      position: 101
      prefix: --input_pe
  - id: input_se
    type:
      - 'null'
      - type: array
        items: File
    doc: Single end read file(s) for analysing (may be gzipped)
    inputBinding:
      position: 101
      prefix: --input_se
  - id: keep_interim_alignment
    type:
      - 'null'
      - boolean
    doc: Keep interim files (sam & unsorted bam), otherwise they will be deleted
      after sorted bam is created
    inputBinding:
      position: 101
      prefix: --keep_interim_alignment
  - id: log
    type:
      - 'null'
      - boolean
    doc: Switch ON logging to file (otherwise log to stdout)
    inputBinding:
      position: 101
      prefix: --log
  - id: mapq
    type:
      - 'null'
      - int
    doc: Samtools -q parameter (default 1)
    inputBinding:
      position: 101
      prefix: --mapq
  - id: max_divergence
    type:
      - 'null'
      - float
    doc: Maximum %divergence cutoff for gene reporting (default 10)
    inputBinding:
      position: 101
      prefix: --max_divergence
  - id: max_unaligned_overlap
    type:
      - 'null'
      - int
    doc: Read discarded from alignment if either of its ends has unaligned 
      overlap with the reference that is longer than this value (default 10)
    inputBinding:
      position: 101
      prefix: --max_unaligned_overlap
  - id: merge_paired
    type:
      - 'null'
      - boolean
    doc: Switch on if all the input read sets belong to a single sample, and you
      want to merge their data to get a single result
    inputBinding:
      position: 101
      prefix: --merge_paired
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum %coverage cutoff for gene reporting (default 90)
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum mean depth to flag as dubious allele call (default 5)
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_edge_depth
    type:
      - 'null'
      - int
    doc: Minimum edge depth to flag as dubious allele call (default 2)
    inputBinding:
      position: 101
      prefix: --min_edge_depth
  - id: mlst_db
    type:
      - 'null'
      - File
    doc: Fasta file of MLST alleles (optional)
    inputBinding:
      position: 101
      prefix: --mlst_db
  - id: mlst_definitions
    type:
      - 'null'
      - File
    doc: ST definitions for MLST scheme (required if mlst_db supplied and you 
      want to calculate STs)
    inputBinding:
      position: 101
      prefix: --mlst_definitions
  - id: mlst_delimiter
    type:
      - 'null'
      - string
    doc: Character(s) separating gene name from allele number in MLST database 
      (default "-", as in arcc-1)
    inputBinding:
      position: 101
      prefix: --mlst_delimiter
  - id: mlst_max_mismatch
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches per read for MLST allele calling (default 
      10)
    inputBinding:
      position: 101
      prefix: --mlst_max_mismatch
  - id: no_gene_details
    type:
      - 'null'
      - boolean
    doc: Switch OFF verbose reporting of gene typing
    inputBinding:
      position: 101
      prefix: --no_gene_details
  - id: other
    type:
      - 'null'
      - string
    doc: Other arguments to pass to bowtie2 (must be escaped, e.g. "--no-mixed".
    inputBinding:
      position: 101
      prefix: --other
  - id: prev_output
    type:
      - 'null'
      - type: array
        items: File
    doc: SRST2 results files to compile (any new results from this run will also
      be incorporated)
    inputBinding:
      position: 101
      prefix: --prev_output
  - id: prob_err
    type:
      - 'null'
      - float
    doc: Probability of sequencing error (default 0.01)
    inputBinding:
      position: 101
      prefix: --prob_err
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Read file type (for bowtie2; default is q=fastq; other options: qseq=solexa,
      f=fasta).'
    inputBinding:
      position: 101
      prefix: --read_type
  - id: report_all_consensus
    type:
      - 'null'
      - boolean
    doc: Report the consensus allele for the most likely allele. Note, only SNP 
      differences are considered, not indels.
    inputBinding:
      position: 101
      prefix: --report_all_consensus
  - id: report_new_consensus
    type:
      - 'null'
      - boolean
    doc: If a matching alleles is not found, report the consensus allele. Note, 
      only SNP differences are considered, not indels.
    inputBinding:
      position: 101
      prefix: --report_new_consensus
  - id: reverse
    type:
      - 'null'
      - string
    doc: Designator for reverse reads (only used if NOT in MiSeq format 
      sample_S1_L001_R2_001.fastq.gz; otherwise default is _2, i.e. expect 
      forward reads as sample_2.fastq.gz
    inputBinding:
      position: 101
      prefix: --reverse
  - id: samtools_args
    type:
      - 'null'
      - string
    doc: Other arguments to pass to samtools mpileup (must be escaped, e.g. 
      "-A").
    inputBinding:
      position: 101
      prefix: --samtools_args
  - id: save_scores
    type:
      - 'null'
      - boolean
    doc: Switch ON verbose reporting of all scores
    inputBinding:
      position: 101
      prefix: --save_scores
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop mapping after this number of reads have been mapped (otherwise map
      all)
    inputBinding:
      position: 101
      prefix: --stop_after
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multiple threads in Bowtie and Samtools
    inputBinding:
      position: 101
      prefix: --threads
  - id: truncation_score_tolerance
    type:
      - 'null'
      - float
    doc: '% increase in score allowed to choose non-truncated allele'
    inputBinding:
      position: 101
      prefix: --truncation_score_tolerance
  - id: use_existing_bowtie2_sam
    type:
      - 'null'
      - boolean
    doc: Use existing SAM file generated by Bowtie2 if available, otherwise they
      will be generated
    inputBinding:
      position: 101
      prefix: --use_existing_bowtie2_sam
  - id: use_existing_pileup
    type:
      - 'null'
      - boolean
    doc: Use existing pileups if available, otherwise they will be generated
    inputBinding:
      position: 101
      prefix: --use_existing_pileup
  - id: use_existing_scores
    type:
      - 'null'
      - boolean
    doc: Use existing scores files if available, otherwise they will be 
      generated
    inputBinding:
      position: 101
      prefix: --use_existing_scores
outputs:
  - id: output
    type: File
    doc: Prefix for srst2 output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/srst2:v0.2.0-6-deb_cv1
