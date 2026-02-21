cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmcalibrate
label: infernal_cmcalibrate
doc: "Fit exponential tails for covariance model E-value determination. Note: The
  provided text contains system error logs rather than help text; arguments are derived
  from standard tool documentation.\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: The covariance model file to calibrate
    inputBinding:
      position: 1
  - id: forecast
    type:
      - 'null'
      - int
    doc: Forecast time required for calibration for <n> processors
    inputBinding:
      position: 102
      prefix: --forecast
  - id: mem
    type:
      - 'null'
      - float
    doc: Set required memory to <x> Mb
    inputBinding:
      position: 102
      prefix: --mem
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: Run as an MPI parallel program
    inputBinding:
      position: 102
      prefix: --mpi
  - id: procs
    type:
      - 'null'
      - int
    doc: Set number of processors to <n>
    inputBinding:
      position: 102
      prefix: --procs
  - id: search_length
    type:
      - 'null'
      - float
    doc: Set total length of sequences to search to <x> Mb
    inputBinding:
      position: 102
      prefix: -L
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmcalibrate.out
