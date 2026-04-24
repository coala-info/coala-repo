cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_merge.py
label: gs-tama_tama_merge.py
doc: "This script merges transcriptomes.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: cds_source
    type:
      - 'null'
      - string
    doc: Use CDS from a merge source. Specify source name from filelist file 
      here.
    inputBinding:
      position: 101
      prefix: -cds
  - id: collapse_exon_ends
    type:
      - 'null'
      - string
    doc: 'Collapse exon ends flag: common_ends or longest_ends'
    inputBinding:
      position: 101
      prefix: -e
  - id: exon_ends_threshold
    type:
      - 'null'
      - int
    doc: Exon ends threshold/ splice junction threshold
    inputBinding:
      position: 101
      prefix: -m
  - id: file_list
    type:
      - 'null'
      - File
    doc: File list
    inputBinding:
      position: 101
      prefix: -f
  - id: gene_transcript_id_source
    type:
      - 'null'
      - string
    doc: Use gene and transcript ID from a merge source. Specify source name 
      from filelist file here.
    inputBinding:
      position: 101
      prefix: -s
  - id: merge_duplicate_groups
    type:
      - 'null'
      - string
    doc: Flag for merging duplicate transcript groups (default no_merge quits 
      when duplicates are found, merge_dup will merge duplicates)
    inputBinding:
      position: 101
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: prime_3_threshold
    type:
      - 'null'
      - int
    doc: 3 prime threshold
    inputBinding:
      position: 101
      prefix: -z
  - id: prime_5_threshold
    type:
      - 'null'
      - int
    doc: 5 prime threshold
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_merge.py.out
