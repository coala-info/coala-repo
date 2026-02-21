cwlVersion: v1.2
class: CommandLineTool
baseCommand: backports.unittest_mock
label: backports.unittest_mock
doc: "A backport of the unittest.mock library for older versions of Python.\n\nTool
  homepage: https://github.com/jaraco/backports.unittest_mock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/backports.unittest_mock:1.3--py27_0
stdout: backports.unittest_mock.out
