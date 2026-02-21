cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - c_curve
label: preseq_c_curve
doc: "The c_curve command in preseq computes the expected complexity curve (number
  of distinct reads vs. total number of reads) for a genomic sequencing library.\n
  \nTool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: Input file in BED, BAM, or MR format
    inputBinding:
      position: 1
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: Input is in BAM format
    inputBinding:
      position: 102
      prefix: -B
  - id: defects
    type:
      - 'null'
      - boolean
    doc: Output defects in the library
    inputBinding:
      position: 102
      prefix: -D
  - id: pe_mode
    type:
      - 'null'
      - boolean
    doc: Input is paired-end
    inputBinding:
      position: 102
      prefix: -P
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the complexity curve
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
