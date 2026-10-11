cwlVersion: v1.2
class: CommandLineTool
baseCommand: path_to_fasta
label: oatk_path_to_fasta
doc: "Extracts FASTA sequences from a GFA file given a path.\n\nTool homepage: https://github.com/c-zhou/oatk"
inputs:
  - id: gfa_file
    type: File
    doc: Assembly graph file in GFA format (plain or gzipped).
    inputBinding:
      position: 1
  - id: path_str
    type:
      - 'null'
      - string
    doc: Path string, for example u1+,u2-,u3-,u2+.
    inputBinding:
      position: 2
  - id: path_file
    type:
      - 'null'
      - File
    doc: Two-column path file.
    inputBinding:
      position: 102
      prefix: -p
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output results to FILE (default is standard output).
    inputBinding:
      position: 102
      prefix: -o
  - id: sequence_id
    type:
      - 'null'
      - string
    doc: Output sequence id.
    inputBinding:
      position: 102
      prefix: -s
  - id: line_length
    type:
      - 'null'
      - int
    doc: Number of residues per line; 0 for 2^31-1.
    inputBinding:
      position: 102
      prefix: -l
  - id: n_gap_length
    type:
      - 'null'
      - int
    doc: Number of 'n' put between sequences with no links.
    inputBinding:
      position: 102
      prefix: -n
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level.
    inputBinding:
      position: 102
      prefix: -v
  - id: linear
    type:
      - 'null'
      - boolean
    doc: Force linear output.
    inputBinding:
      position: 102
      prefix: --linear
outputs:
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: FASTA file written when output_file is given
    outputBinding:
      glob: "$(inputs.output_file ? inputs.output_file : 'no_output_file_given')"
  - id: stdout
    type: stdout
    doc: Extracted FASTA sequences
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0--h577a1d6_1
stdout: oatk_path_to_fasta.fasta
