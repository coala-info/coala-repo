cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mvirs
  - oprs
label: mvirs_oprs
doc: "Localisation of inducible prophages using NGS data\n\nTool homepage: https://github.com/SushiLab/mVIRs"
inputs:
  - id: allow_full_contigs
    type:
      - 'null'
      - boolean
    doc: Allow full contigs/scaffolds/chromosomes to be reported (When OPRs and 
      clipped reads are found at the start and end of contigs/scaffolds/
    inputBinding:
      position: 101
      prefix: -m
  - id: forward_reads
    type: File
    doc: Forward reads file. FastA/Q. Can be gzipped.
    inputBinding:
      position: 101
      prefix: -f
  - id: max_sequence_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length for extraction..
    inputBinding:
      position: 101
      prefix: -ML
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length for extraction..
    inputBinding:
      position: 101
      prefix: -ml
  - id: reference_database
    type: File
    doc: Reference database file (prefix) created by mvirs index.
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    inputBinding:
      position: 101
      prefix: -db
  - id: reverse_reads
    type: File
    doc: Reverse reads file. FastA/Q. Can be gzipped.
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: -t
  - id: output_prefix_path
    type: string
    doc: PATH   Prefix for output file. [Required]
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: bam
    type: File
    doc: Alignments of the reads against the reference (<prefix>.bam).
    outputBinding:
      glob: $(inputs.output_prefix_path).bam
  - id: oprs
    type: File
    doc: Outward-oriented read pairs (<prefix>.oprs).
    outputBinding:
      glob: $(inputs.output_prefix_path).oprs
  - id: clipped
    type: File
    doc: Clipped read alignments (<prefix>.clipped).
    outputBinding:
      glob: $(inputs.output_prefix_path).clipped
  - id: prophages_fasta
    type: File
    doc: Sequences of the potential prophages (<prefix>.fasta).
    outputBinding:
      glob: $(inputs.output_prefix_path).fasta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
