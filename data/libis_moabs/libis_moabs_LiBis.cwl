cwlVersion: v1.2
class: CommandLineTool
baseCommand: LiBis
label: libis_moabs_LiBis
doc: "Linker-based Bisulfite Sequencing (LiBis) tool. (Note: The provided text is
  a system error message and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/Dangertrip/LiBis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libis_moabs:0.0.7--py_0
stdout: libis_moabs_LiBis.out
