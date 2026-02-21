cwlVersion: v1.2
class: CommandLineTool
baseCommand: calisp_calisp.py
label: calisp_calisp.py
doc: "The provided text is an error log from a failed container build process ('no
  space left on device') and does not contain the help text or usage information for
  calisp_calisp.py. As a result, arguments could not be extracted.\n\nTool homepage:
  https://github.com/kinestetika/Calisp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0
stdout: calisp_calisp.py.out
