cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bam2sql
label: jvarkit_bam2sql
doc: "Convert a BAM file to SQL statements.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: print cigar data
    inputBinding:
      position: 1
      prefix: --cigar
  - id: flag
    type:
      - 'null'
      - boolean
    doc: expands details about sam flag
    inputBinding:
      position: 2
      prefix: --flag
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 3
      prefix: --out
  - id: reference
    type: File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 4
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: "An interval as the following syntax : \"chrom:start-end\" or \"chrom:middle+extend\" or \"chrom:start-end+extend\" or \"chrom:start-end+extend-percent%\". A program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)"
    inputBinding:
      position: 5
      prefix: --region
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bam2sql.out
