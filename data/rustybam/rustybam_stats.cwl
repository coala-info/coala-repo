cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam stats
label: rustybam_stats
doc: "Get percent identity stats from a sam/bam/cram or PAF. Requires =/X operations
  in the CIGAR string!\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input sam/bam/cram/file
    default: '-'
    inputBinding:
      position: 1
  - id: paf
    type:
      - 'null'
      - boolean
    doc: Specify that the input is paf format, (must have cg tag with extended 
      cigar)
    inputBinding:
      position: 102
      prefix: --paf
  - id: qbed
    type:
      - 'null'
      - boolean
    doc: Print query coordinates first
    inputBinding:
      position: 102
      prefix: --qbed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_stats.out
