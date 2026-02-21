cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase_run_ase_genotype_specific_references.sbatch
label: bayesase_run_ase_genotype_specific_references.sbatch
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding disk space during a container
  build process.\n\nTool homepage: https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase_run_ase_genotype_specific_references.sbatch.out
