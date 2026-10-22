cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - abundance
label: tksm_abundance
doc: "Output a TSV file of the long-read transcript expression\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: paf
    type: File
    doc: "PAF file of the mapping of the long-reads to the reference transcriptome."
    inputBinding:
      position: 1
      prefix: --paf
  - id: lr_br
    type:
      - 'null'
      - File
    doc: "TSV output of the long-reads barcode matching from scTagger (e.g. S1.lr_matches.tsv.gz)"
    inputBinding:
      position: 1
      prefix: -m
  - id: cb_count
    type:
      - 'null'
      - int
    doc: "Number of cell barcodes to simulate. If >0, the abundance is split by cell barcodes according to a normal distribution. Cannot be used with --lr-br."
    inputBinding:
      position: 1
      prefix: --cb-count
  - id: cb_lognorm_params
    type:
      - 'null'
      - string
    doc: "Parameters for the lognormal distribution of cell barcodes abundance: mean and standard deviation, comma-separated. (default: 10,1)"
    inputBinding:
      position: 1
      prefix: --cb-lognorm-params
  - id: cb_pattern
    type:
      - 'null'
      - string
    doc: "FASTA pattern for the cell barcode. If used, --cb-count must also be used. (default: NNNNNNNNNNNN)"
    inputBinding:
      position: 1
      prefix: --cb-pattern
  - id: cb_dropout
    type:
      - 'null'
      - float
    doc: "Fraction of reads without cell barcodes. If used, --cb-count must also be used. (default: 0.2)"
    inputBinding:
      position: 1
      prefix: --cb-dropout
  - id: cb_txt
    type:
      - 'null'
      - File
    doc: "Text file of cell barcodes whitelist, one per line. If used, --cb-count must also be used. Do not use with --cb-pattern."
    inputBinding:
      position: 1
      prefix: --cb-txt
  - id: output
    type: string
    doc: "Path for the output file (e.g. cDNA.abundance.tsv or cDNA.abundance.tsv.gz). Gzipped if it ends with .gz."
    inputBinding:
      position: 1
      prefix: --output
  - id: em_iterations
    type:
      - 'null'
      - int
    doc: "Number of EM iterations"
    inputBinding:
      position: 1
      prefix: -em
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed"
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity"
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: abundance_table
    type: File
    doc: "Transcript abundance table (transcript_id, tpm, cell)"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_abundance.out
