cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifrac
label: unifrac
doc: "The provided text does not contain help information for the 'unifrac' tool;
  it is a log of a failed container build process.\n\nTool homepage: https://github.com/biocore/unifrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac:1.5.1--py39hff726c5_0
stdout: unifrac.out
