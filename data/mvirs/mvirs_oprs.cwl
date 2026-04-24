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
outputs:
  - id: output_prefix
    type: Directory
    doc: Prefix for output file.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
