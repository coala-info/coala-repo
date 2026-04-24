cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi server
label: odgi_server
doc: "Start a basic HTTP server with a given path index file to go from *path:position*
  to *pangenome:position* very efficiently.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph index from this *FILE*. The file name
      usually ends with *.xp*.
    inputBinding:
      position: 101
      prefix: --idx
  - id: ip
    type:
      - 'null'
      - string
    doc: Run the server under this IP address. If not specified, *IP* will be 
      *localhost*.
    inputBinding:
      position: 101
      prefix: --ip
  - id: port
    type: int
    doc: Run the server under this port.
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_server.out
