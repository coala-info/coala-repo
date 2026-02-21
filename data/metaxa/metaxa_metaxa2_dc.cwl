cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dc
label: metaxa_metaxa2_dc
doc: "Metaxa2 Diversity Collector\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_dc.out
