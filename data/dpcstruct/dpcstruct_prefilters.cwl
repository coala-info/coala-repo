cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dpcstruct
  - prefilters
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
    type:
      - 'null'
      - float
    doc: 'Gaps threshold (default: 0.2)'
    inputBinding:
      position: 101
      prefix: -g
  - id: lddt_threshold
    type:
      - 'null'
      - float
    doc: 'LDDT threshold (default: 0.4)'
    inputBinding:
      position: 101
      prefix: -l
  - id: plddt_threshold
    type:
      - 'null'
      - float
    doc: 'PLDDT threshold (default: 60.0)'
    inputBinding:
      position: 101
      prefix: -q
  - id: plddts
    type:
      - 'null'
      - Directory
    doc: path to PLDDTs directory (optional; the pLDDT filter is skipped without it)
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
    type:
      - 'null'
      - float
    doc: 'TM-score threshold (default: 0.4)'
    inputBinding:
      position: 101
      prefix: -t
  - id: output_path
    type: string
    doc: output file of filtered alignments (the help calls it a directory, but the tool writes one file)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: filtered alignments file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
