cwlVersion: v1.2
class: CommandLineTool
baseCommand: minirmd
label: minirmd
doc: "v1, by Yuansheng Liu, October 2020.\n\nTool homepage: https://github.com/yuansliu/minirmd"
inputs:
  - id: allowed_mismatch
    type:
      - 'null'
      - int
    doc: number of allowed mismatch
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: reads file
    inputBinding:
      position: 101
      prefix: -i
  - id: k_values_file
    type:
      - 'null'
      - File
    doc: the file to store values of k
    inputBinding:
      position: 101
      prefix: -k
  - id: paired_end_file
    type:
      - 'null'
      - File
    doc: reads file, if paired end
    inputBinding:
      position: 101
      prefix: -f
  - id: remove_duplicates_reverse_complement
    type:
      - 'null'
      - boolean
    doc: remove duplicates on reverse-complement strand
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: the output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minirmd:1.1--hd03093a_2
