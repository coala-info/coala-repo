cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_100_summarize_outputs
label: mvip_MVP_100_summarize_outputs
doc: "Summarize outputs and create figures.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force execution of all steps, even if final_annotation_output_file 
      exists.
    inputBinding:
      position: 101
      prefix: --force
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_100_summarize_outputs.out
