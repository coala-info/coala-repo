cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal
label: prodigal
doc: "Fast, reliable protein-coding gene prediction for prokaryotic genomes.\n\nTool
  homepage: https://github.com/hyattpd/Prodigal"
inputs:
  - id: bypass_shine_dalgarno
    type:
      - 'null'
      - boolean
    doc: Bypass Shine-Dalgarno trainer and force the program to scan for motifs.
    inputBinding:
      position: 101
      prefix: -n
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: Specify FASTA/Genbank input file (default reads from stdin).
    inputBinding:
      position: 101
      prefix: -i
  - id: mask_n
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence; do not build genes across them.
    inputBinding:
      position: 101
      prefix: -m
  - id: output_format
    type:
      - 'null'
      - string
    doc: Select output format (gbk, gff, or sco).
    default: gbk
    inputBinding:
      position: 101
      prefix: -f
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta).
    default: single
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly (suppress stats output to stderr).
    inputBinding:
      position: 101
      prefix: -q
  - id: training_file
    type:
      - 'null'
      - File
    doc: Specify a training file (if not specified, prodigal will learn the 
      parameters from the input).
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file (default writes to stdout).
    outputBinding:
      glob: $(inputs.output_file)
  - id: protein_output_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    outputBinding:
      glob: $(inputs.protein_output_file)
  - id: nucleotide_output_file
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    outputBinding:
      glob: $(inputs.nucleotide_output_file)
  - id: gff_output_file
    type:
      - 'null'
      - File
    doc: Write GFF output to the selected file.
    outputBinding:
      glob: $(inputs.gff_output_file)
  - id: starts_output_file
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
    outputBinding:
      glob: $(inputs.starts_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal:2.60--1
