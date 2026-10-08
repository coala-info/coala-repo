cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - est_depth
label: igda-script_est_depth
doc: "Estimate sequencing depth (total read bases / genome size) of a BAM or SAM file. Only works for single chromosome data.\nUsage: est_depth bamfile(or samfile) genome_size outfile\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: bamfile
    type: File
    doc: "BAM or SAM file"
    inputBinding:
      position: 1
  - id: genome_size
    type: int
    doc: "genome size (bp)"
    inputBinding:
      position: 2
  - id: outfile
    type: string
    doc: "output file name"
    inputBinding:
      position: 3
outputs:
  - id: depth_file
    type: File
    doc: "sample name and estimated depth"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
