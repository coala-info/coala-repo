cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igda-script
  - igda
  - polish
label: igda-script_igda polish
doc: "A tool for polishing genomic assemblies (Note: The provided text contains only
  system error messages and no usage information; therefore, no arguments could be
  extracted).\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda polish.out
