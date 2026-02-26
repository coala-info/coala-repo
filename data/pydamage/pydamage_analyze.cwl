cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
  - analyze
label: pydamage_analyze
doc: "Analyze BAM files for DNA damage.\n\nTool homepage: https://github.com/maxibor/pydamage"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
stdout: pydamage_analyze.out
