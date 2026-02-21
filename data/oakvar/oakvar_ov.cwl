cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oakvar
  - ov
label: oakvar_ov
doc: "OakVar genomic variant analysis platform. (Note: The provided text consists
  of system error logs regarding a container runtime failure and does not contain
  CLI help documentation or argument definitions.)\n\nTool homepage: http://www.oakvar.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.24--pyhdfd78af_0
stdout: oakvar_ov.out
