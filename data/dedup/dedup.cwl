cwlVersion: v1.2
class: CommandLineTool
baseCommand: dedup
label: dedup
doc: "DeDup tool for deduplicating reads.\n\nTool homepage: https://github.com/apeltzer/dedup"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input file if this option is not specified, the input is expected 
      to be piped in
    inputBinding:
      position: 101
      prefix: --input
  - id: merged
    type:
      - 'null'
      - boolean
    doc: the input only contains merged reads. If this option is specified read 
      names are not examined for prefixes. Both the start and end of the 
      aligment are considered for all reads.
    inputBinding:
      position: 101
      prefix: --merged
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: Do not automatically sort the output
    inputBinding:
      position: 101
      prefix: --unsorted
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: the output folder. Has to be specified if input is set.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dedup:0.12.9--hdfd78af_0
