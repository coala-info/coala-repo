cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal-gv
label: prodigal-gv
doc: "PRODIGAL v2.11.0-gv [March, 2023]\nUniv of Tenn / Oak Ridge National Lab\nDoug
  Hyatt, Loren Hauser, et al.\n\nTool homepage: https://github.com/apcamargo/prodigal-gv"
inputs:
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: -c
  - id: force_motif_scan
    type:
      - 'null'
      - boolean
    doc: Bypass Shine-Dalgarno trainer and force a full motif scan.
    inputBinding:
      position: 101
      prefix: -n
  - id: input_file
    type:
      - 'null'
      - File
    doc: Specify FASTA/Genbank input file (default reads from stdin).
    default: reads from stdin
    inputBinding:
      position: 101
      prefix: -i
  - id: mask_n_runs
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence; don't build genes across them.
    inputBinding:
      position: 101
      prefix: -m
  - id: nuc_file
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    inputBinding:
      position: 101
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: Select output format (gbk, gff, or sco).
    default: gbk
    inputBinding:
      position: 101
      prefix: -f
  - id: procedure_mode
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta). Default is single.
    default: single
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
  - id: start_file
    type:
      - 'null'
      - File
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
  - id: trans_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    inputBinding:
      position: 101
      prefix: -a
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Specify a translation table to use (default 11).
    default: 11
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file (default writes to stdout).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal-gv:2.11.0--he4a0461_4
