cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - qgramfreq
label: sqt_qgramfreq
doc: "Print q-gram (also called k-mer) frequencies in a FASTA or FASTQ file.\n\nTool
  homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: fasta_fastq
    type: File
    doc: input FASTA or FASTQ file
    inputBinding:
      position: 1
  - id: q_gram_length
    type:
      - 'null'
      - int
    doc: length of the q-grams (also called k-mers)
    default: 4
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_qgramfreq.out
