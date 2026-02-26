cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - threshold
label: seidr_threshold
doc: "Pick hard network threshold according to topology\n\nTool homepage: https://github.com/bschiffthaler/seidr"
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
  - id: index
    type:
      - 'null'
      - string
    doc: Score column to use as edge weights
    inputBinding:
      position: 102
      prefix: --index
  - id: max
    type:
      - 'null'
      - float
    doc: Highest threshold value to check
    default: 0.0
    inputBinding:
      position: 102
      prefix: --max
  - id: min
    type:
      - 'null'
      - float
    doc: Lowest threshold value to check
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min
  - id: nsteps
    type:
      - 'null'
      - int
    doc: Number of breaks to create for testing
    default: 100
    inputBinding:
      position: 102
      prefix: --nsteps
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of decimal points to print
    default: 8
    inputBinding:
      position: 102
      prefix: --precision
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads for parallel sorting
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
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
