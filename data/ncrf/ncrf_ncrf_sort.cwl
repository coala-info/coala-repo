cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_sort
label: ncrf_ncrf_sort
doc: "Sorts NCRF alignments by match ratio, score, match count, length, name or position.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: ncrf_file
    type: File
    doc: "Output from ncrf_cat (or NCRF), read from standard input"
  - id: sortby
    type:
      - 'null'
      - string
    doc: "sort key: mratio, score, match, length, position (add - or + for decreasing or increasing) or name"
    inputBinding:
      position: 10
      prefix: "--sortby="
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdin: $(inputs.ncrf_file.path)
stdout: ncrf_ncrf_sort.out
