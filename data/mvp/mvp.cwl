cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvp
label: mvp
doc: "Motif-Variant Probe: detect motif gain and loss due to mutations\n\nTool homepage:
  https://gitlab.com/LPCDRP/motif-variants"
inputs:
  - id: infile
    type: File
    doc: vcf or vcf.gz file containing mutations
    inputBinding:
      position: 1
  - id: motif_file
    type:
      - 'null'
      - File
    doc: file containing a list of motifs to check
    inputBinding:
      position: 102
      prefix: --motif-file
  - id: motif_list
    type:
      - 'null'
      - string
    doc: a comma-delimited string of motifs to check
    inputBinding:
      position: 102
      prefix: --motif-list
  - id: reference
    type: File
    doc: reference sequence in fasta format
    inputBinding:
      position: 102
      prefix: --reference
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: DNA or amino acid
    inputBinding:
      position: 102
      prefix: --sequence-type
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: results table
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvp:0.4.3--py35_0
