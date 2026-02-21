cwlVersion: v1.2
class: CommandLineTool
baseCommand: transindel_transIndel_build_RNA.py
label: transindel_transIndel_build_RNA.py
doc: "The provided text is an error log regarding a container build failure and does
  not contain help text or usage information for the tool.\n\nTool homepage: https://github.com/cauyrd/transIndel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
stdout: transindel_transIndel_build_RNA.py.out
