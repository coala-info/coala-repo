cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_est_depth_dir
label: igda-script_est_depth_dir
doc: "only work for single chromosome data\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: input directory (has bamfiles)
    inputBinding:
      position: 1
  - id: genome_size
    type: int
    doc: genome size
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_est_depth_dir.out
