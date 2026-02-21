cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigCat
label: ucsc-bigwigcat
doc: "Concatenate multiple bigWig files into a single bigWig file. Note: The input
  help text provided was a container execution error; the following arguments represent
  the standard usage for this tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input bigWig files to concatenate
    inputBinding:
      position: 1
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set a minimum value threshold for inclusion
    inputBinding:
      position: 102
      prefix: -threshold
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    default: 1
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type: File
    doc: The output bigWig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcat:482--h0b57e2e_0
