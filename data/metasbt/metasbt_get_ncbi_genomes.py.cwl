cwlVersion: v1.2
class: CommandLineTool
baseCommand: metasbt_get_ncbi_genomes.py
label: metasbt_get_ncbi_genomes.py
doc: "A tool for retrieving NCBI genomes. (Note: The provided help text contains system
  error messages regarding container execution and does not list usage instructions
  or arguments.)\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_get_ncbi_genomes.py.out
