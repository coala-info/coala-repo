cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_minimap2
label: cannoli_minimap2
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_minimap2.out
