cwlVersion: v1.2
class: CommandLineTool
baseCommand: micropita_micropita.py
label: micropita_micropita.py
doc: "MicroPITA (microbiome Pick In-depth Targeted Assemblies) is a tool for selecting
  samples for metagenomic sequencing.\n\nTool homepage: http://huttenhower.sph.harvard.edu/micropita"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micropita:1.1.0--0
stdout: micropita_micropita.py.out
