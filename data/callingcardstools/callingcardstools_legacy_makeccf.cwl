cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - legacy_makeccf
label: callingcardstools_legacy_makeccf
doc: "This function make .ccf files from mapped .bam files. ccf files have the following
  columns: [chr,start,end,reads,strand,barcode] but only the first 4 columns are required.
  The genome coordinates are 1-indexed\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set the logging level. Options: critical, error, warning, info, debug'
    inputBinding:
      position: 101
      prefix: --log_level
  - id: sampath
    type: File
    secondaryFiles:
      - .bai
    doc: path to sam/bam (indexed bam with the legacy NC_0011xx yeast chromosome
      names)
    inputBinding:
      position: 101
      prefix: --sampath
  - id: outputpath
    type: string
    default: .
    doc: output path (directory for the .ccf and _ccfQC.txt files)
    inputBinding:
      position: 101
      prefix: --outputpath
outputs:
  - id: ccf_file
    type: File
    doc: ccf file named after the input bam
    outputBinding:
      glob: $(inputs.outputpath)/$(inputs.sampath.nameroot).ccf
  - id: ccf_qc_file
    type: File
    doc: ccf QC summary (sample, number of insertions, number of reads)
    outputBinding:
      glob: $(inputs.outputpath)/$(inputs.sampath.nameroot)_ccfQC.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.outputpath == "." ? [] : [{"class": "Directory", "basename":
      inputs.outputpath, "listing": [], "writable": true}])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
