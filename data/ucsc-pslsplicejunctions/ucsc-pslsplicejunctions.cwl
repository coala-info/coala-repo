cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSpliceJunctions
label: ucsc-pslsplicejunctions
doc: "Extract splice junctions from a PSL file. Outputs query and target coordinates
  of target gaps, often introns, in alignments. Output is always in query-positive
  and target-positive coordinates, with only gaps in the target reported. Canonical
  junctions are in upper case, unknown ones in lower case.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: genome_2bit
    type: File
    doc: Target genome sequence in .2bit format.
    inputBinding:
      position: 2
  - id: junctions_tsv
    type: string
    doc: Output junctions file name (TSV).
    inputBinding:
      position: 3
outputs:
  - id: junctions_out
    type: File
    doc: Output splice junctions TSV file.
    outputBinding:
      glob: $(inputs.junctions_tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsplicejunctions:482--h0b57e2e_0
