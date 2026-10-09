cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mbgc
  - i
label: mbgc_i
doc: "Info about MBGC archive contents (FASTA file names and headers)\n\nTool homepage: https://github.com/kowallus/mbgc"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: archive_file
    type: File
    doc: "mbgc archive filename"
    inputBinding:
      position: 1
  - id: list_sequence_headers
    type:
      - 'null'
      - boolean
    doc: "list sequence headers (using convention: \">sequencename>filename\")"
    inputBinding:
      position: 102
      prefix: -H
  - id: exclude_pattern
    type:
      - 'null'
      - string
    doc: "exclude files with names not containing pattern"
    inputBinding:
      position: 102
      prefix: -e
  - id: exclude_patterns_file
    type:
      - 'null'
      - File
    doc: "exclude files not matching any pattern (name of text file with list of patterns in separate lines)"
    inputBinding:
      position: 102
      prefix: -E
  - id: threads
    type:
      - 'null'
      - int
    doc: "set limit of used threads"
    inputBinding:
      position: 102
      prefix: -t
  - id: ignore_fasta_paths
    type:
      - 'null'
      - boolean
    doc: "ignore FASTA file paths (use only filenames)"
    inputBinding:
      position: 102
      prefix: -I
  - id: redirect_stderr
    type:
      - 'null'
      - boolean
    doc: "redirect app output to stderr"
    inputBinding:
      position: 102
      prefix: '-2'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
stdout: mbgc_i.out
