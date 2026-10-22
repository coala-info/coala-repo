cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - index
label: seidr_index
doc: "Create index for SeidrFiles. The index is written beside the input file with
  the extension .sfi.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: index_file
    type: File
    doc: SeidrFile index (.sfi)
    outputBinding:
      glob: $(inputs.in_file.basename).sfi
  - id: seidr_file
    type: File
    doc: The input SeidrFile, with its index beside it
    secondaryFiles:
      - .sfi
    outputBinding:
      glob: $(inputs.in_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
