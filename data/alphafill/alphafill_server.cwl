cwlVersion: v1.2
class: CommandLineTool
baseCommand: alphafill
label: alphafill_server
doc: "AlphaFill is a tool to process AlphaFold structures by filling in missing compounds.
  It can create indices from PDB files or process AlphaFill structures.\n\nTool homepage:
  https://alphafill.eu"
inputs:
  - id: command
    type: string
    doc: "The command to execute: 'create-index' (Create a FastA file based on data
      in the PDB files) or 'process' (Process an AlphaFill structure)"
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file to use
    default: alphafill.conf
    inputBinding:
      position: 102
      prefix: --config
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not produce warnings or status messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alphafill:2.2.0--haf24da9_0
stdout: alphafill_server.out
