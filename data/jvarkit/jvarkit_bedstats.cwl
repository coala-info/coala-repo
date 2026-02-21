cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bedstats
label: jvarkit_bedstats
doc: "The provided help text contains only system error messages related to a container
  runtime failure ('no space left on device') and does not contain usage information
  or argument definitions for the tool.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bedstats.out
