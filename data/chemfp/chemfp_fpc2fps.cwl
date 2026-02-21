cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_fpc2fps
label: chemfp_fpc2fps
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a container image due to lack
  of disk space.\n\nTool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp_fpc2fps.out
