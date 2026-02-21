cwlVersion: v1.2
class: CommandLineTool
baseCommand: rilseq_RILseq_significant_regions.py
label: rilseq_RILseq_significant_regions.py
doc: "Significant regions identification for RIL-seq data. (Note: The provided text
  contains container runtime error messages and does not include the tool's help documentation
  or usage instructions.)\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_RILseq_significant_regions.py.out
