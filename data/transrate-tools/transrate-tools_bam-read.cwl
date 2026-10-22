cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-read
label: transrate-tools_bam-read
doc: "Reads a BAM file of paired-end reads aligned to a transcriptome and writes per-contig read-mapping statistics to a CSV file.\n\nTool homepage: https://github.com/blahah/transrate-tools"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: output_csv
    type: string
    doc: Output CSV file name
    inputBinding:
      position: 2
  - id: nullprior
    type:
      - 'null'
      - float
    doc: "nullprior (optional), for example 0.95"
    inputBinding:
      position: 3
outputs:
  - id: csv
    type: File
    doc: CSV file with the read-mapping statistics
    outputBinding:
      glob: $(inputs.output_csv)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transrate-tools:v1.0.0-2-deb_cv1
