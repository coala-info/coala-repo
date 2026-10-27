cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ViewBS
  - BisNonConvRate
label: viewbs_BisNonConvRate
doc: "Estimate non-conversion rate of BS-seq data using an unmethylated chromosome such as the chloroplast or PhiX genome\n\nTool homepage: https://github.com/xie186/ViewBS"
inputs:
  - id: sample
    type:
      type: array
      items: string
      inputBinding:
        prefix: --sample
    doc: "Sample information, one entry per sample, as \"methylation_file,sample_name\". The file name must be one of the files given in meth_files."
    inputBinding:
      position: 101
  - id: meth_files
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .tbi
        required: true
    doc: "Methylation files (bgzip-compressed, tabix-indexed with .tbi). They are staged in the working directory so that the names used in sample resolve."
  - id: chrom
    type: string
    doc: "Chromosome ID that the users want to use to estimate non-conversion rate."
    inputBinding:
      position: 101
      prefix: --chrom
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum read depth for calculating methylation level. [default: 5]"
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum read depth for calculating methylation level. [default: 10000]"
    inputBinding:
      position: 101
      prefix: --maxDepth
  - id: context
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --context
    doc: "Sequence context (CG, CHG or CHH). It is possible to give more than one context. [default: CXX]"
    inputBinding:
      position: 101
  - id: outdir
    type: string
    doc: "Provide the output directory."
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Provide prefix for the output file."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of PDF figure. Unit is cm."
    inputBinding:
      position: 101
      prefix: --height
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of PDF figure. Unit is cm."
    inputBinding:
      position: 101
      prefix: --width
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose output."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_directory
    type: Directory
    doc: Output directory with the tables and PDF figures
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.meth_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
stdout: viewbs_BisNonConvRate.out
