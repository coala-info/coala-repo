cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - merge-methcounts
label: dnmtools_merge-methcounts
doc: "Merge methylation counts from multiple files. (Note: The provided input text
  contains system error messages and does not list the tool's usage or arguments.)\n
  \nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_merge-methcounts.out
