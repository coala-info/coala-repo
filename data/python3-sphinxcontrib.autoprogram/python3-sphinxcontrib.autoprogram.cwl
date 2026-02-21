cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-sphinxcontrib.autoprogram
label: python3-sphinxcontrib.autoprogram
doc: A Sphinx extension that automatically documents CLI programs using their argparse
  (or similar) definitions.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-sphinxcontrib.autoprogram:v0.1.2-1-deb_cv1
stdout: python3-sphinxcontrib.autoprogram.out
