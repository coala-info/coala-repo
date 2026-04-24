cwlVersion: v1.2
class: CommandLineTool
baseCommand: counts_in_region
label: plastid_counts_in_region
doc: "Count the number of read alignments covering regions of interest in the genome,
  and calculate read densities (in reads per nucleotide and in RPKM) over these regions.\n\
  \nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs:
  - id: outfile
    type: File
    doc: Output filename
    inputBinding:
      position: 1
  - id: add_three
    type:
      - 'null'
      - boolean
    doc: If supplied, coding regions will be extended by 3 nucleotides at their 
      3' ends (except for GTF2 files that explicitly include `stop_codon` 
      features). Use if your annotation file excludes stop codons from CDS.
    inputBinding:
      position: 102
      prefix: --add_three
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more annotation files (max 1 file if BigBed)
    inputBinding:
      position: 102
      prefix: --annotation_files
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: 'Format of annotation_files (Default: GTF2). Note: GFF3 assembly assumes
      SO v.2.5.2 feature ontologies, which may or may not match your specific file.'
    inputBinding:
      position: 102
      prefix: --annotation_format
  - id: bed_extra_columns
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Number of extra columns in BED file (e.g. in custom ENCODE formats) or list
      of names for those columns. (Default: 0).'
    inputBinding:
      position: 102
      prefix: --bed_extra_columns
  - id: big_genome
    type:
      - 'null'
      - boolean
    doc: Use slower but memory-efficient implementation for big genomes or for 
      memory-limited computers. For wiggle & bowtie files only.
    inputBinding:
      position: 102
      prefix: --big_genome
  - id: center
    type:
      - 'null'
      - boolean
    doc: Subtract N positions from each end of read, and add 1/(length-N), to 
      each remaining position, where N is specified by `--nibble`
    inputBinding:
      position: 102
      prefix: --center
  - id: count_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more count or alignment file(s) from a single sample or set of 
      samples to be pooled.
    inputBinding:
      position: 102
      prefix: --count_files
  - id: countfile_format
    type:
      - 'null'
      - string
    doc: Format of file containing alignments or counts
    inputBinding:
      position: 102
      prefix: --countfile_format
  - id: fiveprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 5' position.
    inputBinding:
      position: 102
      prefix: --fiveprime
  - id: fiveprime_variable
    type:
      - 'null'
      - boolean
    doc: Map read alignment to a variable offset from 5' position of read, with 
      offset determined by read length. Requires `--offset` below
    inputBinding:
      position: 102
      prefix: --fiveprime_variable
  - id: gff_cds_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as CDS (for GFF3 only; default: use SO v.2.5.3
      specification)'
    inputBinding:
      position: 102
      prefix: --gff_cds_types
  - id: gff_exon_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as exons (for GFF3 only; default: use SO v.2.5.3
      specification)'
    inputBinding:
      position: 102
      prefix: --gff_exon_types
  - id: gff_transcript_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as transcripts, even if no exons are present
      (for GFF3 only; default: use SO v2.5.3 specification)'
    inputBinding:
      position: 102
      prefix: --gff_transcript_types
  - id: mask_add_three
    type:
      - 'null'
      - boolean
    doc: If supplied, coding regions will be extended by 3 nucleotides at their 
      3' ends (except for GTF2 files that explicitly include `stop_codon` 
      features). Use if your annotation file excludes stop codons from CDS.
    inputBinding:
      position: 102
      prefix: --mask_add_three
  - id: mask_annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more annotation files (max 1 file if BigBed)
    inputBinding:
      position: 102
      prefix: --mask_annotation_files
  - id: mask_annotation_format
    type:
      - 'null'
      - string
    doc: 'Format of mask_annotation_files (Default: GTF2). Note: GFF3 assembly assumes
      SO v.2.5.2 feature ontologies, which may or may not match your specific file.'
    inputBinding:
      position: 102
      prefix: --mask_annotation_format
  - id: mask_bed_extra_columns
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Number of extra columns in BED file (e.g. in custom ENCODE formats) or list
      of names for those columns. (Default: 0).'
    inputBinding:
      position: 102
      prefix: --mask_bed_extra_columns
  - id: mask_gff_cds_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as CDS (for GFF3 only; default: use SO v.2.5.3
      specification)'
    inputBinding:
      position: 102
      prefix: --mask_gff_cds_types
  - id: mask_gff_exon_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as exons (for GFF3 only; default: use SO v.2.5.3
      specification)'
    inputBinding:
      position: 102
      prefix: --mask_gff_exon_types
  - id: mask_gff_transcript_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as transcripts, even if no exons are present
      (for GFF3 only; default: use SO v.2.5.3 specification)'
    inputBinding:
      position: 102
      prefix: --mask_gff_transcript_types
  - id: mask_maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files.
      May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 102
      prefix: --mask_maxmem
  - id: mask_sorted
    type:
      - 'null'
      - boolean
    doc: 'mask_annotation_files are sorted by chromosomal position (Default: False)'
    inputBinding:
      position: 102
      prefix: --mask_sorted
  - id: mask_tabix
    type:
      - 'null'
      - boolean
    doc: 'mask_annotation_files are tabix-compressed and indexed (Default: False).
      Ignored for BigBed files.'
    inputBinding:
      position: 102
      prefix: --mask_tabix
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length permitted to be included (BAM & bowtie files only. Default:
      100)'
    inputBinding:
      position: 102
      prefix: --max_length
  - id: maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files.
      May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 102
      prefix: --maxmem
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum read length required to be included (BAM & bowtie files only. Default:
      25)'
    inputBinding:
      position: 102
      prefix: --min_length
  - id: nibble
    type:
      - 'null'
      - int
    doc: 'For use with `--center` only. nt to remove from each end of read before
      mapping (Default: 0)'
    inputBinding:
      position: 102
      prefix: --nibble
  - id: offset
    type:
      - 'null'
      - int
    doc: "For `--fiveprime` or `--threeprime`, provide an integer representing the
      offset into the read, starting from either the 5' or 3' end, at which data should
      be plotted. For `--fiveprime_variable`, provide the filename of a two-column
      tab-delimited text file, in which first column represents read length or the
      special keyword 'default', and the second column represents the offset from
      the five prime end of that read length at which the read should be mapped. (Default:
      0)"
    inputBinding:
      position: 102
      prefix: --offset
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: 'annotation_files are sorted by chromosomal position (Default: False)'
    inputBinding:
      position: 102
      prefix: --sorted
  - id: sum
    type:
      - 'null'
      - string
    doc: 'Sum used in normalization of counts and RPKM/RPNT calculations (Default:
      total mapped reads/counts in dataset)'
    inputBinding:
      position: 102
      prefix: --sum
  - id: tabix
    type:
      - 'null'
      - boolean
    doc: 'annotation_files are tabix-compressed and indexed (Default: False). Ignored
      for BigBed files.'
    inputBinding:
      position: 102
      prefix: --tabix
  - id: threeprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 3' position
    inputBinding:
      position: 102
      prefix: --threeprime
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity. With '-v', show every warning. With '-vv', turn warnings
      into exceptions. Cannot use with '-q'. (Default: show each type of warning once)"
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid_counts_in_region.out
