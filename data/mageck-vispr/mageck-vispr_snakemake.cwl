cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mageck-vispr
  - snakemake
label: mageck-vispr_snakemake
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Singularity/Apptainer) indicating a 'no space left on device'
  failure while attempting to pull the mageck-vispr image.\n\nTool homepage: https://bitbucket.org/liulab/mageck-vispr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
stdout: mageck-vispr_snakemake.out
