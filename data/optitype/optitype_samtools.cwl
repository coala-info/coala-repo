cwlVersion: v1.2
class: CommandLineTool
baseCommand: optitype_samtools
label: optitype_samtools
doc: "The provided text does not contain help information or usage instructions; it
  is an error log reporting a failure to build a Singularity/Apptainer image due to
  insufficient disk space.\n\nTool homepage: https://github.com/FRED-2/OptiType"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype_samtools.out
