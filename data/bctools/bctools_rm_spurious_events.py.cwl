cwlVersion: v1.2
class: CommandLineTool
baseCommand: rm_spurious_events.py
label: bctools_rm_spurious_events.py
doc: "Remove spurious events originating from errors in random sequence tags.\n\n\
  This script compares all events sharing the same coordinates. Among each group\n\
  of events the maximum number of PCR duplicates is determined. All events that\n\
  are supported by less than 10 percent of this maximum count are removed.\n\nTool
  homepage: https://github.com/dmaticzka/bctools"
inputs:
  - id: events
    type: File
    doc: Path to bed6 file containing alignments.
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information
    inputBinding:
      position: 102
      prefix: --debug
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for spurious event removal.
    inputBinding:
      position: 102
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type: File
    doc: Write results to this file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
