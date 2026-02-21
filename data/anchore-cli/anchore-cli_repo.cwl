cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - repo
label: anchore-cli_repo
doc: "Manage repositories in Anchore Engine, including adding, deleting, listing,
  and controlling watch status.\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: 'The command to execute: add (Add a repository), del (Delete a repository),
      get (Get a repository), list (List added repositories), unwatch (Stop automatically
      watching), or watch (Start automatically watching).'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_repo.out
