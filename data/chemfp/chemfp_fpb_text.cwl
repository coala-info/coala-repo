cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_fpb_text
label: chemfp_fpb_text
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp_fpb_text.out
