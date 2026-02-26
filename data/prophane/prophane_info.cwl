cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophane_info
label: prophane_info
doc: "This is prophane version v6.2.6\n\nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs:
  - id: general_config_file
    type:
      - 'null'
      - File
    doc: General config file
    inputBinding:
      position: 101
  - id: package_install_path
    type:
      - 'null'
      - Directory
    doc: Package install path
    inputBinding:
      position: 101
  - id: snakemake_snakefile
    type:
      - 'null'
      - File
    doc: snakemake Snakefile
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_info.out
