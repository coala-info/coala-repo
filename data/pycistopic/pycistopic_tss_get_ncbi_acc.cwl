cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - tss
  - get_ncbi_acc
label: pycistopic_tss_get_ncbi_acc
doc: "Get NCBI assembly accession numbers and assembly names for a certain species.\n\nTool homepage: https://github.com/aertslab/pycisTopic"
inputs:
  - id: species
    type: string
    doc: "Species name (latin name) for which to look for NCBI assembly accession numbers, e.g. homo sapiens."
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic_tss_get_ncbi_acc.out
