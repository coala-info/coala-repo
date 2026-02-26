cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - defense-finder
  - update
label: defense-finder_update
doc: "Fetches the latest defense finder models.\n\nTool homepage: https://github.com/mdmparis/defense-finder"
inputs:
  - id: force_reinstall
    type:
      - 'null'
      - boolean
    doc: Force update even if models in already there.
    inputBinding:
      position: 101
      prefix: --force-reinstall
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Specify a directory containing your models.
    inputBinding:
      position: 101
      prefix: --models-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/defense-finder:2.0.1--pyhdfd78af_0
stdout: defense-finder_update.out
