cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - generate-coverage
label: transcov_generate-coverage
doc: "Generate coverage tracks from BAM files based on BED regions.\n\nTool homepage:
  https://github.com/hogfeldt/transcov"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file defining regions
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_generate-coverage.out
