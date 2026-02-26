cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp package
label: treesapp_package
doc: "Facilitate operations on reference packages\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: subcommand
    type: string
    doc: "A subcommand specifying the type of operation to perform. `treesapp package
      rename` must be followed only by 'prefix' and the new value. Example: `treesapp
      package rename prefix Xyz -r path/to/Xyz_build.pkl`"
    inputBinding:
      position: 1
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
stdout: treesapp_package.out
