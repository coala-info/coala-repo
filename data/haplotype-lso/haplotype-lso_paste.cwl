cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - paste
label: haplotype-lso_paste
doc: "Prepare modified copies of the reference sequences by inserting BLAST matches into them.\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: keep_masked
    type:
      - 'null'
      - string
    doc: "Keep masked reference sequence (mostly useful for debugging purposes)."
    inputBinding:
      position: 1
      prefix: --keep-masked
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files (default hlso_paste_out.d/)"
    inputBinding:
      position: 1
      prefix: --output-prefix
  - id: seq_files
    type:
      type: array
      items: File
    doc: "Sequence files (FASTA, FASTQ, AB1, SCF)"
    inputBinding:
      position: 2
outputs:
  - id: pasted
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Directories with the pasted sequences, one per reference sequence"
    outputBinding:
      glob: $((inputs.output_prefix || 'hlso_paste_out.d/') + '*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
