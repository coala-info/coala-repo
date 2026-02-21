cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashmap
label: mashmap
doc: "A fast approximate aligner for long DNA sequences\n\nTool homepage: https://github.com/marbl/MashMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashmap:3.1.3--pl5321hb4818e0_2
stdout: mashmap.out
