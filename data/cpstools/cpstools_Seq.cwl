cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools Seq
label: cpstools_Seq
doc: "Sequence manipulation tool\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: info_file
    type: File
    doc: file of the information of the fasta file four regions
    inputBinding:
      position: 101
      prefix: --info_file
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode: SSC for adjust_SSC_forward, LSC for adjust_start_to_LSC, RP for adjust
      sequence to reverse_complement'
    inputBinding:
      position: 101
      prefix: --mode
  - id: work_dir
    type: Directory
    doc: Input directory of fasta files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_Seq.out
