cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - cis-splice-effects
  - identify
label: regtools_cis-splice-effects_identify
doc: "Identify splice variants and aberrant junctions from variants and alignments.\n\nTool homepage: https://github.com/griffithlab/regtools"
inputs:
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file containing the aberrant splice junctions with annotations. [STDOUT]"
    inputBinding:
      position: 1
      prefix: -o
  - id: output_variants
    type:
      - 'null'
      - string
    doc: "Output file containing variants annotated as splice relevant (VCF format)."
    inputBinding:
      position: 1
      prefix: -v
  - id: output_junctions
    type:
      - 'null'
      - string
    doc: "Output file containing the aberrant junctions in BED12 format."
    inputBinding:
      position: 1
      prefix: -j
  - id: strandness
    type: string
    doc: "Strandness mode. XS, use XS tags provided by aligner; RF, first-strand; FR, second-strand. intron-motif, infer strand using canonical intron motifs. REQUIRED"
    inputBinding:
      position: 1
      prefix: -s
  - id: intron_motif_override
    type:
      - 'null'
      - boolean
    doc: "Override strand assignments by inferring based on canonical motifs. Does not need to be specified if passing '-s intron-motif'."
    inputBinding:
      position: 1
      prefix: -C
  - id: strand_tag
    type:
      - 'null'
      - string
    doc: "Tag used in bam to label strand. [XS]"
    inputBinding:
      position: 1
      prefix: -t
  - id: min_anchor_length
    type:
      - 'null'
      - int
    doc: "Minimum anchor length. Junctions which satisfy a minimum anchor length on both sides are reported. [8]"
    inputBinding:
      position: 1
      prefix: -a
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: "Minimum intron length. [70]"
    inputBinding:
      position: 1
      prefix: -m
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: "Maximum intron length. [500000]"
    inputBinding:
      position: 1
      prefix: -M
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size in b.p to identify splicing events in. The tool identifies events in variant.start +/- w basepairs. Default behaviour is to look at the window between previous and next exons."
    inputBinding:
      position: 1
      prefix: -w
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
  - id: barcodes
    type:
      - 'null'
      - File
    doc: "The file containing the barcodes of interest for single cell data."
    inputBinding:
      position: 1
      prefix: -b
  - id: variants
    type: File
    doc: "Variants (VCF)."
    inputBinding:
      position: 100
  - id: alignments
    type: File
    doc: "Alignments (BAM)."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 101
  - id: reference
    type: File
    doc: "Reference genome FASTA (ref.fa)."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 102
  - id: annotations
    type: File
    doc: "Gene annotations in GTF format."
    inputBinding:
      position: 103
outputs:
  - id: out_output_file
    type:
      - 'null'
      - File
    doc: "Aberrant splice junctions with annotations"
    outputBinding:
      glob: $(inputs.output_file)
  - id: out_output_variants
    type:
      - 'null'
      - File
    doc: "Splice relevant variants (VCF)"
    outputBinding:
      glob: $(inputs.output_variants)
  - id: out_output_junctions
    type:
      - 'null'
      - File
    doc: "Aberrant junctions (BED12)"
    outputBinding:
      glob: $(inputs.output_junctions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
