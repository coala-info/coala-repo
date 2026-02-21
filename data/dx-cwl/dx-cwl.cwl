cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx-cwl
label: dx-cwl
doc: "A tool for running Common Workflow Language (CWL) workflows on the DNAnexus
  platform. (Note: The provided text is a system error log and does not contain usage
  instructions or argument definitions).\n\nTool homepage: https://github.com/dnanexus/dx-cwl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
stdout: dx-cwl.out
