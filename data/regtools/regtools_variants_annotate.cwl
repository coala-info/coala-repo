cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - variants
  - annotate
label: regtools_variants_annotate
doc: "Annotate variants with splicing information.\n\nTool homepage: https://github.com/griffithlab/regtools"
inputs:
  - id: output_file
    type: string
    doc: "The file to write output to."
    inputBinding:
      position: 1
      prefix: -o
  - id: max_exonic_distance
    type:
      - 'null'
      - int
    doc: "Maximum distance from the start/end of an exon to annotate a variant as relevant to splicing, the variant is in exonic space, i.e a coding variant. [3]"
    inputBinding:
      position: 1
      prefix: -e
  - id: max_intronic_distance
    type:
      - 'null'
      - int
    doc: "Maximum distance from the start/end of an exon to annotate a variant as relevant to splicing, the variant is in intronic space. [2]"
    inputBinding:
      position: 1
      prefix: -i
  - id: intronic_in_transcript
    type:
      - 'null'
      - boolean
    doc: "Annotate variants in intronic space within a transcript (not to be used with -i)."
    inputBinding:
      position: 1
      prefix: -I
  - id: exonic_in_transcript
    type:
      - 'null'
      - boolean
    doc: "Annotate variants in exonic space within a transcript (not to be used with -e)."
    inputBinding:
      position: 1
      prefix: -E
  - id: single_exon_transcripts
    type:
      - 'null'
      - boolean
    doc: "Don't skip single exon transcripts."
    inputBinding:
      position: 1
      prefix: -S
  - id: variants
    type: File
    doc: "Variants in VCF format."
    inputBinding:
      position: 100
  - id: annotations
    type: File
    doc: "Gene annotations in GTF format."
    inputBinding:
      position: 101
outputs:
  - id: out_output_file
    type: File
    doc: "Annotated variants (VCF)"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
