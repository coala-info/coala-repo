cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_getbambyregion_dir
label: igda-script_getbambyregion_dir
doc: "Get BAM files by region within a directory\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: Input directory containing BAM files
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
    doc: Number of threads to use
    inputBinding:
      position: 5
  - id: logdir
    type: Directory
    doc: Directory for log files
    inputBinding:
      position: 6
outputs:
  - id: outdir
    type: Directory
    doc: Output directory for filtered BAM files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
