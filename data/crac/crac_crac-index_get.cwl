cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crac-index
  - get
label: crac_crac-index_get
doc: "Get a (multi)FASTA file containing the original sequences stored in a CRAC
  index\n\nTool homepage: http://crac.gforge.inria.fr/"
inputs:
  - id: output_fasta_path
    type: string
    doc: output (multi)FASTA file for the extracted sequences
    inputBinding:
      position: 102
  - id: index
    type: File
    doc: CRAC index; give the .ssa file made by crac-index index, with its .conf 
      file beside it (passed without the extension)
    secondaryFiles:
      - ^.conf
    inputBinding:
      position: 103
      valueFrom: $(self.path.replace(/\.ssa$/, ''))
outputs:
  - id: output_fasta
    type: File
    doc: (multi)FASTA file with the sequences indexed in the index
    outputBinding:
      glob: $(inputs.output_fasta_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
