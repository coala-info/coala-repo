cwlVersion: v1.2
class: CommandLineTool
baseCommand: megahit_core
label: megahit_megahit_core
doc: "MEGAHIT is an ultra-fast and memory-efficient NGS assembler. (Note: The provided
  help text contains only system error logs and no usage information.)\n\nTool homepage:
  https://github.com/voutcn/megahit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megahit:1.2.9--haf24da9_8
stdout: megahit_megahit_core.out
