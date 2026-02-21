cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_ob2fps
label: chemfp_ob2fps
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container image
  due to insufficient disk space.\n\nTool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp_ob2fps.out
