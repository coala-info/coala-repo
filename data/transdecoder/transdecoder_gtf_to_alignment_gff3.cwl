cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/opt/transdecoder/util/gtf_to_alignment_gff3.pl
label: transdecoder_gtf_to_alignment_gff3
doc: "Convert a GTF file of transcript structures to GFF3 cDNA-to-genome alignments. The GFF3 is written to standard output.\n\nTool homepage: https://transdecoder.github.io"
inputs:
  - id: gtf_file
    type: File
    doc: "Transcript structures in GTF format (for example from Cufflinks)"
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: "Transcript alignments in GFF3 format"
stdout: transcripts.alignment.gff3
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
