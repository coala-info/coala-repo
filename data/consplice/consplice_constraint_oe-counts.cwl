cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - oe-counts
label: consplice_constraint_oe-counts
doc: "Calculate Observed and Expected splicing variant counts for genic or intragenic regions of genes.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: gnomad_vcf
    type: File
    doc: 'The path to the gnomAD vcf/bcf file (bgzipped and tabixed).'
    inputBinding:
      position: 1
      prefix: --gnomad-vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: coverage
    type: File
    doc: 'The gnomAD coverage file for the gnomAD vcf file, in bed format, bgzipped and tabixed.'
    inputBinding:
      position: 1
      prefix: --coverage
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: gtf_file
    type: File
    doc: 'A gtf file to get gene specific genomic coordinates from.'
    inputBinding:
      position: 1
      prefix: --gtf-file
  - id: spliceai_vcf
    type: File
    doc: 'The path to SpliceAI delta score predictions for every snv (vcf file).'
    inputBinding:
      position: 1
      prefix: --spliceai-vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: alt_gene_symbol
    type: File
    doc: 'A file with a header that maps canonical gene symbols to alternative gene symbols (HGNC protein-coding gene mapping file).'
    inputBinding:
      position: 1
      prefix: --alt-gene-symbol
  - id: fasta
    type: File
    doc: 'A fasta file to get reference alleles by position from.'
    inputBinding:
      position: 1
      prefix: --fasta
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: seg_dups
    type: File
    doc: 'The segmental duplications file used to exclude repeat regions (ggd grch38-segmental-dups-ucsc-v1).'
    inputBinding:
      position: 1
      prefix: --seg-dups
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: self_chains
    type: File
    doc: 'The high identity self chain repeat file used to exclude repeat regions (ggd grch38-self-chain-ucsc-v1).'
    inputBinding:
      position: 1
      prefix: --self-chains
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: out_file
    type: string
    doc: 'The name of the output file to create.'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Which chromosomes to use (for example 1 2 3, X, or All). Default = ALL.'
    inputBinding:
      position: 1
      prefix: --chrom
  - id: coverage_cutoff
    type:
      - 'null'
      - float
    doc: 'A number between 0.0 and 1.0 for the required fraction of samples with coverage at each site in gnomAD. Default = 0.5.'
    inputBinding:
      position: 1
      prefix: -cc
  - id: coverage_label
    type:
      - 'null'
      - string
    doc: 'The label/column in the coverage file to use for the selected position coverage. Default = ''over_10''.'
    inputBinding:
      position: 1
      prefix: --coverage-label
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: 'The number of CPUs to use for multi-threading. Default = 3.'
    inputBinding:
      position: 1
      prefix: --n-cpu
  - id: repeat_score_cutoff
    type:
      - 'null'
      - float
    doc: 'The cutoff score for seg dups or self chain repeats; gene regions at or above it are skipped. Default = 0.95.'
    inputBinding:
      position: 1
      prefix: --repeat-score-cutoff
  - id: spliceai_score_type
    type:
      - 'null'
      - string
    doc: 'How to use the SpliceAI score: ''max'', ''sum'' or ''splicing_unaware''. Default = ''sum''.'
    inputBinding:
      position: 1
      prefix: --spliceai-score-type
  - id: substitution_matrix
    type: File
    doc: 'The SpliceAI aware substitution matrix created with the sub-matrix subcommand.'
    inputBinding:
      position: 1
      prefix: --substitution-matrix
  - id: region_type
    type: string
    doc: 'Calculate observed and expected counts using the entire gene (''gene'') or intragenic regions based on a window size (''region'').'
    inputBinding:
      position: 1
      prefix: --region-type
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'The window size in bp used for the sliding window (required if region_type is ''region'').'
    inputBinding:
      position: 1
      prefix: --window-size
  - id: step_size
    type:
      - 'null'
      - int
    doc: 'The step size in bp used to slide the window along a gene (required if region_type is ''region'').'
    inputBinding:
      position: 1
      prefix: --step-size
outputs:
  - id: output
    type: File
    doc: 'The output file.'
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
