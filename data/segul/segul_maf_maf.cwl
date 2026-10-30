cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, maf, maf]
label: segul_maf_maf
doc: "Convert genomic files (multiple alignment format, MAF) to other formats\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type: ['null', {type: array, items: File}]
    doc: "Input path(s) (wildcards are expanded by the tool, so give files)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: reference
    type: File
    doc: "Path to the source of reference names"
    inputBinding:
      position: 1
      prefix: "--reference"
  - id: from_bed
    type: ['null', boolean]
    doc: "Source of names is a bed file"
    inputBinding:
      position: 1
      prefix: "--from-bed"
  - id: output_format
    type: ['null', string]
    doc: "Output format: fasta, phylip, fasta-int, phylip-int (default fasta-int)"
    inputBinding:
      position: 1
      prefix: "--output-format"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: output
    type: string
    default: "Genomic-Convert"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: prefix
    type: ['null', string]
    doc: "Specify prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
outputs:
  - id: output_path
    type: [File, Directory]
    doc: Output file or directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_maf_maf.out
