cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinysink
label: tinysink
doc: "Help documentation for tinysink.\n\nTool homepage: https://github.com/mbhall88/tinysink"
inputs:
  - id: destination_directory
    type: Directory
    doc: Directory on the server where files will be synchronised to 
      (DESTINATION).
    inputBinding:
      position: 101
      prefix: --Directory on the server where files will be synchronised to 
        (DESTINATION)
  - id: server_name
    type: string
    doc: Server name to transfer to.
    inputBinding:
      position: 101
      prefix: --Server name to transfer to
  - id: source_directory
    type: Directory
    doc: Directory to synchronise with server (SOURCE).
    inputBinding:
      position: 101
      prefix: --Directory to synchronise with server (SOURCE)
  - id: username
    type: string
    doc: User name to log into the server with.
    inputBinding:
      position: 101
      prefix: --User name to log into the server with
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinysink:1.0--0
stdout: tinysink.out
