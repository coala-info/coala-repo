cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa-hybrid
label: jaffa_jaffa-hybrid
doc: "JAFFA (Joining Assemblies For Fusion Analysis) hybrid pipeline. (Note: The provided
  text is a container runtime error log and does not contain usage instructions or
  argument definitions.)\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_jaffa-hybrid.out
