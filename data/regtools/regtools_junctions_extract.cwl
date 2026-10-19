cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - junctions
  - extract
label: regtools_junctions_extract
doc: "Identify exon-exon junctions from alignments.\n\nTool homepage: https://github.com/griffithlab/regtools"
inputs:
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
  - id: output_file
    type: string
    doc: "The file to write output to."
    inputBinding:
      position: 1
      prefix: -o
  - id: region
    type:
      - 'null'
      - string
    doc: "The region to identify junctions in 'chr:start-end' format. Entire BAM by default."
    inputBinding:
      position: 1
      prefix: -r
  - id: strandness
    type: string
    doc: "Strandness mode. XS, use XS tags provided by aligner; RF, first-strand; FR, second-strand. REQUIRED"
    inputBinding:
      position: 1
      prefix: -s
  - id: strand_tag
    type:
      - 'null'
      - string
    doc: "Tag used in bam to label strand. [XS]"
    inputBinding:
      position: 1
      prefix: -t
  - id: barcodes
    type:
      - 'null'
      - File
    doc: "The file containing the barcodes of interest for single cell data."
    inputBinding:
      position: 1
      prefix: -b
  - id: alignments
    type: File
    doc: "Indexed alignments (BAM)."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 100
outputs:
  - id: out_output_file
    type: File
    doc: "Junctions in BED12 format"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
