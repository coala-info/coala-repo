cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/opt/transdecoder/util/gff3_file_to_proteins.pl
label: transdecoder_gff3_file_to_proteins
doc: "Extract protein, CDS, cDNA or gene sequences for the features in a GFF3 file from the matching FASTA file. The sequences are written to standard output.\n\nTool homepage: https://transdecoder.github.io"
inputs:
  - id: gff3
    type: File
    doc: "gff3 file"
    inputBinding:
      prefix: --gff3
  - id: fasta
    type: File
    doc: "fasta file corresponding to gff3 file"
    inputBinding:
      prefix: --fasta
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "prot|CDS|cDNA|gene, default=prot"
    inputBinding:
      prefix: --seqType
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: "universal (default), Euplotes, Tetrahymena, Candida, Acetabularia, Mitochondrial-Canonical, Mitochondrial-Vertebrates, and others"
    inputBinding:
      prefix: --genetic_code
outputs:
  - id: output
    type: stdout
    doc: "Extracted sequences in FASTA format"
stdout: gff3_sequences.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
