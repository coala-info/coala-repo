cwlVersion: v1.2
class: CommandLineTool
baseCommand: nomadic download
label: nomadic_download
doc: "Download target reference genome by specifying a `reference_name`, or download
  all available genomes with the `--all` flag\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Download all reference genomes available.
    inputBinding:
      position: 101
      prefix: --all
  - id: reference_name
    type:
      - 'null'
      - string
    doc: Choose a reference genome to download by name.
    inputBinding:
      position: 101
      prefix: --reference_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_download.out
