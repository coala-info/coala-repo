cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_getbambyregion_dir
label: igda-script_getbambyregion_dir
doc: "A tool to extract BAM files by region from a directory. (Note: The provided
  help text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_getbambyregion_dir.out
