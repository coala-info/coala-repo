cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_wf_mutations
label: biobb_wf_mutations
doc: "A tool from the BioExcel Building Blocks (biobb) suite, likely a workflow for
  analyzing mutations. (Note: The provided text contains system build logs and a fatal
  error regarding disk space rather than command-line help documentation.)\n\nTool
  homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_wf_mutations:0.0.6--py_0
stdout: biobb_wf_mutations.out
