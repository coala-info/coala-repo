cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - getbambyregion_dir
label: igda-script_getbambyregion_dir
doc: "Run getbambyregion on every BAM file in a directory.\nUsage: getbambyregion_dir indir outdir chr start end(1-based) nthread logdir\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: "directory with indexed BAM files"
    inputBinding:
      position: 1
  - id: outdir
    type: string
    doc: "output directory name"
    inputBinding:
      position: 2
  - id: chr
    type: string
    doc: "chromosome"
    inputBinding:
      position: 3
  - id: start
    type: int
    doc: "region start (1-based)"
    inputBinding:
      position: 4
  - id: end
    type: int
    doc: "region end (1-based)"
    inputBinding:
      position: 5
  - id: nthread
    type: int
    doc: "number of threads"
    inputBinding:
      position: 6
  - id: logdir
    type: string
    doc: "log directory name"
    inputBinding:
      position: 7
outputs:
  - id: out_dir
    type: Directory
    doc: "directory with one SAM file per BAM"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
