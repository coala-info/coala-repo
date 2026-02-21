cwlVersion: v1.2
class: CommandLineTool
baseCommand: any2fasta
label: any2fasta
doc: "Convert various sequence formats into FASTA\n\nTool homepage: https://github.com/tseemann/any2fasta"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: Input sequence file(s) (gb, fa, fq, gff, gfa, clw, sth and compressed variants)
    inputBinding:
      position: 1
  - id: include_version
    type:
      - 'null'
      - boolean
    doc: Include VERSION (GENBANK,EMBL)
    inputBinding:
      position: 102
      prefix: -g
  - id: lowercase
    type:
      - 'null'
      - boolean
    doc: Lowercase the sequence
    inputBinding:
      position: 102
      prefix: -l
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No output while running, only errors
    inputBinding:
      position: 102
      prefix: -q
  - id: replace_non_agtc
    type:
      - 'null'
      - boolean
    doc: Replace non-[AGTC] with 'N'
    inputBinding:
      position: 102
      prefix: -n
  - id: skip_bad_files
    type:
      - 'null'
      - boolean
    doc: Skip, don't die, on bad input files
    inputBinding:
      position: 102
      prefix: -k
  - id: strip_descriptions
    type:
      - 'null'
      - boolean
    doc: Strip sequence descriptions (FASTA,FASTQ)
    inputBinding:
      position: 102
      prefix: -s
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: Uppercase the sequence
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/any2fasta:0.8.1--hdfd78af_0
stdout: any2fasta.out
