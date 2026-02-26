cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotish_transplot
label: ribotish_transplot
doc: "Plotting tool for riboseq and rnaseq data aligned to transcripts.\n\nTool homepage:
  https://github.com/zhpn1024/ribotish"
inputs:
  - id: alternative_codons
    type:
      - 'null'
      - type: array
        items: string
    doc: Use provided alternative start codons, comma seperated, eg. CTG,GTG,ACG
    inputBinding:
      position: 101
      prefix: --altcodons
  - id: alternative_start_codons
    type:
      - 'null'
      - boolean
    doc: Use alternative start codons (all codons with 1 base different from 
      ATG)
    inputBinding:
      position: 101
      prefix: --alt
  - id: bam_paths
    type:
      type: array
      items: File
    doc: List of riboseq bam files, comma seperated
    inputBinding:
      position: 101
      prefix: --b
  - id: colorblind
    type:
      - 'null'
      - boolean
    doc: Use a color style readable for color blind people 
      ('#F00078,#00F000,#0078F0')
    inputBinding:
      position: 101
      prefix: --colorblind
  - id: colors
    type:
      - 'null'
      - string
    doc: User specified Matplotlib accepted color codes for three frames
    default: r,g,b
    inputBinding:
      position: 101
      prefix: --colors
  - id: compatible_mismatches
    type:
      - 'null'
      - int
    doc: Missed bases allowed in reads compatibility check
    default: 2
    inputBinding:
      position: 101
      prefix: --compatiblemis
  - id: gene_format
    type:
      - 'null'
      - string
    doc: 'Gene annotation file format (gtf, bed, gpd, gff, default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --geneformat
  - id: gene_path
    type: File
    doc: Gene annotation file
    inputBinding:
      position: 101
      prefix: --g
  - id: genome_fasta_path
    type: File
    doc: Genome fasta file
    inputBinding:
      position: 101
      prefix: --f
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels for riboseq bam files, comma seperated
    inputBinding:
      position: 101
      prefix: --l
  - id: mark_peptide
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Mark peptide position in morecds, relative to morecds start format: start1-stop1,start2-stop2...'
    inputBinding:
      position: 101
      prefix: --markpept
  - id: more_cds
    type:
      - 'null'
      - type: array
        items: string
    doc: 'More cds regions plot in ORF track, format: start1-stop1,start2-stop2...'
    inputBinding:
      position: 101
      prefix: --morecds
  - id: more_cds_box
    type:
      - 'null'
      - boolean
    doc: Add box to more CDS regions
    inputBinding:
      position: 101
      prefix: --morecdsbox
  - id: more_cds_genome_position
    type:
      - 'null'
      - type: array
        items: string
    doc: 'More cds regions in genome position, format: start1-stop1,start2-stop2...'
    inputBinding:
      position: 101
      prefix: --morecdsgp
  - id: more_cds_label
    type:
      - 'null'
      - type: array
        items: string
    doc: Label for more cds regions plot in ORF track, comma seperated
    inputBinding:
      position: 101
      prefix: --morecdslabel
  - id: no_compatible
    type:
      - 'null'
      - boolean
    doc: Do not require reads compatible with transcript splice junctions
    inputBinding:
      position: 101
      prefix: --nocompatible
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Reads are paired end
    inputBinding:
      position: 101
      prefix: --paired
  - id: para
    type:
      - 'null'
      - type: array
        items: File
    doc: Input offset parameter files for -b bam files
    inputBinding:
      position: 101
      prefix: --para
  - id: range
    type:
      - 'null'
      - string
    doc: 'Range shown on the transcript, format: start,stop'
    inputBinding:
      position: 101
      prefix: --r
  - id: rna
    type:
      - 'null'
      - type: array
        items: int
    doc: Which bam files are RNASeq instead of RiboSeq, 0 based, comma seperated
    inputBinding:
      position: 101
      prefix: --rna
  - id: rna_color
    type:
      - 'null'
      - type: array
        items: string
    doc: Color for RNASeq tracks, comma seperated, matching --rna option
    default: black
    inputBinding:
      position: 101
      prefix: --rnacol
  - id: rna_offset
    type:
      - 'null'
      - int
    doc: Offset value for RNASeq reads
    default: 12
    inputBinding:
      position: 101
      prefix: --rnaoffset
  - id: scale
    type:
      - 'null'
      - type: array
        items: float
    doc: Input scale parameters for bam files, comma seperated
    inputBinding:
      position: 101
      prefix: --scale
  - id: size
    type:
      - 'null'
      - string
    doc: Figure size
    default: 12,auto
    inputBinding:
      position: 101
      prefix: --s
  - id: transcript_id
    type: string
    doc: Transcript id
    inputBinding:
      position: 101
      prefix: --t
  - id: ymax
    type:
      - 'null'
      - type: array
        items: string
    doc: Max y scale for tracks, comma seperated
    default: auto
    inputBinding:
      position: 101
      prefix: --ymax
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output pdf figure file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
