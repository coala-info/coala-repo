cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribotish
  - transplot
label: ribotish_transplot
doc: "Plot the riboseq read profile along a transcript.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: gene_path
    type: File
    doc: "Gene annotation file"
    inputBinding:
      position: 101
      prefix: '-g'
  - id: tid
    type: string
    doc: "Transcript id"
    inputBinding:
      position: 101
      prefix: '-t'
  - id: bam_paths
    type:
      type: array
      items: File
    secondaryFiles:
      - .bai
    doc: "List of riboseq bam files (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-b'
      itemSeparator: ','
  - id: genome_fasta_path
    type: File
    secondaryFiles:
      - .fai
    doc: "Genome fasta file"
    inputBinding:
      position: 101
      prefix: '-f'
  - id: labels
    type:
      - 'null'
      - string
    doc: "Labels for riboseq bam files, comma seperated"
    inputBinding:
      position: 101
      prefix: '-l'
  - id: para
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input offset parameter files for -b bam files"
    inputBinding:
      position: 101
      prefix: '--para'
      itemSeparator: ','
  - id: scale
    type:
      - 'null'
      - string
    doc: "Input scale parameters for bam files, comma seperated"
    inputBinding:
      position: 101
      prefix: '--scale'
  - id: rna
    type:
      - 'null'
      - string
    doc: "Which bam files are RNASeq instead of RiboSeq, 0 based, comma seperated"
    inputBinding:
      position: 101
      prefix: '--rna'
  - id: rna_offset
    type:
      - 'null'
      - int
    doc: "Offset value for RNASeq reads (default: 12)"
    inputBinding:
      position: 101
      prefix: '--rnaoffset'
  - id: rna_color
    type:
      - 'null'
      - string
    doc: "Color for RNASeq tracks, comma seperated, matching --rna option (default: black)"
    inputBinding:
      position: 101
      prefix: '--rnacol'
  - id: ymax
    type:
      - 'null'
      - string
    doc: "Max y scale for tracks, comma seperated (default: auto)"
    inputBinding:
      position: 101
      prefix: '--ymax'
  - id: size
    type:
      - 'null'
      - string
    doc: "Figure size (default: 12,auto)"
    inputBinding:
      position: 101
      prefix: '-s'
  - id: range
    type:
      - 'null'
      - string
    doc: "Range shown on the transcript, format: start,stop (default: full transcript)"
    inputBinding:
      position: 101
      prefix: '-r'
  - id: gene_format
    type:
      - 'null'
      - string
    doc: "Gene annotation file format (gtf, bed, gpd, gff, default: auto)"
    inputBinding:
      position: 101
      prefix: '--geneformat'
  - id: alt
    type:
      - 'null'
      - boolean
    doc: "Use alternative start codons (all codons with 1 base different from ATG)"
    inputBinding:
      position: 101
      prefix: '--alt'
  - id: altcodons
    type:
      - 'null'
      - string
    doc: "Use provided alternative start codons, comma seperated, eg. CTG,GTG,ACG"
    inputBinding:
      position: 101
      prefix: '--altcodons'
  - id: more_cds
    type:
      - 'null'
      - string
    doc: "More cds regions plot in ORF track, format: start1-stop1,start2-stop2..."
    inputBinding:
      position: 101
      prefix: '--morecds'
  - id: more_cds_genome_position
    type:
      - 'null'
      - string
    doc: "More cds regions in genome position, format: start1-stop1,start2-stop2..."
    inputBinding:
      position: 101
      prefix: '--morecdsgp'
  - id: more_cds_box
    type:
      - 'null'
      - boolean
    doc: "Add box to more CDS regions"
    inputBinding:
      position: 101
      prefix: '--morecdsbox'
  - id: more_cds_label
    type:
      - 'null'
      - string
    doc: "Label for more cds regions plot in ORF track, comma seperated"
    inputBinding:
      position: 101
      prefix: '--morecdslabel'
  - id: mark_pept
    type:
      - 'null'
      - string
    doc: "Mark peptide position in morecds, relative to morecds start format: start1-stop1,start2-stop2..."
    inputBinding:
      position: 101
      prefix: '--markpept'
  - id: colorblind
    type:
      - 'null'
      - boolean
    doc: "Use a color style readable for color blind people ('#F00078,#00F000,#0078F0')"
    inputBinding:
      position: 101
      prefix: '--colorblind'
  - id: colors
    type:
      - 'null'
      - string
    doc: "User specified Matplotlib accepted color codes for three frames (default: 'r,g,b')"
    inputBinding:
      position: 101
      prefix: '--colors'
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Reads are paired end"
    inputBinding:
      position: 101
      prefix: '--paired'
  - id: no_compatible_junctions
    type:
      - 'null'
      - boolean
    doc: "Do not require reads compatible with transcript splice junctions"
    inputBinding:
      position: 101
      prefix: '--nocompatible'
  - id: compatible_mis
    type:
      - 'null'
      - int
    doc: "Missed bases allowed in reads compatibility check (default: 2)"
    inputBinding:
      position: 101
      prefix: '--compatiblemis'
  - id: output_path
    type: string
    doc: "Output pdf figure file"
    inputBinding:
      position: 102
      prefix: '-o'
outputs:
  - id: output
    type: File
    doc: "Output pdf figure"
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
stdout: ribotish_transplot.out
