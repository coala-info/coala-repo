cwlVersion: v1.2
class: CommandLineTool
baseCommand: ciri-full
label: ciri-full_CIRI-full.jar
doc: "CIRI-full: A complete toolkit for circular RNA identification and reconstruction.
  (Note: The provided text is a container execution error log and does not contain
  CLI help information.)\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_CIRI-full.jar.out
