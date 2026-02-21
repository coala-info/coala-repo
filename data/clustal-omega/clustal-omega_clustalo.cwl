cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalo
label: clustal-omega_clustalo
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/hybsearch/clustalo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustal-omega:v1.2.1-1_cv3
stdout: clustal-omega_clustalo.out
