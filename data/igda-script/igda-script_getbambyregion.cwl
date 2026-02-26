cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_getbambyregion
label: igda-script_getbambyregion
doc: "Extract BAM alignments within a specified genomic region.\n\nTool homepage:
  https://github.com/zhixingfeng/shell"
inputs:
  - id: inbamfile
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: chr
    type: string
    doc: Chromosome name
    inputBinding:
      position: 2
  - id: start
    type: int
    doc: Start position (1-based)
    inputBinding:
      position: 3
  - id: end
    type: int
    doc: End position (1-based)
    inputBinding:
      position: 4
  - id: nthread
    type: int
    doc: Number of threads
    inputBinding:
      position: 5
outputs:
  - id: outsamfile
    type: File
    doc: Output SAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
