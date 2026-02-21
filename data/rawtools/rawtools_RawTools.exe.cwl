cwlVersion: v1.2
class: CommandLineTool
baseCommand: RawTools.exe
label: rawtools_RawTools.exe
doc: "RawTools is a tool for processing Thermo Raw files. (Note: The provided text
  contains container execution errors rather than command-line help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/kevinkovalchik/RawTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rawtools:2.0.4--hdfd78af_0
stdout: rawtools_RawTools.exe.out
