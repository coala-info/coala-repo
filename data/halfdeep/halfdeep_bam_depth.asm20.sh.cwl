cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_bam_depth.asm20.sh
label: halfdeep_bam_depth.asm20.sh
doc: "A tool for BAM depth analysis (Note: The provided help text contains only system
  error messages regarding container execution and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_bam_depth.asm20.sh.out
