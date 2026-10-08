cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli-mpi
label: garli-mpi
doc: "This MPI version is for doing a large number of search replicates or bootstrap
  replicates, each using the SAME config file. The results will be exactly identical
  to those obtained by executing the config file a comparable number of times with
  the serial version of the program. The program expects a config file named garli.conf
  in the working directory.\n\nTool homepage: https://code.google.com/archive/p/garli/"
inputs:
  - id: num_jobs
    type: int
    doc: Number of times to execute config file
    inputBinding:
      position: 1
      valueFrom: -$(self)
  - id: config_file
    type: File
    doc: Config file, staged as garli.conf in the working directory
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (data matrix, starting tree, constraint file), staged in the working directory so the names resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (ofprefix) of the config file
    outputBinding:
      glob:
        - "*.log*.log"
        - "*.best*.tre"
        - "*.best*.phy"
        - "*.boot.tre"
        - "*.screen.log"
        - "*.sitelikes.log"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: garli.conf
        entry: $(inputs.config_file)
      - $(inputs.data_files || [])
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli-mpi:v2.1-3-deb_cv1
stdout: garli-mpi.out
