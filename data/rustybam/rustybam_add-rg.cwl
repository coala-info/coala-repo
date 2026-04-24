cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam add-rg
label: rustybam_add-rg
doc: "Add RG lines from a source BAM file to the BAM from stdin to the BAM going to
  stdout\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: source
    type: File
    doc: Source BAM file to read RG lines from
    inputBinding:
      position: 1
  - id: sample
    type:
      - 'null'
      - string
    doc: Add this string as the sample name (SM) to each read group in the 
      output BAM
    inputBinding:
      position: 102
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Write uncompressed output
    inputBinding:
      position: 102
      prefix: --uncompressed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_add-rg.out
