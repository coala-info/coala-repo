cwlVersion: v1.2
class: CommandLineTool
baseCommand: virus-interpreter
label: hmftools-virus-interpreter
doc: "A tool from the HMF (Hartwig Medical Foundation) suite for interpreting viral
  integrations. Note: The provided text is a container execution error log and does
  not contain usage instructions or argument definitions.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/virus-interpreter/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-virus-interpreter:3.7_beta--hdfd78af_1
stdout: hmftools-virus-interpreter.out
