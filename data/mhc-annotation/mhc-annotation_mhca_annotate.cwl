cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhca
  - annotate
label: mhc-annotation_mhca_annotate
doc: "Annotate a human MHC haplotype (FASTA) with gene and transcript information (GFF3 and feature table).\n\
  \nTool homepage: https://github.com/DiltheyLab/MHC-annotation"
inputs:
  - id: skip_imgt
    type:
      - 'null'
      - boolean
    doc: Use this if you don't want to use IMGT as a data source.
    inputBinding:
      position: 101
      prefix: --skip_imgt
  - id: skip_rsg
    type:
      - 'null'
      - boolean
    doc: Use this if you don't want to use RefSeqGene as a data source.
    inputBinding:
      position: 101
      prefix: --skip_rsg
  - id: skip_rs
    type:
      - 'null'
      - boolean
    doc: Use this if you don't want to use RefSeq as a data source.
    inputBinding:
      position: 101
      prefix: --skip_rs
  - id: skip_mapping
    type:
      - 'null'
      - boolean
    doc: If you already have used minimap2 and want to skip this step.
    inputBinding:
      position: 101
      prefix: --skip_mapping
  - id: locus_tag_prefix
    type:
      - 'null'
      - File
    doc: Comma separated file containing the locus_tag_prefix for the haplotype.
    inputBinding:
      position: 101
      prefix: --locus_tag_prefix
  - id: manual_corrections
    type:
      - 'null'
      - File
    doc: Comma separated file with manual corrections.
    inputBinding:
      position: 101
      prefix: --manual_corrections
  - id: imgt_folder
    type:
      - 'null'
      - Directory
    doc: Folder which holds the start to stop codon fastas and the full fastas with exon boundary information.
    inputBinding:
      position: 101
      prefix: --imgt_folder
  - id: refseqgene_full_fasta
    type:
      - 'null'
      - File
    doc: Fasta file with exon boundary information (boundaries denoted as '|') generated from the RefSeqGene
      genbank file. If omitted, a precompiled version is used.
    inputBinding:
      position: 101
      prefix: --refseqgene_full_fasta
  - id: refseq_full_fasta
    type:
      - 'null'
      - File
    doc: Fasta file with exon boundary information (boundaries denoted as '|') generated from a RefSeq
      dataset. If omitted, a precompiled version is used.
    inputBinding:
      position: 101
      prefix: --refseq_full_fasta
  - id: haplotype
    type: File
    doc: Input haplotype in fasta format.
    inputBinding:
      position: 201
  - id: output_folder
    type: string
    doc: Output folder (created for the run; receives the .gff, .tbl, .choices and .paf files).
    inputBinding:
      position: 202
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder with the annotation (.gff, .tbl) and intermediate files.
    outputBinding:
      glob: $(inputs.output_folder)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({''class'': ''Directory'', ''basename'': inputs.output_folder, ''listing'': []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
