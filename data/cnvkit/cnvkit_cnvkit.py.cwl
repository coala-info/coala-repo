cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvkit.py
label: cnvkit_cnvkit.py
doc: "CNVkit: Copy number variant detection from high-throughput sequencing (Note:
  The provided text is an error log and does not contain usage information or arguments).\n
  \nTool homepage: https://github.com/etal/cnvkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
stdout: cnvkit_cnvkit.py.out
