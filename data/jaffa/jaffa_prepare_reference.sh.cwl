cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa_prepare_reference.sh
label: jaffa_prepare_reference.sh
doc: "Prepare reference files for JAFFA\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_prepare_reference.sh.out
