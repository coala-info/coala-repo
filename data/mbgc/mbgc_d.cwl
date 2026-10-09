cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mbgc
  - d
label: mbgc_d
doc: "Decompress FASTA file(s) from an MBGC archive\n\nTool homepage: https://github.com/kowallus/mbgc"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: archive_file
    type: File
    doc: "mbgc archive filename"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "extraction target path root (created by the tool)"
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: "overwrite an existing output files"
    inputBinding:
      position: 102
      prefix: -f
  - id: gz_level
    type:
      - 'null'
      - int
    doc: "extract FASTA files to gz archives (compression level: 1 <= z <= 12, recommended: 2)"
    inputBinding:
      position: 102
      prefix: -z
  - id: bases_per_row
    type:
      - 'null'
      - int
    doc: "custom format of decoded sequences (0 - unlimited)"
    inputBinding:
      position: 102
      prefix: -l
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
  - id: output
    type: Directory
    doc: Directory with the extracted FASTA files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
