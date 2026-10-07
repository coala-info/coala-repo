cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - regenerate-fastq
label: capcruncher_utilities_regenerate-fastq
doc: "Regenerates FASTQ files from a parquet file containing the required reads.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: fastq1
    type: File
    doc: "Path to FASTQ file 1"
    inputBinding:
      position: 2
      prefix: '-1'
  - id: fastq2
    type: File
    doc: "Path to FASTQ file 2"
    inputBinding:
      position: 2
      prefix: '-2'
  - id: parquet_file
    type:
      - File
      - Directory
    doc: "Path to parquet file from which to extract the required reads"
    inputBinding:
      position: 2
      prefix: -p
  - id: output_prefix
    type: string
    default: regenerated_
    doc: "Output file prefix"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: regenerated_fastq
    type:
      type: array
      items: File
    doc: "Regenerated FASTQ files"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
