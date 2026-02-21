cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - Bam2SVG
label: jvarkit_Bam2SVG
doc: "A tool to convert BAM files to SVG format. (Note: The provided help text contains
  only system error messages and no argument definitions.)\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_Bam2SVG.out
