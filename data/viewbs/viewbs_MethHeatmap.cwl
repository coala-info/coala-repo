cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ViewBS
  - MethHeatmap
label: viewbs_MethHeatmap
doc: "Generate methylation for each region and each sample to make a heatmap and a violin-boxplot\n\nTool homepage: https://github.com/xie186/ViewBS"
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
  - id: region
    type: File
    doc: "Regions you want to investigate."
    inputBinding:
      position: 101
      prefix: --region
  - id: context
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --context
    doc: "Sequence context (CG, CHG or CHH). It is possible to give more than one context. "
    inputBinding:
      position: 101
  - id: merge
    type:
      - 'null'
      - boolean
    doc: "If given, methylation levels of different contexts are written to one file."
    inputBinding:
      position: 101
      prefix: --merge
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
  - id: cluster_rows
    type:
      - 'null'
      - string
    doc: "Boolean value determining if rows should be clustered."
    inputBinding:
      position: 101
      prefix: --cluster_rows
  - id: cluster_cols
    type:
      - 'null'
      - string
    doc: "Boolean value determining if columns should be clustered."
    inputBinding:
      position: 101
      prefix: --cluster_cols
  - id: height2
    type:
      - 'null'
      - float
    doc: "Height of PDF figure (violin and boxplot). Unit is cm. [default: 10]"
    inputBinding:
      position: 101
      prefix: --height2
  - id: width2
    type:
      - 'null'
      - float
    doc: "Width of PDF figure (violin and boxplot). Unit is cm. [default: 10]"
    inputBinding:
      position: 101
      prefix: --width2
  - id: random_region
    type:
      - 'null'
      - int
    doc: "Number of regions selected randomly when the region list is very large. [default: 2000]"
    inputBinding:
      position: 101
      prefix: --random_region
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
stdout: viewbs_MethHeatmap.out
