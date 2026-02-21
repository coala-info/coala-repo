cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb_variant_filter
label: tb_variant_filter
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for the tool. No arguments or descriptions could be extracted.\n
  \nTool homepage: http://github.com/pvanheus/tb_variant_filter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb_variant_filter:0.4.0--pyhdfd78af_0
stdout: tb_variant_filter.out
