cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - gtf2xml
label: jvarkit_gtf2xml
doc: "Convert GTF (Gene Transfer Format) files to XML.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_gtf2xml.out
