cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffread
label: gffread
doc: "GFF/GTF utility providing format conversions, filtering, FASTA sequence extraction
  and more.\n\nTool homepage: http://ccb.jhu.edu/software/stringtie/gff.shtml"
inputs:
  - id: input_gff
    type: File
    doc: Input GFF/GTF file
    inputBinding:
      position: 1
  - id: cluster_transcripts
    type:
      - 'null'
      - boolean
    doc: Cluster/merge overlapping transcripts
    inputBinding:
      position: 102
      prefix: --merge
  - id: coding_only
    type:
      - 'null'
      - boolean
    doc: 'Coding only: discard mRNAs that have no CDS features'
    inputBinding:
      position: 102
      prefix: -C
  - id: discard_single_exon
    type:
      - 'null'
      - boolean
    doc: Discard single-exon transcripts
    inputBinding:
      position: 102
      prefix: -U
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: Full path to a multi-fasta file with the genomic sequences
    inputBinding:
      position: 102
      prefix: -g
  - id: output_gtf
    type:
      - 'null'
      - boolean
    doc: Main output will be GTF instead of GFF3
    inputBinding:
      position: 102
      prefix: -T
  - id: preserve_ids
    type:
      - 'null'
      - boolean
    doc: Expose and preserve original IDs
    inputBinding:
      position: 102
      prefix: -E
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write the output records into <outfile> instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: cds_fasta
    type:
      - 'null'
      - File
    doc: Write a fasta file with spliced CDS for each GFF transcript
    outputBinding:
      glob: $(inputs.cds_fasta)
  - id: protein_fasta
    type:
      - 'null'
      - File
    doc: Write a fasta file with the protein sequences
    outputBinding:
      glob: $(inputs.protein_fasta)
  - id: exon_fasta
    type:
      - 'null'
      - File
    doc: Write a fasta file with the exon sequences
    outputBinding:
      glob: $(inputs.exon_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffread:0.12.7--h077b44d_6
