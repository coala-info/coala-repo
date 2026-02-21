cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmseqs2-server
label: mmseqs2-server
doc: "MMseqs2 server (Note: The provided text is a container execution error log and
  does not contain help information or argument definitions).\n\nTool homepage: https://github.com/soedinglab/MMseqs2-App"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2-server:8.c4b9644--he881be0_1
stdout: mmseqs2-server.out
