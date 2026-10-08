cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - bam-index
label: fuc_bam-index
doc: "Index a BAM file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bam
    type: File
    doc: Input alignment file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bai
    type: File
    doc: BAM index written beside the input (<bam>.bai)
    outputBinding:
      glob: $(inputs.bam.basename).bai
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bam-index.out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam)
        writable: true
  - class: InlineJavascriptRequirement
