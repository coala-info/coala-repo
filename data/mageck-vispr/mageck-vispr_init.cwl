cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck-vispr init
label: mageck-vispr_init
doc: "MAGeCK-VISPR is a comprehensive quality control, analysis and visualization
  pipeline for CRISPR/Cas9 screens.\n\nTool homepage: https://bitbucket.org/liulab/mageck-vispr"
inputs:
  - id: directory
    type: Directory
    doc: Path to the directory where the workflow shall be initialized.
    inputBinding:
      position: 1
  - id: keep_config
    type:
      - 'null'
      - boolean
    doc: Keep existing config file.
    inputBinding:
      position: 102
      prefix: --keep-config
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to FastQ files with reads that shall be added to the config file.
      You can edit the sample sample names and assignment to experiments in the 
      config file.
    inputBinding:
      position: 102
      prefix: --reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
stdout: mageck-vispr_init.out
