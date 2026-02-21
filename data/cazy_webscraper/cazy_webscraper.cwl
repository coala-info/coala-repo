cwlVersion: v1.2
class: CommandLineTool
baseCommand: cazy_webscraper
label: cazy_webscraper
doc: "The provided text does not contain help documentation. It is a log of a failed
  Singularity/Apptainer container build due to insufficient disk space ('no space
  left on device').\n\nTool homepage: https://hobnobmancer.github.io/cazy_webscraper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0
stdout: cazy_webscraper.out
