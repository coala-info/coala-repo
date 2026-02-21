cwlVersion: v1.2
class: CommandLineTool
baseCommand: molpopgen-analysis
label: molpopgen-analysis
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build a Singularity/Apptainer container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/molpopgen/analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/molpopgen-analysis:0.8.8--ha24e720_10
stdout: molpopgen-analysis.out
