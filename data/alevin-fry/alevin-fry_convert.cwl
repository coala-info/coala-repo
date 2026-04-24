cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - convert
label: alevin-fry_convert
doc: "Convert a BAM file to a RAD file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: bam
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: output RAD file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
