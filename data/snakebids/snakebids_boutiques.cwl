cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakebids boutiques
label: snakebids_boutiques
doc: "Generate a Boutiques descriptor for a Snakebids app.\n\nTool homepage: https://github.com/khanlab/snakebids"
inputs:
  - id: out_path
    type: File
    doc: Path for the output Boutiques descriptor. Should be a .json file.
    inputBinding:
      position: 1
  - id: app_dir
    type:
      - 'null'
      - Directory
    doc: Location of the Snakebids app. Defaults to the current directory.
    default: .
    inputBinding:
      position: 102
      prefix: --app_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakebids:0.15.0--pyhdfd78af_0
stdout: snakebids_boutiques.out
