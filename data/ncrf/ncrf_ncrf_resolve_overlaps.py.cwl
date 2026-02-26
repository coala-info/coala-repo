cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_resolve_overlaps
label: ncrf_ncrf_resolve_overlaps.py
doc: "Resolves overlaps in alignment summaries.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: alignment_summary
    type:
      type: array
      items: File
    doc: File(s) containing alignment summaries for which overlaps are to be 
      resolved.
    inputBinding:
      position: 1
  - id: head
    type:
      - 'null'
      - int
    doc: Limit the number of input alignment summaries.
    inputBinding:
      position: 102
      prefix: --head
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: File to write overlap groups to. If this option is absent, all output 
      is written to the console.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
