cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - aplanat
  - demo
label: aplanat_demo
doc: "Aplanat demo component (Note: The provided help text is a Python traceback indicating
  a missing dependency 'sigfig' and does not contain argument details).\n\nTool homepage:
  https://github.com/epi2me-labs/aplanat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aplanat:0.5.6--pyhfa5458b_0
stdout: aplanat_demo.out
