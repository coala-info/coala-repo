cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal-gv
label: prodigal-gv
doc: "Prodigal-gv: a Prodigal fork with improved gene models for giant viruses and viral genomes (protein-coding gene prediction).\n\nTool homepage: https://github.com/apcamargo/prodigal-gv"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: trans_file
    type:
      - 'null'
      - string
    doc: "Write protein translations to the selected file."
    inputBinding:
      position: 1
      prefix: -a
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: "Closed ends. Do not allow genes to run off edges."
    inputBinding:
      position: 1
      prefix: -c
  - id: nuc_file
    type:
      - 'null'
      - string
    doc: "Write nucleotide sequences of genes to the selected file."
    inputBinding:
      position: 1
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Select output format (gbk, gff, or sco). Default is gbk."
    inputBinding:
      position: 1
      prefix: -f
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Specify a translation table to use (default 11)."
    inputBinding:
      position: 1
      prefix: -g
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Specify FASTA/Genbank input file (default reads from stdin)."
    inputBinding:
      position: 1
      prefix: -i
  - id: mask_n_runs
    type:
      - 'null'
      - boolean
    doc: "Treat runs of N as masked sequence; don't build genes across them."
    inputBinding:
      position: 1
      prefix: -m
  - id: force_motif_scan
    type:
      - 'null'
      - boolean
    doc: "Bypass Shine-Dalgarno trainer and force a full motif scan."
    inputBinding:
      position: 1
      prefix: -n
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Specify output file (default writes to stdout)."
    inputBinding:
      position: 1
      prefix: -o
  - id: procedure_mode
    type:
      - 'null'
      - string
    doc: "Select procedure (single or meta). Default is single."
    inputBinding:
      position: 1
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Run quietly (suppress normal stderr output)."
    inputBinding:
      position: 1
      prefix: -q
  - id: start_file
    type:
      - 'null'
      - string
    doc: "Write all potential genes (with scores) to the selected file."
    inputBinding:
      position: 1
      prefix: -s
  - id: training_file
    type:
      - 'null'
      - File
    doc: "Read and use the specified training file."
    inputBinding:
      position: 1
      prefix: -t
  - id: write_training_file
    type:
      - 'null'
      - string
    doc: "Write a training file with this name (used when no training file exists yet)."
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: output_trans_file
    type:
      - 'null'
      - File
    doc: Protein translations
    outputBinding:
      glob: $(inputs.trans_file)
  - id: output_nuc_file
    type:
      - 'null'
      - File
    doc: Nucleotide sequences of genes
    outputBinding:
      glob: $(inputs.nuc_file)
  - id: output_gene_file
    type:
      - 'null'
      - File
    doc: Gene predictions
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_start_file
    type:
      - 'null'
      - File
    doc: All potential genes with scores
    outputBinding:
      glob: $(inputs.start_file)
  - id: output_training_file
    type:
      - 'null'
      - File
    doc: Training file
    outputBinding:
      glob: $(inputs.write_training_file)
  - id: stdout
    type: stdout
    doc: Gene predictions when no output file is given
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal-gv:2.11.0--he4a0461_4
stdout: prodigal-gv.out
