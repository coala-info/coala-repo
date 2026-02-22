cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_PhyML
label: bioperl-run_PhyML
doc: "PhyML phylogenetic analysis (BioPerl wrapper)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_PhyML.out
