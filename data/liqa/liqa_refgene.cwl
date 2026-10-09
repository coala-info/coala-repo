cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - liqa
label: liqa_refgene
doc: "Preprocess a reference annotation file (GTF or UCSC all fields) into the isoform compatible matrix used by quantify and novel.\n\nTool homepage: https://github.com/WGLab/LIQA"
arguments:
  - position: 0
    prefix: -task
    valueFrom: refgene
inputs:
  - id: ref
    type: File
    doc: Reference annotation file (gtf or UCSC all fields).
    inputBinding:
      position: 1
      prefix: -ref
  - id: format
    type: string
    doc: Reference file format (gtf or ucsc).
    inputBinding:
      position: 2
      prefix: -format
  - id: out
    type: string
    doc: Output refgene file name.
    inputBinding:
      position: 3
      prefix: -out
outputs:
  - id: refgene_file
    type: File
    doc: Isoform compatible matrix (refgene) file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa_refgene.out
