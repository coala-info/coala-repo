cwlVersion: v1.2
class: CommandLineTool
baseCommand: cider
label: hmftools-cider_cider.jar
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime failure
  (no space left on device).\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/cider/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-cider:1.1--hdfd78af_0
stdout: hmftools-cider_cider.jar.out
