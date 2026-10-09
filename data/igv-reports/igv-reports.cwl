cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_report
label: igv-reports
doc: "Generate self-contained HTML reports for viewing genomic data in IGV (igv.js): a
  table of sites (VCF, BED, GFF, bedpe, or tab-delimited) with an IGV view of each
  site.\n\nTool homepage: https://github.com/igvteam/igv-reports"
inputs:
  - id: sites
    type: File
    doc: "Sites file defining the report rows: vcf, bed, bedpe, gff or tab-delimited (required)"
    inputBinding:
      position: 1
  - id: fasta
    type: ['null', File]
    doc: "Reference fasta file. One of fasta, twobit or genome is required."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 102
      prefix: --fasta
  - id: twobit
    type: ['null', File]
    doc: "Reference twobit file"
    inputBinding:
      position: 102
      prefix: --twobit
  - id: genome
    type: ['null', string]
    doc: "igv.js genome id (e.g. hg38)"
    inputBinding:
      position: 102
      prefix: --genome
  - id: type
    type: ['null', string]
    doc: "Report type: mutation, junction or fusion (default mutation)"
    inputBinding:
      position: 102
      prefix: --type
  - id: ideogram
    type: ['null', File]
    doc: "Ideogram file in UCSC cytoIdeo format"
    inputBinding:
      position: 102
      prefix: --ideogram
  - id: tracks
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of track files (bam, cram, vcf, bed, gff, bigwig, bedgraph); indexes are staged when present"
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
      - pattern: .idx
        required: false
    inputBinding:
      position: 102
      prefix: --tracks
  - id: track_config
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of track json files"
    inputBinding:
      position: 102
      prefix: --track-config
  - id: roi
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of region-of-interest files"
    inputBinding:
      position: 102
      prefix: --roi
  - id: sort
    type: ['null', string]
    doc: "Initial sort option for alignment tracks (BASE, STRAND, INSERT_SIZE, MATE_CHR)"
    inputBinding:
      position: 102
      prefix: --sort
  - id: template
    type: ['null', File]
    doc: "HTML template file"
    inputBinding:
      position: 102
      prefix: --template
  - id: info_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of VCF info field names to include in the variant table"
    inputBinding:
      position: 102
      prefix: --info-columns
  - id: info_columns_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of prefixes of VCF info field names to include in the variant table"
    inputBinding:
      position: 102
      prefix: --info-columns-prefixes
  - id: sampleinfo
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of sample information files"
    inputBinding:
      position: 102
      prefix: --sampleinfo
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space delimited list of sample (genotype) names, used with sample_columns"
    inputBinding:
      position: 102
      prefix: --samples
  - id: sample_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of VCF sample (genotype) FORMAT field names to include in the variant table"
    inputBinding:
      position: 102
      prefix: --sample-columns
  - id: flanking
    type: ['null', int]
    doc: "Genomic region to include either side of the variant"
    inputBinding:
      position: 102
      prefix: --flanking
  - id: window
    type: ['null', int]
    doc: "Initial visible window size in bp (igv.js default 41)"
    inputBinding:
      position: 102
      prefix: --window
  - id: standalone
    type: ['null', boolean]
    doc: "Embed javascript as well as data in the output html"
    inputBinding:
      position: 102
      prefix: --standalone
  - id: title
    type: ['null', string]
    doc: "Optional title string inserted into the html title tag"
    inputBinding:
      position: 102
      prefix: --title
  - id: header
    type: ['null', string]
    doc: "Optional header html string inserted before the variant table"
    inputBinding:
      position: 102
      prefix: --header
  - id: footer
    type: ['null', string]
    doc: "Optional footer html string inserted below the igv.js viewer"
    inputBinding:
      position: 102
      prefix: --footer
  - id: sequence
    type: ['null', string]
    doc: "Column of sequence (chromosome) name, for a tab-delimited sites file"
    inputBinding:
      position: 102
      prefix: --sequence
  - id: begin
    type: ['null', string]
    doc: "Column of start position, for a tab-delimited sites file"
    inputBinding:
      position: 102
      prefix: --begin
  - id: end
    type: ['null', string]
    doc: "Column of end position, for a tab-delimited sites file"
    inputBinding:
      position: 102
      prefix: --end
  - id: zero_based
    type: ['null', string]
    doc: "Specify that the position in the data file is 0-based rather than 1-based"
    inputBinding:
      position: 102
      prefix: --zero_based
  - id: idlink
    type: ['null', string]
    doc: "Url link template for the VCF ID column"
    inputBinding:
      position: 102
      prefix: --idlink
  - id: exclude_flags
    type: ['null', string]
    doc: "Passed to samtools to filter alignments (BAM and CRAM files)"
    inputBinding:
      position: 102
      prefix: --exclude-flags
  - id: no_embed
    type: ['null', boolean]
    doc: "Do not embed fasta or track data (not common)"
    inputBinding:
      position: 102
      prefix: --no-embed
  - id: subsample
    type: ['null', double]
    doc: "Subsample bam files, keeping this fraction (0.0 - 1.0) of alignments"
    inputBinding:
      position: 102
      prefix: --subsample
  - id: maxlen
    type: ['null', int]
    doc: "Maximum length of variant for single view; longer ones are shown split-screen"
    inputBinding:
      position: 102
      prefix: --maxlen
  - id: translate_sequence_track
    type: ['null', boolean]
    doc: "Three-frame translate sequence track"
    inputBinding:
      position: 102
      prefix: --translate-sequence-track
  - id: tabulator
    type: ['null', boolean]
    doc: "Enable Tabulator table with advanced filtering"
    inputBinding:
      position: 102
      prefix: --tabulator
  - id: filter_config
    type: ['null', File]
    doc: "YAML configuration file for column-specific filtering"
    inputBinding:
      position: 102
      prefix: --filter-config
  - id: merge_overlaps
    type: ['null', boolean]
    doc: "Merge overlapping regions for multi-locus features (e.g. bedpe)"
    inputBinding:
      position: 102
      prefix: --merge-overlaps
  - id: output_path
    type: string
    doc: "Output HTML file name"
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output HTML report
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv-reports:1.16.0--pyh7e72e81_0
