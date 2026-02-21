cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-build
label: krakenhll_krakenuniq-build
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Singularity/Apptainer)
  failing due to lack of disk space.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_krakenuniq-build.out
