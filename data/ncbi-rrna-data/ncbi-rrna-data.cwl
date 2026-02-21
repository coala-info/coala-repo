cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-rrna-data
label: ncbi-rrna-data
doc: "NCBI rRNA data package/tool\n\nTool homepage: https://github.com/MariaAlvBla/NCBI-Tutorial"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-rrna-data:v6.1.20170106-6-deb_cv1
stdout: ncbi-rrna-data.out
