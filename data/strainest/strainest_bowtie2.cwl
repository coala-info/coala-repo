cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainest_bowtie2
label: strainest_bowtie2
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container image build failure.\n\nTool homepage: https://github.com/compmetagen/strainest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py36h2d50403_2
stdout: strainest_bowtie2.out
