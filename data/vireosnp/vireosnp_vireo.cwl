cwlVersion: v1.2
class: CommandLineTool
baseCommand: vireo
label: vireosnp_vireo
doc: "Vireo: SNP-based deconvolution of multi-sample scRNA-seq data. (Note: The provided
  input text appears to be a container execution error log rather than help text;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/huangyh09/vireoSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vireosnp:0.5.9--pyh7e72e81_0
stdout: vireosnp_vireo.out
