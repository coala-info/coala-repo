cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dbb
label: metaxa_metaxa2_dbb
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run a container due to insufficient disk space.\n\nTool homepage:
  http://microbiology.se/software/metaxa2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_dbb.out
