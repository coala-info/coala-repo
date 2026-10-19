cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboloco_convert_gtf
label: riboloco_convert_gtf
doc: "Convert a GTF genome annotation and a genome FASTA into the transcript info
  table and the transcript FASTA used by riboloco.\n\nTool homepage: https://github.com/Delayed-Gitification/riboloco.git"
inputs:
  - id: input_gtf
    type: File
    doc: A gtf file with your genome annotation. Can be .gz compressed.
    inputBinding:
      position: 101
      prefix: --input_gtf
  - id: genome_fasta
    type: File
    doc: Genome FASTA file (gzip compressed)
    inputBinding:
      position: 101
      prefix: --genome_fasta
  - id: filter_for_longest
    type:
      - 'null'
      - boolean
    doc: Only use the longest protein coding transcript associated with each 
      gene.
    inputBinding:
      position: 101
      prefix: --filter_for_longest
  - id: no_fasta
    type:
      - 'null'
      - boolean
    doc: Don't generate a fasta of transcripts
    inputBinding:
      position: 101
      prefix: --no_fasta
  - id: stop_correction
    type:
      - 'null'
      - int
    doc: Add 3 nt for stop codon. Can be changed to 0 depending on whether the 
      annotation includes the stop codon within the annotated CDSs.
    inputBinding:
      position: 101
      prefix: --stop_correction
  - id: transcript_word
    type:
      - 'null'
      - string
    doc: Feature type word that marks transcripts
    inputBinding:
      position: 101
      prefix: --transcript_word
  - id: feature_type_word
    type:
      - 'null'
      - string
    doc: Attribute key that holds the transcript type
    inputBinding:
      position: 101
      prefix: --feature_type_word
  - id: filter_for
    type:
      - 'null'
      - string
    doc: Which transcript types to filter for. Set to 'all' to disable. 
      Default=protein_coding
    inputBinding:
      position: 101
      prefix: --filter_for
  - id: gene_name_word
    type:
      - 'null'
      - string
    doc: Attribute key that holds the gene name
    inputBinding:
      position: 101
      prefix: --gene_name_word
  - id: cds_word
    type:
      - 'null'
      - string
    doc: Feature type word that marks CDS
    inputBinding:
      position: 101
      prefix: --cds_word
  - id: gene_id_word
    type:
      - 'null'
      - string
    doc: Attribute key that holds the gene id
    inputBinding:
      position: 101
      prefix: --gene_id_word
  - id: transcript_id_word
    type:
      - 'null'
      - string
    doc: Attribute key that holds the transcript id
    inputBinding:
      position: 101
      prefix: --transcript_id_word
  - id: exon_word
    type:
      - 'null'
      - string
    doc: The key word that signifies exons. Default=exon
    inputBinding:
      position: 101
      prefix: --exon_word
  - id: early_stop
    type:
      - 'null'
      - int
    doc: Stop after n reads parsed. -1 to disable (default)
    inputBinding:
      position: 101
      prefix: --early_stop
  - id: print_features
    type:
      - 'null'
      - boolean
    doc: Print the features found in the annotation
    inputBinding:
      position: 101
      prefix: --print_features
  - id: bypass_tx_type_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter transcripts by type
    inputBinding:
      position: 101
      prefix: --bypass_tx_type_filter
  - id: assume_cds_same
    type:
      - 'null'
      - boolean
    doc: Sets CDS to same as transcript. Useful for writing out eg snoRNAs
    inputBinding:
      position: 101
      prefix: --assume_cds_same
  - id: output_filename
    type: string
    doc: The outfile filename
    inputBinding:
      position: 102
      prefix: --output_filename
outputs:
  - id: info_file
    type: File
    doc: Transcript info table
    outputBinding:
      glob: $(inputs.output_filename)
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: Transcript FASTA (written unless --no_fasta is set)
    outputBinding:
      glob: $(inputs.output_filename).fasta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboloco:0.3.10--pyhdfd78af_0
