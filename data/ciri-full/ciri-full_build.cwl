cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CIRI-full
  - Build
label: ciri-full_build
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a failed container build process (no space left on
  device).\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_build.out
