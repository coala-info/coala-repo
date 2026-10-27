cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ViewBS
  - MethLevDist
label: viewbs_MethLevDist
doc: "Generate distribution of methylation levels genome wide or for a list of regions\n\nTool homepage: https://github.com/xie186/ViewBS"
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
    type:
      - 'null'
      - File
    doc: "Restrict the calculation to the regions provided only."
    inputBinding:
      position: 101
      prefix: --region
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
  - id: bin_meth_lev
    type:
      - 'null'
      - float
    doc: "Bin size to calculate the distribution of methylation level. [default: 0.1]"
    inputBinding:
      position: 101
      prefix: --binMethLev
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
stdout: viewbs_MethLevDist.out
