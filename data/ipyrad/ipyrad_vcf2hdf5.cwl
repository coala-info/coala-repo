cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipyrad_vcf2hdf5
label: ipyrad_vcf2hdf5
doc: "The provided text does not contain help information for the tool; it is a system
  error message regarding container image conversion and disk space.\n\nTool homepage:
  http://github.com/dereneaton/ipyrad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipyrad:0.9.107--pyhdfd78af_0
stdout: ipyrad_vcf2hdf5.out
