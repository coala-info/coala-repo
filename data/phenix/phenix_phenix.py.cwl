cwlVersion: v1.2
class: CommandLineTool
baseCommand: phenix_phenix.py
label: phenix_phenix.py
doc: "Phenix: Python-based Hierarchical ENvironment for Integrated X-ray crystallography.
  (Note: The provided text appears to be a container execution log rather than help
  documentation; no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/phe-bioinformatics/PHEnix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h3dcb392_1
stdout: phenix_phenix.py.out
