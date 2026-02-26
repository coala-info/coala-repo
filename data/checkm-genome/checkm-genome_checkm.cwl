cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm
label: checkm-genome_checkm
doc: "CheckM is a tool for assessing the quality of microbial genome bins.\n\nTool
  homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., tree, qa, lineage_wf)
    inputBinding:
      position: 1
  - id: checkm_data_dir
    type:
      - 'null'
      - Directory
    doc: Specify the location of CheckM database files. Use 'checkm data setRoot
      <checkm_data_dir>' to set this.
    inputBinding:
      position: 102
      prefix: --checkm_data_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm.out
