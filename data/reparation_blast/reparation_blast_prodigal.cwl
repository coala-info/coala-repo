cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal
label: reparation_blast_prodigal
doc: "PRODIGAL v2.6.3 [February, 2016] Univ of Tenn / Oak Ridge National Lab Doug
  Hyatt, Loren Hauser, et al.\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
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
  - id: nucleotide_file
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
    inputBinding:
      position: 101
      prefix: -f
  - id: potential_genes_file
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
    inputBinding:
      position: 101
      prefix: -s
  - id: procedure_mode
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta). Default is single.
    inputBinding:
      position: 101
      prefix: -p
  - id: protein_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    inputBinding:
      position: 101
      prefix: -a
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly (suppress normal stderr output).
    inputBinding:
      position: 101
      prefix: -q
  - id: training_file
    type:
      - 'null'
      - File
    doc: Write a training file (if none exists); otherwise, read and use the 
      specified training file.
    inputBinding:
      position: 101
      prefix: -t
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Specify a translation table to use (default 11).
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
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
