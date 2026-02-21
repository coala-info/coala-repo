cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx-cwl_get-cwltool.sh
label: dx-cwl_get-cwltool.sh
doc: "A script to get or prepare cwltool for dx-cwl. Note: The provided text contains
  error logs regarding container image conversion and disk space issues rather than
  standard help documentation.\n\nTool homepage: https://github.com/dnanexus/dx-cwl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
stdout: dx-cwl_get-cwltool.sh.out
