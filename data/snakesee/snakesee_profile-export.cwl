cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesee profile-export
label: snakesee_profile-export
doc: "Export timing profile from workflow metadata.\n\nCreates a portable JSON file
  containing historical timing data that can\nbe shared across machines or used to
  bootstrap estimates for new runs.\n\nTool homepage: https://github.com/nh13/snakesee"
inputs:
  - id: workflow_dir
    type:
      - 'null'
      - Directory
    doc: Path to workflow directory containing .snakemake/.
    inputBinding:
      position: 1
  - id: merge
    type:
      - 'null'
      - boolean
    doc: If output file exists, merge with existing data instead of replacing.
    inputBinding:
      position: 102
      prefix: --merge
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path. Defaults to .snakesee-profile.json in workflow_dir.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
