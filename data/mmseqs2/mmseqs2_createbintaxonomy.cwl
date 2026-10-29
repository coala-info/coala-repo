cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createbintaxonomy
label: mmseqs2_createbintaxonomy
doc: 'Create a binary taxonomy file from the NCBI names.dmp, nodes.dmp and merged.dmp files.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: names_dmp
    type: File
    doc: NCBI names.dmp
    inputBinding:
      position: 1
  - id: nodes_dmp
    type: File
    doc: NCBI nodes.dmp
    inputBinding:
      position: 2
  - id: merged_dmp
    type: File
    doc: NCBI merged.dmp
    inputBinding:
      position: 3
  - id: taxonomy_file
    type: string
    doc: Name of the output binary taxonomy file (use <name>_taxonomy to attach it to a database
      named <name>)
    inputBinding:
      position: 4
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_taxonomy
    type: File
    doc: Binary taxonomy file
    outputBinding:
      glob: $(inputs.taxonomy_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
