cwlVersion: v1.2
class: CommandLineTool
baseCommand: RawToolsViz.exe
label: rawtools_RawToolsViz.exe
doc: "Visualization tool for RawTools. (Note: The provided text appears to be a container
  build error log rather than help text; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/kevinkovalchik/RawTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rawtools:2.0.4--hdfd78af_0
stdout: rawtools_RawToolsViz.exe.out
