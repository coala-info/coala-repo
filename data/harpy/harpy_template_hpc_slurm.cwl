cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - template
  - hpc-slurm
label: harpy_template_hpc_slurm
doc: "Create a template Snakemake profile for the SLURM scheduler; written to standard output.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs: []
outputs:
  - id: template_file
    type: File
    doc: The template written to standard output
    outputBinding:
      glob: hpc_slurm.yaml
stdout: hpc_slurm.yaml
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
