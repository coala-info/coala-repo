cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx_subseq
label: pyfastx_subseq
doc: "Extract subsequences from FASTA/FASTQ files.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: input fasta file, gzip support
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: format is chr:start-end, start and end position is 1-based, multiple 
      regions were separated by space
    inputBinding:
      position: 2
  - id: bed_file
    type:
      - 'null'
      - File
    doc: tab-delimited BED file, 0-based start position and 1-based end position
    inputBinding:
      position: 103
      prefix: --bed-file
  - id: region_file
    type:
      - 'null'
      - File
    doc: tab-delimited file, one region per line, both start and end position 
      are 1-based
    inputBinding:
      position: 103
      prefix: --region-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: 'output file, default: output to stdout'
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
