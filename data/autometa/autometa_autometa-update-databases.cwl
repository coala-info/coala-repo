cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-update-databases
label: autometa_autometa-update-databases
doc: "Main script to configure Autometa database dependencies. With no arguments, downloads/formats databases into the default databases directory.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "</path/to/input/database.config>. The default config inside the image is read-only; give a config with home_dir = . to write databases into the output directory."
    inputBinding:
      position: 1
      prefix: --config
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: "Log configuration actions but do not perform them."
    inputBinding:
      position: 1
      prefix: --dryrun
  - id: update_all
    type:
      - 'null'
      - boolean
    doc: "Update all out-of-date databases (does not update GTDB)."
    inputBinding:
      position: 1
      prefix: --update-all
  - id: update_markers
    type:
      - 'null'
      - boolean
    doc: "Update out-of-date markers databases."
    inputBinding:
      position: 1
      prefix: --update-markers
  - id: update_ncbi
    type:
      - 'null'
      - boolean
    doc: "Update out-of-date ncbi databases."
    inputBinding:
      position: 1
      prefix: --update-ncbi
  - id: update_gtdb
    type:
      - 'null'
      - boolean
    doc: "Download and format the user-configured GTDB release databases"
    inputBinding:
      position: 1
      prefix: --update-gtdb
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: "Check database dependencies are satisfied."
    inputBinding:
      position: 1
      prefix: --check-dependencies
  - id: no_checksum
    type:
      - 'null'
      - boolean
    doc: "Do not perform remote checksum comparisons to validate databases are up-to-date."
    inputBinding:
      position: 1
      prefix: --no-checksum
  - id: nproc
    type:
      - 'null'
      - int
    doc: "num. cpus to use for DB formatting."
    inputBinding:
      position: 1
      prefix: --nproc
  - id: out
    type:
      - 'null'
      - string
    doc: "</path/to/output/database.config>"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: config_out
    type: File?
    doc: "Updated database config"
    outputBinding:
      glob: "${ return inputs.out ? inputs.out : []; }"
  - id: databases_dir
    type: Directory?
    doc: "Databases written under the working directory (when the config sets home_dir = .)"
    outputBinding:
      glob: "autometa"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
stdout: autometa-update-databases.out
