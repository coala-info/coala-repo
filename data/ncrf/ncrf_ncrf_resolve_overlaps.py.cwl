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
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: File to write overlap groups to. If this option is absent, all output 
      is written to the console.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
