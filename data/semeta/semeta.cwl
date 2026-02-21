cwlVersion: v1.2
class: CommandLineTool
baseCommand: semeta
label: semeta
doc: "Sensitive and efficient metagenomic taxonomic classification\n\nTool homepage:
  http://it.hcmute.edu.vn/bioinfo/metapro/SeMeta.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semeta:1.0--0
stdout: semeta.out
