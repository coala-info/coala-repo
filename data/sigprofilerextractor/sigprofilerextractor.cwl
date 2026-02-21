cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigprofilerextractor
label: sigprofilerextractor
doc: "SigProfilerExtractor is a tool for extraction and analysis of mutational signatures.\n
  \nTool homepage: https://github.com/AlexandrovLab/SigProfilerExtractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilerextractor:1.2.6--pyhdfd78af_0
stdout: sigprofilerextractor.out
