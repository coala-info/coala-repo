cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - VcfGrantham
label: jvarkit_VcfGrantham
doc: "A tool from the jvarkit suite. (Note: The provided help text contains system
  error messages regarding container execution and does not list specific tool arguments
  or descriptions.)\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_VcfGrantham.out
