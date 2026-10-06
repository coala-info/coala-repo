cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ananse
  - network
label: ananse_network
doc: "Infer a gene regulatory network from TF binding predictions (ANANSE binding output) and gene expression\n\nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: binding
    type: File
    doc: "TF binding prediction file (ANANSE binding output)"
    inputBinding:
      position: 0
  - id: expression
    type: {type: array, items: File}
    doc: "Gene expression file(s) with genes as first column and expression column(s) in TPM values. Files can include transcript-level TPMs (the quant.sf from salmon or the abundances.tsv from kallisto), or gene-level TPMs tables."
    inputBinding:
      position: 1
      prefix: --expression
  - id: genome
    type: ['null', File]
    doc: "Genome FASTA file used to align the BAMs and regions to (genomepy writes its index files next to it; a genomepy gene annotation <name>.annotation.gtf/.bed beside it is used to map transcripts to gene names)"
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .sizes
        required: false
      - pattern: ^.annotation.bed
        required: false
      - pattern: ^.annotation.gtf
        required: false
    inputBinding:
      position: 1
      prefix: --genome
  - id: annotation
    type: ['null', File]
    doc: "Gene annotation (BED12 file) used to quantify expression levels. Optional when a genomepy genome (with annotation) is provided."
    inputBinding:
      position: 1
      prefix: --annotation
  - id: outfile
    type: ['null', string]
    doc: "Name of the output network file (default: ./ANANSE_network.tsv)"
    default: ANANSE_network.tsv
    inputBinding:
      position: 1
      prefix: --outfile
  - id: tfs
    type: ['null', {type: array, items: string}]
    doc: "Filter Transcription Factors to use (default: all in motif2factors.txt). Either a space-separated list or one or more files with one TF per line"
    inputBinding:
      position: 1
      prefix: --tfs
  - id: regions
    type: ['null', {type: array, items: File}]
    doc: "Filter regions to use (default: all in binding.h5). Either one region/BED format file or a space-separated list."
    inputBinding:
      position: 1
      prefix: --regions
  - id: columns
    type: ['null', {type: array, items: string}]
    doc: "One or more (case insensitive) column names to extract from the expression file(s) (default: tpm)"
    inputBinding:
      position: 1
      prefix: --columns
  - id: full_output
    type: ['null', boolean]
    doc: "Export the full GRN output to the output file"
    inputBinding:
      position: 1
      prefix: --full-output
  - id: include_promoter
    type: ['null', boolean]
    doc: "Include promoter peaks (<= TSS +/- 2kb) in network inference (default)."
    inputBinding:
      position: 1
      prefix: --include-promoter
  - id: exclude_promoter
    type: ['null', boolean]
    doc: "Exclude promoter peaks (<= TSS +/- 2kb) from network inference."
    inputBinding:
      position: 1
      prefix: --exclude-promoter
  - id: include_enhancer
    type: ['null', boolean]
    doc: "Include enhancer peaks (> TSS +/- 2kb) in network inference (default)."
    inputBinding:
      position: 1
      prefix: --include-enhancer
  - id: exclude_enhancer
    type: ['null', boolean]
    doc: "Exclude enhancer peaks (> TSS +/- 2kb) from network inference."
    inputBinding:
      position: 1
      prefix: --exclude-enhancer
  - id: ncore
    type: ['null', int]
    doc: "Number of cores to use."
    inputBinding:
      position: 1
      prefix: --ncore
outputs:
  - id: network
    type: File
    doc: Gene regulatory network (TF, target gene, probability)
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
