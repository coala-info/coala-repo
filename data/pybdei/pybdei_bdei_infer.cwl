cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybdei
  - bdei_infer
label: pybdei_bdei_infer
doc: "Birth-Death-Exposed-Infectious (BDEI) model inference tool. (Note: The provided
  text contains container execution logs and error messages rather than help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/evolbioinfo/bdei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
stdout: pybdei_bdei_infer.out
