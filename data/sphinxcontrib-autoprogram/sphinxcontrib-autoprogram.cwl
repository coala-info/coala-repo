cwlVersion: v1.2
class: CommandLineTool
baseCommand: sphinxcontrib-autoprogram
label: sphinxcontrib-autoprogram
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process.\n\nTool
  homepage: https://github.com/conda-forge/sphinxcontrib-autoprogram-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sphinxcontrib-autoprogram:v0.1.5-1-deb_cv1
stdout: sphinxcontrib-autoprogram.out
