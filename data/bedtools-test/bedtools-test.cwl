cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedtools-test
label: bedtools-test
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a lack of disk space during a Singularity/Docker
  container build process.\n\nTool homepage: http://bedtools.readthedocs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bedtools-test:v2.27.1dfsg-4-deb_cv1
stdout: bedtools-test.out
