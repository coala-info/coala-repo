cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap
label: metawrap-mg_metawrap
doc: "The provided text does not contain help information; it contains system error
  messages regarding a failed container build (no space left on device).\n\nTool homepage:
  https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-mg:1.3.0--hdfd78af_3
stdout: metawrap-mg_metawrap.out
