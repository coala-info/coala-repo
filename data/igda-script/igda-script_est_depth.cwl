cwlVersion: v1.2
class: CommandLineTool
baseCommand: est_depth
label: igda-script_est_depth
doc: "only work for single chromosome data\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: bamfile
    type: File
    doc: Input BAM or SAM file
    inputBinding:
      position: 1
  - id: genome_size
    type: int
    doc: Genome size
    inputBinding:
      position: 2
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
