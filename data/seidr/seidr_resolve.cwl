cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - resolve
label: seidr_resolve
doc: "Resolve node indices in text file to node names.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: format
    type:
      - 'null'
      - string
    doc: File format to resolve
    inputBinding:
      position: 102
      prefix: --format
  - id: seidr_file
    type:
      - 'null'
      - File
    doc: Seidr file which should be used to resolve input
    inputBinding:
      position: 102
      prefix: --seidr-file
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
