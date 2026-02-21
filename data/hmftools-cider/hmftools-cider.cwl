cwlVersion: v1.2
class: CommandLineTool
baseCommand: cider
label: hmftools-cider
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/hartwigmedical/hmftools/blob/master/cider/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-cider:1.1--hdfd78af_0
stdout: hmftools-cider.out
