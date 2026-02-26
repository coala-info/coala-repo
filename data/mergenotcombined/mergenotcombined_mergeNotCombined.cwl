cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergeNotCombined
label: mergenotcombined_mergeNotCombined
doc: "Merge Forward and reverse reads\n\nTool homepage: https://github.com/andvides/mergeNotCombined.git"
inputs:
  - id: f1_fastq
    type: File
    doc: Forward reads file
    inputBinding:
      position: 1
  - id: r1_fastq
    type: File
    doc: Reverse reads file
    inputBinding:
      position: 2
  - id: join_string
    type: string
    doc: String to join forward and reverse read names
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mergenotcombined:1.0--h503566f_4
stdout: mergenotcombined_mergeNotCombined.out
