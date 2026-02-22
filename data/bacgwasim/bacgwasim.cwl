cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacgwasim
label: bacgwasim
doc: "A tool for simulating bacterial genome-wide association studies (GWAS). (Note:
  The provided text contains system error messages regarding Singularity/Docker image
  extraction and does not contain the actual help documentation for the tool.)\n\n\
  Tool homepage: https://github.com/Morteza-M-Saber/BacGWASim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacgwasim:2.1.1--pyhdfd78af_0
stdout: bacgwasim.out
