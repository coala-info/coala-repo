cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/opt/transdecoder/util/gtf_genome_to_cdna_fasta.pl
label: transdecoder_gtf_genome_to_cdna_fasta
doc: "Extract the transcript (cDNA) sequences described in a Cufflinks or StringTie GTF file from a genome FASTA file. The FASTA is written to standard output.\n\nTool homepage: https://transdecoder.github.io"
inputs:
  - id: gtf_file
    type: File
    doc: "Transcript structures in GTF format (for example from Cufflinks)"
    inputBinding:
      position: 1
  - id: genome_fasta
    type: File
    doc: "Genome sequence in FASTA format"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: "Transcript sequences in FASTA format"
stdout: transcripts.cdna.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
