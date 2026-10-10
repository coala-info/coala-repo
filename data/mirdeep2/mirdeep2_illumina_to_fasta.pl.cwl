cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - illumina_to_fasta.pl
label: mirdeep2_illumina_to_fasta.pl
doc: "Parse Illumina _seq.txt (or qseq.txt) read files to fasta format; reads are named seq_<number> and dots are converted to N\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: seq_txt
    type: File
    doc: Illumina _seq.txt file (or qseq.txt file with qseq_format)
    inputBinding:
      position: 1
  - id: qseq_format
    type:
      - 'null'
      - boolean
    doc: The input format is qseq.txt
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: fasta
    type: stdout
    doc: Reads in fasta format
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: reads.fa
