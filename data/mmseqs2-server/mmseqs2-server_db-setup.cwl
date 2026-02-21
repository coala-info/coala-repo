cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs2-server
  - db-setup
label: mmseqs2-server_db-setup
doc: "Setup database for mmseqs2-server (Note: The provided text contains system error
  logs regarding container execution and disk space rather than tool help documentation).\n
  \nTool homepage: https://github.com/soedinglab/MMseqs2-App"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2-server:8.c4b9644--he881be0_1
stdout: mmseqs2-server_db-setup.out
