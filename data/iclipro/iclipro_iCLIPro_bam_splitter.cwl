cwlVersion: v1.2
class: CommandLineTool
baseCommand: iCLIPro_bam_splitter
label: iclipro_iCLIPro_bam_splitter
doc: "BAM splitter\n\nTool homepage: http://www.biolab.si/iCLIPro/doc/"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: use only reads with minimum mapping quality (mapq) (0..100)
    inputBinding:
      position: 102
      prefix: -q
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: output folder
    inputBinding:
      position: 102
      prefix: -o
  - id: read_len_groups
    type:
      - 'null'
      - string
    doc: read len groups
    inputBinding:
      position: 102
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iclipro:0.1.1--py27_0
stdout: iclipro_iCLIPro_bam_splitter.out
