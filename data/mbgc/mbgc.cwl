cwlVersion: v1.2
class: CommandLineTool
baseCommand: mbgc
label: mbgc
doc: "Multiple Bacteria Genome Compressor (MBGC)\n\nTool homepage: https://github.com/kowallus/mbgc"
inputs:
  - id: archive_file
    type: File
    doc: mbgc archive filename. For standard input in decompression, set 
      <archiveFile> to -
    inputBinding:
      position: 1
  - id: exclude_pattern
    type:
      - 'null'
      - string
    doc: exclude files with names not containing pattern
    inputBinding:
      position: 102
      prefix: -e
  - id: exclude_patterns_file
    type:
      - 'null'
      - File
    doc: exclude files not matching any pattern (name of text file with list of 
      patterns in separate lines). Excludes files not matching any pattern (does
      not invalidate -e option)
    inputBinding:
      position: 102
      prefix: -E
  - id: ignore_fasta_paths
    type:
      - 'null'
      - boolean
    doc: ignore FASTA file paths (use only filenames)
    inputBinding:
      position: 102
      prefix: -I
  - id: list_sequence_headers
    type:
      - 'null'
      - boolean
    doc: 'list sequence headers (using convention: ">sequencename>filename")'
    inputBinding:
      position: 102
      prefix: -H
  - id: redirect_stderr
    type:
      - 'null'
      - boolean
    doc: redirect app output to stderr
    inputBinding:
      position: 102
      prefix: '-2'
  - id: threads
    type:
      - 'null'
      - int
    doc: set limit of used threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
stdout: mbgc.out
