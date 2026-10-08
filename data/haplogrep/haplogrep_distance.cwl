cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep
  - distance
label: haplogrep_distance
doc: "Calculate the distance between mtDNA haplogroups.\n\nTool homepage: https://github.com/seppinho/haplogrep-cmd"
inputs:
  - id: input
    type: File
    doc: input haplogroups
    inputBinding:
      position: 101
      prefix: --in
  - id: out
    type: string
    doc: output haplogroups including distance
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: distances
    type: File
    doc: Haplogroups including distance
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
