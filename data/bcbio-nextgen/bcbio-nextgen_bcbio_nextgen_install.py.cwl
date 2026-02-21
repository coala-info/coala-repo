cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_nextgen_install.py
label: bcbio-nextgen_bcbio_nextgen_install.py
doc: "Installation script for bcbio-nextgen (Note: The provided text appears to be
  a system log/error message rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/bcbio/bcbio-nextgen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen:1.0.5--py27_0
stdout: bcbio-nextgen_bcbio_nextgen_install.py.out
