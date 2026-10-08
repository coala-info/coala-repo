cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - getbambyregion
label: igda-script_getbambyregion
doc: "Extract alignments in a region (1-based) of an indexed BAM file to a SAM file with header.\nUsage: getbambyregion inbamfile outsamfile chr start end(1-based) nthread\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: inbamfile
    type: File
    doc: "indexed BAM file"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: outsamfile
    type: string
    doc: "output SAM file name"
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
outputs:
  - id: out_sam
    type: File
    doc: "SAM file of the region"
    outputBinding:
      glob: $(inputs.outsamfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
