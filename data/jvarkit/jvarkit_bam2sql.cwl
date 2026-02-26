cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2sql
label: jvarkit_bam2sql
doc: "Convert BAM files to SQL\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: print cigar data
    default: false
    inputBinding:
      position: 102
      prefix: --cigar
  - id: flag
    type:
      - 'null'
      - boolean
    doc: expands details about sam flag
    default: false
    inputBinding:
      position: 102
      prefix: --flag
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml]
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: reference
    type: File
    doc: "Indexed fasta Reference file. This file must be indexed with samtools \n\
      \      faidx and with picard/gatk CreateSequenceDictionary or samtools dict"
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: "An interval as the following syntax : \"chrom:start-end\" or \n      \"\
      chrom:middle+extend\"  or \"chrom:start-end+extend\" or \n      \"chrom:start-end+extend-percent%\"\
      .A program might use a Reference \n      sequence to fix the chromosome name
      (e.g: 1->chr1)"
    default: ''
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file. Optional .
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
