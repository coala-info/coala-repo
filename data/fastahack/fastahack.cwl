cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastahack
label: fastahack
doc: "fastahack is a small tool for indexing and extracting sequences from FASTA files.\n\
  \nTool homepage: https://github.com/ekg/fastahack"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
inputs:
  - id: fasta_file
    type: File
    doc: The FASTA file to be indexed or queried. It is staged writable so that
      the index (.fai) is written next to it.
    inputBinding:
      position: 100
      valueFrom: $(self.basename)
  - id: index
    type:
      - 'null'
      - boolean
    doc: Generate a fasta index <fasta reference>.fai.
    inputBinding:
      position: 1
      prefix: --index
  - id: region
    type:
      - 'null'
      - string
    doc: 'Print the specified region. REGION is of the form <seq>, <seq>:<start>[sep]<end>,
      <seq1>:<start>[sep]<seq2>:<end>, where start and end are 1-based and [sep]
      is "-" or "..".'
    inputBinding:
      position: 1
      prefix: --region
  - id: read_regions_from_stdin
    type:
      - 'null'
      - boolean
    doc: Read a stream of line-delimited region specifiers on stdin and print
      the corresponding sequence for each on stdout (use with regions_file).
    inputBinding:
      position: 1
      prefix: --stdin
  - id: regions_file
    type:
      - 'null'
      - File
    doc: File of line-delimited region specifiers, sent to stdin of the tool
      (use with read_regions_from_stdin).
  - id: entropy
    type:
      - 'null'
      - boolean
    doc: Print the shannon entropy of the specified region.
    inputBinding:
      position: 1
      prefix: --entropy
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Print the fasta file in the form 'seq_name <tab> sequence'.
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fasta_index
    type:
      - 'null'
      - File
    doc: The fasta index written by --index.
    outputBinding:
      glob: '*.fai'
stdin: "$(inputs.regions_file ? inputs.regions_file.path : null)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastahack:2016.07.2--0
stdout: fastahack.out
