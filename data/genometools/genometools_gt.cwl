cwlVersion: v1.2
class: CommandLineTool
baseCommand: gt
label: genometools_gt
doc: "GenomeTools genome analysis system\n\nTool homepage: https://github.com/genometools/genometools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometools:v1.5.9ds-4-deb-py2_cv1
stdout: genometools_gt.out
