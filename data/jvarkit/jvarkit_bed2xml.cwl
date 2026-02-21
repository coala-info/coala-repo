cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bed2xml
label: jvarkit_bed2xml
doc: "Convert BED files to XML format. (Note: The provided text contains only system
  error messages regarding container execution and does not list specific tool arguments.)\n
  \nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bed2xml.out
