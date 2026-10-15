cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagene
  - generate
label: plastid_metagene_generate
doc: 'Generate ROI file and genome-wide positions of start or stop codons (landmarks) for metagene analysis.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: outbase
    type: string
    doc: Basename for output files
    inputBinding:
      position: 1
  - id: landmark
    type:
      - 'null'
      - string
    doc: 'Landmark around which to build metagene profile (Default: cds_start)'
    inputBinding:
      position: 101
      prefix: --landmark
  - id: upstream
    type:
      - 'null'
      - int
    doc: 'Nucleotides to include upstream of landmark (Default: 50)'
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type:
      - 'null'
      - int
    doc: 'Nucleotides to include downstream of landmark (Default: 50)'
    inputBinding:
      position: 101
      prefix: --downstream
  - id: group_by
    type:
      - 'null'
      - string
    doc: 'Attribute (e.g. in GTF2/GFF3 column 9) by which to group regions before generating maximal spanning windows (Default: group transcripts by gene using ''gene_id'' attribute from GTF2, or ''Parent'' attribute in GFF3)'
    inputBinding:
      position: 101
      prefix: --group_by
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
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more annotation files (max 1 file if BigBed)
    inputBinding:
      position: 101
      prefix: --annotation_files
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: 'Format of annotation_files (Default: GTF2). Note: GFF3 assembly assumes SO v.2.5.2 feature ontologies, which may or may not match your specific file.'
    inputBinding:
      position: 101
      prefix: --annotation_format
  - id: add_three
    type:
      - 'null'
      - boolean
    doc: If supplied, coding regions will be extended by 3 nucleotides at their 3' ends (except for GTF2 files that explicitly include `stop_codon` features). Use if your annotation file excludes stop codons from CDS.
    inputBinding:
      position: 101
      prefix: --add_three
  - id: tabix
    type:
      - 'null'
      - boolean
    doc: 'annotation_files are tabix-compressed and indexed (Default: False). Ignored for BigBed files.'
    inputBinding:
      position: 101
      prefix: --tabix
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: 'annotation_files are sorted by chromosomal position (Default: False)'
    inputBinding:
      position: 101
      prefix: --sorted
  - id: bed_extra_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Number of extra columns in BED file (e.g. in custom ENCODE formats) or list of names for those columns. (Default: 0).'
    inputBinding:
      position: 101
      prefix: --bed_extra_columns
  - id: mask_bed_extra_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Number of extra columns in BED file (e.g. in custom ENCODE formats) or list of names for those columns. (Default: 0).'
    inputBinding:
      position: 101
      prefix: --mask_bed_extra_columns
  - id: maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files. May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 101
      prefix: --maxmem
  - id: mask_maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files. May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 101
      prefix: --mask_maxmem
  - id: gff_transcript_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as transcripts, even if no exons are present (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --gff_transcript_types
  - id: gff_exon_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as exons (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --gff_exon_types
  - id: gff_cds_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as CDS (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 101
      prefix: --gff_cds_types
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
