cwlVersion: v1.2
class: CommandLineTool
baseCommand: sphinx-autoprogram
label: sphinxcontrib.autoprogram
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/conda-forge/sphinxcontrib-autoprogram-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sphinxcontrib.autoprogram:v0.1.5-1-deb-py3_cv1
stdout: sphinxcontrib.autoprogram.out
