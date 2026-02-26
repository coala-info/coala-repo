cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer2circos
label: mummer2circos
doc: "Convert MUMmer output to Circos plots.\n\nTool homepage: https://github.com/metagenlab/mummer2circos"
inputs:
  - id: algo
    type:
      - 'null'
      - string
    doc: algorythm to use to compare the genome (megablast, nucmer or promer)
    inputBinding:
      position: 101
      prefix: --algo
  - id: blast
    type:
      - 'null'
      - File
    doc: input fasta file (aa sequence) for BLAST
    inputBinding:
      position: 101
      prefix: --blast
  - id: blast_identity_cutoff
    type:
      - 'null'
      - float
    doc: Blast identity cutoff
    inputBinding:
      position: 101
      prefix: --blast_identity_cutoff
  - id: blastn
    type:
      - 'null'
      - boolean
    doc: excute blastn and not blastp
    inputBinding:
      position: 101
      prefix: --blastn
  - id: condensed
    type:
      - 'null'
      - boolean
    doc: condensed display (for mor tracks)
    inputBinding:
      position: 101
      prefix: --condensed
  - id: fasta1
    type:
      - 'null'
      - File
    doc: reference fasta
    inputBinding:
      position: 101
      prefix: --fasta1
  - id: fasta2
    type:
      - 'null'
      - type: array
        items: File
    doc: query fasta
    inputBinding:
      position: 101
      prefix: --fasta2
  - id: filterq
    type:
      - 'null'
      - boolean
    doc: do not remove query sequences without any similarity from the plot
    default: false
    inputBinding:
      position: 101
      prefix: --filterq
  - id: filterr
    type:
      - 'null'
      - boolean
    doc: do not remove reference sequences without any similarity from the plot
    default: false
    inputBinding:
      position: 101
      prefix: --filterr
  - id: force
    type:
      - 'null'
      - boolean
    doc: Don't prompt before every removal
    inputBinding:
      position: 101
      prefix: --force
  - id: gaps
    type:
      - 'null'
      - boolean
    doc: highlight gaps
    inputBinding:
      position: 101
      prefix: --gaps
  - id: genbank
    type:
      - 'null'
      - File
    doc: add ORF based on GBK file
    inputBinding:
      position: 101
      prefix: --genbank
  - id: highlight
    type:
      - 'null'
      - type: array
        items: string
    doc: highlight instead of heatmap corresponding list of records
    inputBinding:
      position: 101
      prefix: --highlight
  - id: label_file
    type:
      - 'null'
      - File
    doc: 'label file ==> tab file with: contig, start, end label (and color)'
    inputBinding:
      position: 101
      prefix: --label_file
  - id: link
    type:
      - 'null'
      - boolean
    doc: link circos and not heatmap circos
    inputBinding:
      position: 101
      prefix: --link
  - id: locus_taxonomy
    type:
      - 'null'
      - File
    doc: 'Color locus based on taxonomy: tab delimited file with: locus phylum. Color
      locus matching the Taxon set in comment as the first row (#Chlamydiae)'
    inputBinding:
      position: 101
      prefix: --locus_taxonomy
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: minimum gap size to consider
    inputBinding:
      position: 101
      prefix: --min_gap_size
  - id: output_name
    type:
      - 'null'
      - string
    doc: output circos pefix
    inputBinding:
      position: 101
      prefix: --output_name
  - id: samtools_depth
    type:
      - 'null'
      - type: array
        items: File
    doc: samtools depth file
    inputBinding:
      position: 101
      prefix: --samtools_depth
  - id: secretion_systems
    type:
      - 'null'
      - string
    doc: macsyfinder table
    inputBinding:
      position: 101
      prefix: --secretion_systems
  - id: window
    type:
      - 'null'
      - int
    doc: window size
    default: 1000
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer2circos:1.4.2--pyhdfd78af_0
stdout: mummer2circos.out
