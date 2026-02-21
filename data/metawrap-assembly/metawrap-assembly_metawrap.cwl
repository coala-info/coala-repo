cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - assembly
label: metawrap-assembly_metawrap
doc: "The provided text contains system error messages related to a container runtime
  failure and does not include the tool's help documentation. No arguments could be
  parsed.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3
stdout: metawrap-assembly_metawrap.out
