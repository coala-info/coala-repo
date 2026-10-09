cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - masks
label: lexicmap_utils_masks
doc: "View masks of the index or generate new masks randomly.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: index
    type:
      - 'null'
      - Directory
    doc: 'Index directory created by "lexicmap index".'
    inputBinding:
      position: 1
      prefix: -d
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Maximum k-mer size. K needs to be <= 32. [31]'
    inputBinding:
      position: 2
      prefix: -k
  - id: masks
    type:
      - 'null'
      - int
    doc: 'Number of masks. [40000]'
    inputBinding:
      position: 3
      prefix: -m
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports and recommends a ".gz" suffix'
    inputBinding:
      position: 4
      prefix: -o
  - id: prefix
    type:
      - 'null'
      - int
    doc: 'Length of mask k-mer prefix for checking low-complexity (0 for no checking). [15]'
    inputBinding:
      position: 5
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: 'The seed for generating random masks. [1]'
    inputBinding:
      position: 6
      prefix: -s
  - id: infile_list
    type:
      - 'null'
      - File
    doc: 'File of input file list (one file per line). If given, they are appended to files from CLI arguments.'
    inputBinding:
      position: 90
      prefix: -X
  - id: log
    type:
      - 'null'
      - string
    doc: 'Log file.'
    inputBinding:
      position: 91
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not print any verbose information. But you can write them to a file with --log.'
    inputBinding:
      position: 92
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. By default, it uses all available cores.'
    inputBinding:
      position: 93
      prefix: -j
outputs:
  - id: output
    type: File?
    doc: 'The masks'
    outputBinding:
      glob: $(inputs.out_file)
  - id: log_out
    type: File?
    doc: 'Log file, written when log is set'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
