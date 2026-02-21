cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfkit
label: vcfkit
doc: "VCF-kit is a command-line tool for summarizing, analyzing, and manipulating
  VCF files. (Note: The provided text was a container build error log and did not
  contain help documentation; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/AndersenLab/VCF-kit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit.out
