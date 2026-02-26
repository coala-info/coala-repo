cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viguno
  - convert
label: viguno_convert
doc: "Convert HPO text files to binary format\n\nTool homepage: https://github.com/bihealth/viguno"
inputs:
  - id: path_hpo_dir
    type: Directory
    doc: Path to the directory with the HPO files
    inputBinding:
      position: 101
      prefix: --path-hpo-dir
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: path_out_bin
    type: File
    doc: Path to the output binary file
    outputBinding:
      glob: $(inputs.path_out_bin)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
