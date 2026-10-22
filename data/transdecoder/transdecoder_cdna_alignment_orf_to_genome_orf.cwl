cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/opt/transdecoder/util/cdna_alignment_orf_to_genome_orf.pl
label: transdecoder_cdna_alignment_orf_to_genome_orf
doc: "Convert ORF coordinates on transcripts (TransDecoder GFF3) into genome coordinates, using the transcript alignments to the genome. The genome-based GFF3 is written to standard output.\n\nTool homepage: https://transdecoder.github.io"
inputs:
  - id: cdna_orfs_gff3
    type: File
    doc: "ORF predictions on the transcripts (TransDecoder .gff3 file)"
    inputBinding:
      position: 1
  - id: alignments_gff3
    type: File
    doc: "Transcript alignments to the genome in GFF3 format"
    inputBinding:
      position: 2
  - id: cdna_fasta
    type: File
    doc: "Transcript sequences in FASTA format"
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: "ORF predictions in genome coordinates (GFF3)"
stdout: genome_orfs.gff3
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
