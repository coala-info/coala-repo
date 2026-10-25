cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligoMatch
label: ucsc-oligomatch
doc: "find perfect matches in sequence. The oligos and the sequence can be .fa, .nib,
  or .2bit files. The oligos may contain IUPAC codes.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: oligos
    type: File
    doc: Oligos as a .fa, .nib or .2bit file (may contain IUPAC codes)
    inputBinding:
      position: 1
  - id: sequence
    type: File
    doc: Sequence to search in, as a .fa, .nib or .2bit file
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Output bed file
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: Output bed file with the matches
    outputBinding:
      glob: $(inputs.out_bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-oligomatch:482--h0b57e2e_0
