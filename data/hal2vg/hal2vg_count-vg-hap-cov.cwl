cwlVersion: v1.2
class: CommandLineTool
baseCommand: hal2vg_count-vg-hap-cov
label: hal2vg_count-vg-hap-cov
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  'no space left on device' failure during image conversion.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg_count-vg-hap-cov.out
