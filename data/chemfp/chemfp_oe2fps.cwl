cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_oe2fps
label: chemfp_oe2fps
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp_oe2fps.out
