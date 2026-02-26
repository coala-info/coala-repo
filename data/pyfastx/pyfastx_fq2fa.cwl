cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx fq2fa
label: pyfastx_fq2fa
doc: "Converts FASTQ to FASTA format.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: fastq file, gzip support
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file, default: output to stdout'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
