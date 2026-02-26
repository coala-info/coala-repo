cwlVersion: v1.2
class: CommandLineTool
baseCommand: scenicplus init_snakemake
label: scenicplus_init_snakemake
doc: "Initialize ScenicPlus project for Snakemake\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: out_dir
    type: Directory
    doc: Output directory for the project initialization
    inputBinding:
      position: 101
      prefix: --out_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
stdout: scenicplus_init_snakemake.out
