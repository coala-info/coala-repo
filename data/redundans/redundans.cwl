cwlVersion: v1.2
class: CommandLineTool
baseCommand: redundans
label: redundans
doc: "Redundans is a pipeline for fast and automatic redundancy reduction, scaffolding,
  and gap closing of genome assemblies.\n\nTool homepage: https://github.com/Gabaldonlab/redundans/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/redundans:2.01--py310pl5321h43eeafb_0
stdout: redundans.out
