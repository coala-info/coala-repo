cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
label: lexicmap_utils
doc: "Some utilities\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: command
    type: string
    doc: 'Available Commands: 2blast, edit-genome-ids, genomes, kmers, masks, merge-search-results,
      reindex-seeds, remerge, seed-pos, subseq'
    inputBinding:
      position: 1
  - id: infile_list
    type:
      - 'null'
      - string
    doc: File of input file list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to a file 
      with --log.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. By default, it uses all available cores.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
stdout: lexicmap_utils.out
