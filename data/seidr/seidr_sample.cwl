cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr sample
label: seidr_sample
doc: "Sample edges from a SeidrFile\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of edges to sample
    inputBinding:
      position: 101
      prefix: --fraction
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 101
      prefix: --in-file
  - id: nedges
    type:
      - 'null'
      - int
    doc: Number of edges to sample
    inputBinding:
      position: 101
      prefix: --nedges
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of significant digits to report
    inputBinding:
      position: 101
      prefix: --precision
  - id: replacement
    type:
      - 'null'
      - boolean
    doc: Sample with replacement
    inputBinding:
      position: 101
      prefix: --replacement
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
