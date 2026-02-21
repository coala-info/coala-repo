cwlVersion: v1.2
class: CommandLineTool
baseCommand: desman_Variant_Filter.py
label: desman_Variant_Filter.py
doc: "The provided text does not contain help information for the tool, but rather
  error messages from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
stdout: desman_Variant_Filter.py.out
