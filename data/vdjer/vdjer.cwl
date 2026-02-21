cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdjer
label: vdjer
doc: "A tool for generating V(D)J recombinations from high-throughput sequencing data
  (Note: The provided text is an error log and does not contain usage information).\n
  \nTool homepage: https://github.com/mozack/vdjer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vdjer:0.12--h43eeafb_7
stdout: vdjer.out
