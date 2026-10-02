cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prodigal
label: prodigal
doc: 'PRODIGAL: fast, reliable protein-coding gene prediction for prokaryotic genomes'
inputs:
  - id: trans_file
    type:
      - 'null'
      - string
    doc: Write protein translations to the selected file.
    inputBinding:
      position: 101
      prefix: -a
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: -c
  - id: nuc_file
    type:
      - 'null'
      - string
    doc: Write nucleotide sequences of genes to the selected file.
    inputBinding:
      position: 101
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: Select output format (gbk, gff, or sco). Default is gbk.
    inputBinding:
      position: 101
      prefix: -f
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Specify a translation table to use (default 11).
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type:
      - 'null'
      - File
    doc: Specify input file (default reads from stdin).
    inputBinding:
      position: 101
      prefix: -i
  - id: mask_runs_of_ns
    type:
      - 'null'
      - boolean
    doc: Treat runs of n's as masked sequence and do not build genes across 
      them.
    inputBinding:
      position: 101
      prefix: -m
  - id: bypass_sd_trainer
    type:
      - 'null'
      - boolean
    doc: Bypass the Shine-Dalgarno trainer and force the program to scan for 
      motifs.
    inputBinding:
      position: 101
      prefix: -n
  - id: output_file
    type:
      - 'null'
      - string
    doc: Specify output file (default writes to stdout).
    inputBinding:
      position: 101
      prefix: -o
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta). Default is single.
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly (suppress normal stderr output).
    inputBinding:
      position: 101
      prefix: -q
  - id: score_file
    type:
      - 'null'
      - string
    doc: Write all potential genes (with scores) to the selected file.
    inputBinding:
      position: 101
      prefix: -s
  - id: training_file
    type:
      - 'null'
      - File
    doc: Write a training file (if none exists); otherwise, read and use the 
      specified training file.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_trans_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    outputBinding:
      glob: $(inputs.trans_file)
  - id: output_nuc_file
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    outputBinding:
      glob: $(inputs.nuc_file)
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Specify output file (default writes to stdout).
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_score_file
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
    outputBinding:
      glob: $(inputs.score_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal:2.60--1
s:url: https://github.com/hyattpd/Prodigal
$namespaces:
  s: https://schema.org/
