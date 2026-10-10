cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq2fasta.pl
label: mirdeep2_fastq2fasta.pl
doc: "Convert a fastq file to fasta format; reads are renamed seq_<number>\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: fastq
    type: File
    doc: Fastq file with the reads
    inputBinding:
      position: 1
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
