cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2fasta
label: multiz_maf2fasta
doc: "maf2fasta: convert a MAF alignment to FASTA, using the reference sequence file. Usage: maf2fasta refseq-file maf-file [beg end] [fasta[2]][?] [iupac2n] [refsrc=src]. The result goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: refseq_file
    type: File
    doc: Reference sequence file (FASTA)
    inputBinding:
      position: 1
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 2
  - id: beg
    type:
      - 'null'
      - int
    doc: Start position on the reference (give together with end)
    inputBinding:
      position: 3
  - id: end
    type:
      - 'null'
      - int
    doc: End position on the reference (give together with beg)
    inputBinding:
      position: 4
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Write FASTA output (fasta)
    inputBinding:
      position: 5
      valueFrom: "$(self ? \"fasta\" : null)"
  - id: fasta2
    type:
      - 'null'
      - boolean
    doc: "Write FASTA output, variant 2 (fasta2)"
    inputBinding:
      position: 6
      valueFrom: "$(self ? \"fasta2\" : null)"
  - id: iupac2n
    type:
      - 'null'
      - boolean
    doc: Convert IUPAC codes to N (iupac2n)
    inputBinding:
      position: 7
      valueFrom: "$(self ? \"iupac2n\" : null)"
  - id: refsrc
    type:
      - 'null'
      - string
    doc: Source name of the reference (refsrc=)
    inputBinding:
      position: 8
      prefix: refsrc=
      separate: false
outputs:
  - id: fasta_out
    type: stdout
    doc: Alignment text (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf2fasta.out
