cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - reverse-comp
label: rdp-readseq_reverse-comp
doc: "Reverse complement sequences (RevComplement).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: infile
    type: File
    doc: "Input fasta file"
    inputBinding:
      position: 1
      prefix: --infile
  - id: outfile
    type: string
    doc: "Output file"
    inputBinding:
      position: 2
      prefix: --outfile
  - id: check_orientation
    type:
      - 'null'
      - boolean
    doc: "If set, check the orientation of the rRNA sequence and reverse complement only if needed"
    inputBinding:
      position: 3
      prefix: --check
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format, fasta or fastq. Default is fasta"
    inputBinding:
      position: 4
      prefix: --format
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "Output sequence file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
