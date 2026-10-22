cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - reheader
label: seidr_reheader
doc: "Modify SeidrFile headers. Currently only drops disconnected nodes and resets
  stats.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory to store temporary data
    inputBinding:
      position: 102
      prefix: --tempdir
outputs:
  - id: reheadered_file
    type: File
    doc: The input SeidrFile with disconnected nodes dropped and stats reset (seidr reheader modifies the file in place)
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
