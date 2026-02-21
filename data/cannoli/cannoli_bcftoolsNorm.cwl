cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - bcftoolsNorm
label: cannoli_bcftoolsNorm
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_bcftoolsNorm.out
