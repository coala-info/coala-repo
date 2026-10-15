cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popscle, plp-make-dge-matrix]
label: popscle_plp-make-dge-matrix
doc: "Make a digital expression matrix (gene, exon, transcript) from digital pileups.\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: plp
    type: string
    doc: "Prefix of the input pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz)"
    inputBinding:
      position: 1
      prefix: --plp
  - id: gtf
    type:
      - 'null'
      - File
    doc: "GTF-formatted file for gene/transcript annotation"
    inputBinding:
      position: 1
      prefix: --gtf
  - id: gtf_remove_chr
    type:
      - 'null'
      - boolean
    doc: "Remove 'chr' prefix from input GTF file Default: OFF"
    inputBinding:
      position: 1
      prefix: --gtf-remove-chr
  - id: gtf_add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' prefix from input GTF file Default: OFF"
    inputBinding:
      position: 1
      prefix: --gtf-add-chr
  - id: gene_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gene-type
    doc: "Gene types to include to produce DGE matrix (e.g. protein-coding) (repeat the option for several values)"
    inputBinding:
      position: 1
  - id: common_gene_types
    type:
      - 'null'
      - boolean
    doc: "Load only common gene types, searching for specific gene types - protein_coding, lincRNA, antisense, IG_ and TR_ genes Default: OFF"
    inputBinding:
      position: 1
      prefix: --common-gene-types
  - id: create_gene_transcript
    type:
      - 'null'
      - boolean
    doc: "Create genes and transcripts if not exist in GTF Default: OFF"
    inputBinding:
      position: 1
      prefix: --create-gene-transcript
  - id: out
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 1
      prefix: --out
  - id: uniq_bin
    type:
      - 'null'
      - int
    doc: "Bin size to uniquely count a UMI into a single gene Default: 1000000000"
    inputBinding:
      position: 1
      prefix: --uniq-bin
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Turn on verbose mode with specific verbosity threshold. 0: fully verbose, 100 : no verbose messages Default: 100"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: group_list
    type:
      - 'null'
      - File
    doc: "List of tag readgroup/cell barcode to consider in this run. All other barcodes will be ignored. This is useful for parallelized run"
    inputBinding:
      position: 1
      prefix: --group-list
  - id: min_total
    type:
      - 'null'
      - int
    doc: "Minimum number of total reads for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-total
  - id: min_uniq
    type:
      - 'null'
      - int
    doc: "Minimum number of unique reads (determined by UMI/SNP pair) for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-uniq
  - id: min_snp
    type:
      - 'null'
      - int
    doc: "Minimum number of SNPs with coverage for a droplet/cell to be considered Default: 0"
    inputBinding:
      position: 1
      prefix: --min-snp
  - id: plp_files
    type:
      type: array
      items: File
    doc: "Pileup files (<prefix>.plp.gz, .var.gz, .cel.gz, .umi.gz) written by dsc-pileup; staged in the working directory so that the plp prefix resolves"
outputs:
  - id: dge_matrix
    type: Directory
    doc: "Digital expression matrices (gene, exon, transcript folders)"
    outputBinding:
      glob: "$(inputs.out)"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.plp_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_plp-make-dge-matrix.out
stderr: popscle_plp-make-dge-matrix.log
