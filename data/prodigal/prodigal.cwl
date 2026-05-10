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
    inputBinding:
      position: 101
      prefix: -f
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta).
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
  - id: gff_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `gff_output_file_path`
    inputBinding:
      position: 102
      prefix: --gff-output-file
  - id: nucleotide_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `nucleotide_output_file_path`
    inputBinding:
      position: 103
      prefix: --nucleotide-output-file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
  - id: protein_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `protein_output_file_path`
    inputBinding:
      position: 105
      prefix: --protein-output-file
  - id: starts_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `starts_output_file_path`
    inputBinding:
      position: 106
      prefix: --starts-output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file (default writes to stdout).
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: protein_output_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    outputBinding:
      glob: $(inputs.protein_output_file_path)
  - id: nucleotide_output_file
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    outputBinding:
      glob: $(inputs.nucleotide_output_file_path)
  - id: gff_output_file
    type:
      - 'null'
      - File
    doc: Write GFF output to the selected file.
    outputBinding:
      glob: $(inputs.gff_output_file_path)
  - id: starts_output_file
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
    outputBinding:
      glob: $(inputs.starts_output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal:2.60--1
