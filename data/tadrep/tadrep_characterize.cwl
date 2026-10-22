cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_characterize
doc: "Import json file from a given database path into working directory\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory to store blast hits
    inputBinding:
      position: 3
      prefix: --tmp-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default = None)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: state_dir
    type:
      - 'null'
      - Directory
    doc: Output directory of a previous TaDReP step (database, extract, characterize, cluster, detect), which is staged writable and used as the working directory
  - id: database
    type:
      - 'null'
      - File
    doc: Import json file from a given database path into working directory
    inputBinding:
      position: 101
      prefix: --db
  - id: inc_types
    type:
      - 'null'
      - File
    doc: Import inc-types from given path into working directory
    inputBinding:
      position: 101
      prefix: --inc-types
outputs:
  - id: tadrep_out
    type: Directory
    doc: TaDReP output directory (working directory for the next step)
    outputBinding:
      glob: tadrep_out
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 5
    prefix: --output
    valueFrom: tadrep_out
  - position: 10
    valueFrom: characterize
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_characterize.out
