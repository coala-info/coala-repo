cwlVersion: v1.2
class: CommandLineTool
baseCommand: star-fusion
label: star-fusion_STAR-Fusion
doc: "STAR-Fusion is a tool for detecting gene fusions from RNA-Seq data.\n\nTool
  homepage: https://github.com/STAR-Fusion/STAR-Fusion"
inputs:
  - id: chimeric_junction
    type:
      - 'null'
      - File
    doc: Chimeric.out.junction file
    inputBinding:
      position: 101
      prefix: --chimeric_junction
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of threads for running STAR
    default: 4
    inputBinding:
      position: 101
      prefix: --CPU
  - id: genome_lib_dir
    type: Directory
    doc: directory containing genome lib (see http://STAR-Fusion.github.io)
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: left_fq
    type: File
    doc: left.fq file (or single.fq)
    inputBinding:
      position: 101
      prefix: --left_fq
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    default: STAR-Fusion_outdir
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: right_fq
    type:
      - 'null'
      - File
    doc: right.fq file (actually optional, but highly recommended)
    inputBinding:
      position: 101
      prefix: --right_fq
  - id: show_full_usage_info
    type:
      - 'null'
      - boolean
    doc: provide full usage info.
    inputBinding:
      position: 101
      prefix: --show_full_usage_info
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/star-fusion:1.15.1--hdfd78af_1
stdout: star-fusion_STAR-Fusion.out
