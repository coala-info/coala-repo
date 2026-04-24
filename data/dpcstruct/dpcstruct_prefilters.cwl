cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct prefilters
label: dpcstruct_prefilters
doc: "Filters alignments based on quality metrics.\n\nTool homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: alignments
    type: File
    doc: path to alignments file
    inputBinding:
      position: 101
      prefix: -i
  - id: gaps_threshold
    type: float
    doc: Gaps threshold
    inputBinding:
      position: 101
      prefix: -g
  - id: lddt_threshold
    type: float
    doc: LDDT threshold
    inputBinding:
      position: 101
      prefix: -l
  - id: plddt_threshold
    type: float
    doc: PLDDT threshold
    inputBinding:
      position: 101
      prefix: -q
  - id: plddts
    type: Directory
    doc: path to PLDDTs directory
    inputBinding:
      position: 101
      prefix: -p
  - id: prots_lookup
    type: File
    doc: protein lookup file
    inputBinding:
      position: 101
      prefix: -m
  - id: tm_threshold
    type: float
    doc: TM-score threshold
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
