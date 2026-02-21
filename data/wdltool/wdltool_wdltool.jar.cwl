cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool
label: wdltool_wdltool.jar
doc: "A tool for working with Workflow Description Language (WDL) files. Note: The
  provided text appears to be a container execution error log rather than help text,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_wdltool.jar.out
