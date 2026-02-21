cwlVersion: v1.2
class: CommandLineTool
baseCommand: kgwasflow
label: kgwasflow
doc: "A k-mer based GWAS pipeline. (Note: The provided text is a container runtime
  error log and does not contain usage instructions or argument definitions.)\n\n
  Tool homepage: https://github.com/akcorut/kGWASflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kgwasflow:1.3.0--pyhdfd78af_1
stdout: kgwasflow.out
