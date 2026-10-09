cwlVersion: v1.2
class: CommandLineTool
baseCommand: iCLIPro_bam_splitter
label: iclipro_iCLIPro_bam_splitter
doc: "BAM splitter\n\nTool homepage: http://www.biolab.si/iCLIPro/doc/"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 200
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: use only reads with minimum mapping quality (mapq) (0..100)
    inputBinding:
      position: 102
      prefix: -q
  - id: output_folder
    type: string
    doc: output folder
    inputBinding:
      position: 102
      prefix: -o
  - id: read_len_groups
    type:
      - 'null'
      - string
    doc: 'read len groups (default: "A:16-39,A1:16-25,A2:26-32,A3:33-39,B:42")'
    inputBinding:
      position: 102
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_folder_dir
    type: Directory
    doc: output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iclipro:0.1.1--py27_0
stdout: iclipro_iCLIPro_bam_splitter.out
