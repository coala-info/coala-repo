cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mg-toolkit
  - original_metadata
label: mg-toolkit_original_metadata
doc: "Retrieve original metadata for given study accessions using mg-toolkit.\n\n\
  Tool homepage: https://github.com/EBI-metagenomics/emg-toolkit"
inputs:
  - id: accession
    type:
      type: array
      items: string
    doc: Provide study accession, e.g. PRJEB1787 or ERP001736.
    inputBinding:
      position: 101
      prefix: --accession
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
stdout: mg-toolkit_original_metadata.out
