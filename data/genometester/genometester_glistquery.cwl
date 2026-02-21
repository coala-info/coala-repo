cwlVersion: v1.2
class: CommandLineTool
baseCommand: glistquery
label: genometester_glistquery
doc: "A tool from the GenomeTester4 package for querying k-mer lists.\n\nTool homepage:
  https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_glistquery.out
