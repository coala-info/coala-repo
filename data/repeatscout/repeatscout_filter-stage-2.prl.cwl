cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-stage-2.prl
label: repeatscout_filter-stage-2.prl
doc: "Filter a repeat library by number of occurrences\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs:
  - id: repeatmasker_output
    type:
      - 'null'
      - File
    doc: The RepeatMasker output file. It can either be a .cat file or a .out 
      file, but a .out file is preferred.
    inputBinding:
      position: 101
      prefix: --cat
  - id: threshold
    type:
      - 'null'
      - int
    doc: The number of times a sequence must appear for it to be reported.
    inputBinding:
      position: 101
      prefix: --thresh
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_filter-stage-2.prl.out
