cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - get_count_vectors
label: plastid_get_count_vectors
doc: 'Get count vectors (per-nucleotide read counts) over regions of interest and save them as text or other formats.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: out_folder
    type: string
    doc: Folder in which to save output vectors
    inputBinding:
      position: 1
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: 'Prefix to prepend to output files (default: no prefix)'
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: format
    type:
      - 'null'
      - string
    doc: 'printf-style format string for output (default: ''%.8f'')'
    inputBinding:
      position: 101
      prefix: --format
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
  - id: count_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more count or alignment file(s) from a single sample or set of samples to be pooled.
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --count_files
  - id: countfile_format
    type:
      - 'null'
      - string
    doc: 'Format of file containing alignments or counts (Default: BAM)'
    inputBinding:
      position: 101
      prefix: --countfile_format
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: 'Whether counts should be normalized to counts per million (usually not. default: False)'
    inputBinding:
      position: 101
      prefix: --normalize
  - id: sum
    type:
      - 'null'
      - float
    doc: 'Sum used in normalization of counts and RPKM/RPNT calculations (Default: total mapped reads/counts in dataset)'
    inputBinding:
      position: 101
      prefix: --sum
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum read length required to be included (BAM & bowtie files only. Default: 25)'
    inputBinding:
      position: 101
      prefix: --min_length
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length permitted to be included (BAM & bowtie files only. Default: 100)'
    inputBinding:
      position: 101
      prefix: --max_length
  - id: big_genome
    type:
      - 'null'
      - boolean
    doc: Use slower but memory-efficient implementation for big genomes or for memory-limited computers. For wiggle & bowtie files only.
    inputBinding:
      position: 101
      prefix: --big_genome
  - id: fiveprime_variable
    type:
      - 'null'
      - boolean
    doc: Map read alignment to a variable offset from 5' position of read, with offset determined by read length. Requires `--offset` below
    inputBinding:
      position: 101
      prefix: --fiveprime_variable
  - id: fiveprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 5' position.
    inputBinding:
      position: 101
      prefix: --fiveprime
  - id: threeprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 3' position
    inputBinding:
      position: 101
      prefix: --threeprime
  - id: center
    type:
      - 'null'
      - boolean
    doc: Subtract N positions from each end of read, and add 1/(length-N), to each remaining position, where N is specified by `--nibble`
    inputBinding:
      position: 101
      prefix: --center
  - id: offset
    type:
      - 'null'
      - int
      - File
    doc: 'For `--fiveprime` or `--threeprime`, provide an integer representing the offset into the read, starting from either the 5'' or 3'' end, at which data should be plotted. For `--fiveprime_variable`, provide the filename of a two-column tab-delimited text file, in which first column represents read length or the special keyword `''default''`, and the second column represents the offset from the five prime end of that read length at which the read should be mapped. (Default: 0)'
    inputBinding:
      position: 101
      prefix: --offset
  - id: nibble
    type:
      - 'null'
      - int
    doc: 'For use with `--center` only. nt to remove from each end of read before mapping (Default: 0)'
    inputBinding:
      position: 101
      prefix: --nibble
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
  - id: out_folder_dir
    type: Directory
    doc: Folder with the saved count vectors
    outputBinding:
      glob: $(inputs.out_folder)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
