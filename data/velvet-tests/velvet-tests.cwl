cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvet-tests
label: velvet-tests
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a lack of disk space during a Singularity
  container build process.\n\nTool homepage: https://github.com/rprokap/pset-9"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/velvet-tests:v1.2.10dfsg1-5-deb_cv1
stdout: velvet-tests.out
