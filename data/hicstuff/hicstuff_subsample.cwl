cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicstuff
  - subsample
label: hicstuff_subsample
doc: 'Subsample contacts from a Hi-C matrix. Probability of sampling is proportional
  to the intensity of the bin.


  Tool homepage: https://github.com/koszullab/hicstuff'
inputs:
  - id: contact_map
    type: File
    doc: Sparse contact matrix in graal, bg2 or cool format.
    inputBinding:
      position: 1
  - id: subsampled_prefix
    type: string
    doc: Path without extension to the output map in the same format as the input
      containing only a fraction of the contacts.
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Write even if the output file already exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: prop
    type:
      - 'null'
      - float
    doc: Proportion of contacts to sample from the input matrix if between 0 and 1.
      Raw number of contacts to keep if superior to 1.
    inputBinding:
      position: 103
      prefix: --prop
outputs:
  - id: subsampled_files
    type:
      type: array
      items: File
    doc: Subsampled contact map files (same format as the input).
    outputBinding:
      glob: $(inputs.subsampled_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
