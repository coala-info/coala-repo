cwlVersion: v1.2
class: CommandLineTool
baseCommand: python -m fwdpy11
label: fwdpy11
doc: "Helper script for fwdpy11.\n\nTool homepage: https://github.com/molpopgen/fwdpy11"
inputs:
  - id: fwdpp_headers
    type:
      - 'null'
      - boolean
    doc: Get location of fwdpp headers
    inputBinding:
      position: 101
      prefix: --fwdpp_headers
  - id: fwdpy11_headers
    type:
      - 'null'
      - boolean
    doc: Get location of fwdpy11 headers
    inputBinding:
      position: 101
      prefix: --fwdpy11_headers
  - id: includes
    type:
      - 'null'
      - boolean
    doc: Print the CPPFLAGS required to use fwdpy11 and fwdpp headers.
    inputBinding:
      position: 101
      prefix: --includes
  - id: mako
    type:
      - 'null'
      - boolean
    doc: Print minimal mako header for use with cppimport.
    inputBinding:
      position: 101
      prefix: --mako
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fwdpy11:0.24.5--py311h0f4446f_0
stdout: fwdpy11.out
