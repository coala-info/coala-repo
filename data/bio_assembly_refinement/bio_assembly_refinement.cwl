cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio_assembly_refinement
label: bio_assembly_refinement
doc: "A tool for bio-assembly refinement (Note: The provided text is a system error
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/nds/bio_assembly_refinement"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio_assembly_refinement:0.5.1--py36_0
stdout: bio_assembly_refinement.out
