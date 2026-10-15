cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slidejuncs
label: plastid_slidejuncs
doc: 'Slide discovered splice junctions to canonical positions and compare with reference junctions.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: input_bed
    type: File
    doc: BED file describing discovered junctions
    inputBinding:
      position: 1
  - id: outbase
    type: string
    doc: Basename for output files
    inputBinding:
      position: 2
  - id: maxslide
    type:
      - 'null'
      - int
    doc: 'Maximum number of nt to search 5'' and 3'' of intron boundaries (Default: 10)'
    inputBinding:
      position: 101
      prefix: --maxslide
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference file describing known splice junctions
    inputBinding:
      position: 101
      prefix: --ref
  - id: slide_canonical
    type:
      - 'null'
      - boolean
    doc: Slide junctions to canonical junctions if present within equal support region
    inputBinding:
      position: 101
      prefix: --slide_canonical
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: A file of DNA sequence
    inputBinding:
      position: 101
      prefix: --sequence_file
  - id: sequence_format
    type:
      - 'null'
      - string
    doc: 'Format of sequence_file (Default: fasta).'
    inputBinding:
      position: 101
      prefix: --sequence_format
  - id: mask_annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more annotation files (max 1 file if BigBed)
    inputBinding:
      position: 101
      prefix: --mask_annotation_files
  - id: mask_annotation_format
    type:
      - 'null'
      - string
    doc: 'Format of mask_annotation_files (Default: GTF2). Note: GFF3 assembly assumes SO v.2.5.2 feature ontologies, which may or may not match your specific file.'
    inputBinding:
      position: 101
      prefix: --mask_annotation_format
  - id: mask_add_three
    type:
      - 'null'
      - boolean
    doc: If supplied, coding regions will be extended by 3 nucleotides at their 3' ends (except for GTF2 files that explicitly include `stop_codon` features). Use if your annotation file excludes stop codons from CDS.
    inputBinding:
      position: 101
      prefix: --mask_add_three
  - id: mask_tabix
    type:
      - 'null'
      - boolean
    doc: 'mask_annotation_files are tabix-compressed and indexed (Default: False). Ignored for BigBed files.'
    inputBinding:
      position: 101
      prefix: --mask_tabix
  - id: mask_sorted
    type:
      - 'null'
      - boolean
    doc: 'mask_annotation_files are sorted by chromosomal position (Default: False)'
    inputBinding:
      position: 101
      prefix: --mask_sorted
  - id: mask_bed_extra_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Number of extra columns in BED file (e.g. in custom ENCODE formats) or list of names for those columns. (Default: 0).'
    inputBinding:
      position: 101
      prefix: --mask_bed_extra_columns
  - id: mask_maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files. May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 101
      prefix: --mask_maxmem
  - id: mask_gff_transcript_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as transcripts, even if no exons are present (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --mask_gff_transcript_types
  - id: mask_gff_exon_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as exons (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --mask_gff_exon_types
  - id: mask_gff_cds_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as CDS (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --mask_gff_cds_types
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: Files written with the given output basename
    outputBinding:
      glob: $(inputs.outbase)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
