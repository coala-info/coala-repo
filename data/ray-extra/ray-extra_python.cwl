cwlVersion: v1.2
class: CommandLineTool
baseCommand: ray-extra_python
label: ray-extra_python
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/arshiacomplus/v2rayExtractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ray-extra:v2.3.1-6-deb_cv1
stdout: ray-extra_python.out
