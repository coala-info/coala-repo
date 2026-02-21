cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxaqr
label: metaxaqr
doc: "MetaxaQR (Metaxa2 Query Router) - No description available from the provided
  text.\n\nTool homepage: http://microbiology.se/software/metaxaQR/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxaqr:3.0rc1.1--py314pl5321hdfd78af_0
stdout: metaxaqr.out
