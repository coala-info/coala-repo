cwlVersion: v1.2
class: CommandLineTool
baseCommand: pispino_pispino_createreadpairslist
label: pispino_pispino_createreadpairslist
doc: "makes a read_pairs_list.\n\nTool homepage: https://github.com/hsgweon/pispino"
inputs:
  - id: ignore_name_clash
    type:
      - 'null'
      - boolean
    doc: Ignore name clash and create a mapping file anyway.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_dir
    type: Directory
    doc: Directory with your raw sequences in gzipped FASTQ
    inputBinding:
      position: 101
      prefix: -i
  - id: label_add_c_end
    type:
      - 'null'
      - string
    doc: Add a label to the END of each sample ids in the output file. N.B. "_" 
      is not allowed
    inputBinding:
      position: 101
      prefix: --label-add-c-end
  - id: label_add_c_front
    type:
      - 'null'
      - string
    doc: Add a label to the FRONT of each sample ids in the output file. N.B. 
      "_" is not allowed
    inputBinding:
      position: 101
      prefix: --label-add-c-front
  - id: label_reindex_c
    type:
      - 'null'
      - string
    doc: Rename samples with the given label. It will automatically add 001, 002
      etc. at the end of each name. N.B. "_" is not allowed
    inputBinding:
      position: 101
      prefix: --label-reindex-c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output list file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pispino:1.1--py35_0
