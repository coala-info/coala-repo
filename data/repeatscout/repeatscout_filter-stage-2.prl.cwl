cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-stage-2.prl
label: repeatscout_filter-stage-2.prl
doc: "Filter a repeat library by number of occurrences in RepeatMasker output. Reads
  the library from standard input.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: repeat_library
    type: File
    doc: Fasta-formatted repeat library, read from standard input. Each entry is named
      like ">name then whatever you want here"
  - id: repeatmasker_output
    type: File
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
stdin: $(inputs.repeat_library.path)
outputs:
  - id: filtered_library
    type: stdout
    doc: Filtered repeat library
stdout: $(inputs.repeat_library.nameroot).filter2.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
