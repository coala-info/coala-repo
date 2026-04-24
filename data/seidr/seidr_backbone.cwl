cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr backbone
label: seidr_backbone
doc: "Determine noisy network backbone scores. Optionally filter on these scores.\n\
  \nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: filter
    type:
      - 'null'
      - float
    doc: Subset network to edges with at least this SD. 1.28, 1.64, and 2.32 
      correspond to ~P0.1, 0.05 and 0.01.
    inputBinding:
      position: 102
      prefix: --filter
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: index
    type:
      - 'null'
      - int
    doc: Score index to use
    inputBinding:
      position: 102
      prefix: --index
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary data
    inputBinding:
      position: 102
      prefix: --tempdir
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
