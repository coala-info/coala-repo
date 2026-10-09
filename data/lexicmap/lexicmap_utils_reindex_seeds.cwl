cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - reindex-seeds
label: lexicmap_utils_reindex_seeds
doc: "Recreate indexes of k-mer-value (seeds) data.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: index
    type: Directory
    doc: 'Index directory created by "lexicmap index" (a writable copy is reindexed).'
    inputBinding:
      position: 1
      prefix: -d
  - id: partitions
    type:
      - 'null'
      - int
    doc: 'Number of partitions for re-indexing seeds (k-mer-value data) files. The value needs to be the power of 4. [4096]'
    inputBinding:
      position: 2
      prefix: --partitions
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
  - id: reindexed_index
    type: Directory
    doc: 'The index directory with re-indexed seeds'
    outputBinding:
      glob: $(inputs.index.basename)
  - id: log_out
    type: File?
    doc: 'Log file, written when log is set'
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
