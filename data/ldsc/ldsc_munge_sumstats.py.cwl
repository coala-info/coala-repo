cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldsc_munge_sumstats.py
label: ldsc_munge_sumstats.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build a Singularity/Apptainer
  container due to insufficient disk space.\n\nTool homepage: https://github.com/bulik/ldsc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldsc:1.0.1--py_0
stdout: ldsc_munge_sumstats.py.out
