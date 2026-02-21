cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - analysis-archive
label: anchore-cli_analysis-archive
doc: "Manage the analysis archive in Anchore Engine, allowing for archiving and restoring
  image analysis data.\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute within the analysis-archive context (e.g., list,
      get, add, delete, restore).
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the specified command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_analysis-archive.out
