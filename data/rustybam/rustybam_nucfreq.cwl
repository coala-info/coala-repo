cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam nucfreq
label: rustybam_nucfreq
doc: "Get the frequencies of each bp at each position\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input sam/bam/cram/file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: Print nucfreq info from regions in the bed file output is optionally 
      tagged using the 4th column
    inputBinding:
      position: 102
      prefix: --bed
  - id: region
    type:
      - 'null'
      - string
    doc: Print nucfreq info from the input region e.g "chr1:1-1000"
    inputBinding:
      position: 102
      prefix: --region
  - id: small
    type:
      - 'null'
      - boolean
    doc: Smaller output format
    inputBinding:
      position: 102
      prefix: --small
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_nucfreq.out
