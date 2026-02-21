cwlVersion: v1.2
class: CommandLineTool
baseCommand: samhaplotag
label: samhaplotag_16BaseBCGen
doc: "A tool for haplotype tagging of SAM/BAM files. Note: The provided input text
  appears to be a container engine error log rather than the tool's help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/wtsi-hpag/SamHaplotag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samhaplotag:0.0.4--h9948957_4
stdout: samhaplotag_16BaseBCGen.out
