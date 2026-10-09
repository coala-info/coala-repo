cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - template
  - hpc-generic
label: harpy_template_hpc_generic
doc: "Create a template Snakemake profile for a generic HPC scheduler; written to standard output.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs: []
outputs:
  - id: template_file
    type: File
    doc: The template written to standard output
    outputBinding:
      glob: hpc_generic.yaml
stdout: hpc_generic.yaml
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
