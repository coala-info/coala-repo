cwlVersion: v1.2
class: CommandLineTool
baseCommand: detonate
label: detonate
doc: "DETONATE (DE novo TranscriptOme rNa-seq Assembly Evaluation) is a software package
  for the evaluation of de novo transcriptome assemblies. (Note: The provided help
  text contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/deweylab/detonate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/detonate:1.11--boost1.64_1
stdout: detonate.out
