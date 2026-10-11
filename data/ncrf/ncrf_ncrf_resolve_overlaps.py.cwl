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
    doc: "(cumulative) file(s) containing alignment summaries for which overlaps are to be resolved (usually the output from ncrf_summary)"
    inputBinding:
      position: 1
  - id: head
    type:
      - 'null'
      - int
    doc: limit the number of input alignment summaries
    inputBinding:
      position: 2
      prefix: --head=
      separate: false
  - id: out_path
    type:
      - 'null'
      - string
    doc: "file to write overlap groups to; a name template, which may include {motif} (replaced by a motif name); if absent, all output is written to the console"
    inputBinding:
      position: 2
      prefix: --out=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out
    type:
      type: array
      items: File
    doc: files written for the name template
    outputBinding:
      glob: "$(inputs.out_path ? [inputs.out_path.replace('{motif}', '*')] : [])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_resolve_overlaps.py.out
