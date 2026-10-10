cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaparse.pl
label: mirdeep2_fastaparse.pl
doc: "Parse a fasta file: remove short entries and entries with non-nucleotide letters\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: fasta
    type: File
    doc: Fasta file to parse
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Only output entries where the sequence is at least this many nts long
    inputBinding:
      position: 101
      prefix: -a
  - id: remove_non_acgtun
    type:
      - 'null'
      - boolean
    doc: Remove all entries that have a sequence that contains letters other than a,c,g,t,u,n,A,C,G,T,U,N
    inputBinding:
      position: 102
      prefix: -b
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: parsed_fasta
    type: stdout
    doc: Parsed fasta entries
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: parsed.fa
