cwlVersion: v1.2
class: CommandLineTool
baseCommand: phase_by_size
label: plastid_phase_by_size
doc: "Estimate sub-codon phasing in a ribosome profiling dataset,\nstratified by read
  length.\n\nBecause ribosomes step three nucleotides in each cycle of translation
  elongation,\nin many ribosome profiling datasets a triplet periodicity is observable\n\
  in the distribution of ribosome-protected footprints.\n\nIn a good dataset, 70-90%
  of the reads on a codon fall within the first of the\nthree codon positions. This
  allows deduction of translation reading frames, if\nthe reading frame is not known
  *a priori.* See Ingolia2009 for more\ndetails.\n\nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs:
  - id: roi_file
    type:
      - 'null'
      - File
    doc: "Optional. ROI file of maximal spanning windows\nsurrounding start codons,
      from ``metagene generate``\nsubprogram. Using this instead of `--annotation_files`\n\
      prevents double-counting of codons when multiple\ntranscript isoforms exist
      for a gene. See the\ndocumentation for `metagene` for more info about ROI\n\
      files.If an ROI file is not given, supply an\nannotation with ``--annotation_files``"
    inputBinding:
      position: 1
  - id: outbase
    type: string
    doc: Required. Basename for output files
    inputBinding:
      position: 2
  - id: add_three
    type:
      - 'null'
      - boolean
    doc: "If supplied, coding regions will be extended by 3\nnucleotides at their
      3' ends (except for GTF2 files\nthat explicitly include `stop_codon` features).
      Use if\nyour annotation file excludes stop codons from CDS."
    inputBinding:
      position: 103
      prefix: --add_three
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more annotation files (max 1 file if BigBed)
    inputBinding:
      position: 103
      prefix: --annotation_files
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: "Format of annotation_files (Default: GTF2). Note: GFF3\nassembly assumes
      SO v.2.5.2 feature ontologies, which\nmay or may not match your specific file."
    inputBinding:
      position: 103
      prefix: --annotation_format
  - id: bed_extra_columns
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of extra columns in BED file (e.g. in custom\nENCODE formats) or
      list of names for those columns.\n(Default: 0)."
    inputBinding:
      position: 103
      prefix: --bed_extra_columns
  - id: center
    type:
      - 'null'
      - boolean
    doc: "Subtract N positions from each end of read, and add\n1/(length-N), to each
      remaining position, where N is\nspecified by `--nibble`"
    inputBinding:
      position: 103
      prefix: --center
  - id: cmap
    type:
      - 'null'
      - string
    doc: "Matplotlib color map from which palette will be made (e.g. 'Blues','autumn','Set1';
    inputBinding:
      position: 103
      prefix: --cmap
  - id: codon_buffer
    type:
      - 'null'
      - int
    doc: 'Codons before and after start codon to ignore (Default: 5)'
    inputBinding:
      position: 103
      prefix: --codon_buffer
  - id: count_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more count or alignment file(s) from a single\nsample or set of samples
      to be pooled."
    inputBinding:
      position: 103
      prefix: --count_files
  - id: countfile_format
    type:
      - 'null'
      - string
    doc: "Format of file containing alignments or counts\n(Default: BAM)"
    inputBinding:
      position: 103
      prefix: --countfile_format
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Figure resolution (Default: 150)'
    inputBinding:
      position: 103
      prefix: --dpi
  - id: figformat
    type:
      - 'null'
      - string
    doc: 'File format for figure(s); Default: png)'
    inputBinding:
      position: 103
      prefix: --figformat
  - id: figsize
    type:
      - 'null'
      - string
    doc: 'Figure width and height, in inches. (Default: use matplotlibrc params)'
    inputBinding:
      position: 103
      prefix: --figsize
  - id: fiveprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 5' position.
    inputBinding:
      position: 103
      prefix: --fiveprime
  - id: fiveprime_variable
    type:
      - 'null'
      - boolean
    doc: "Map read alignment to a variable offset from 5'\nposition of read, with
      offset determined by read\nlength. Requires `--offset` below"
    inputBinding:
      position: 103
      prefix: --fiveprime_variable
  - id: gff_cds_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as CDS (for GFF3 only; default: use SO v2.5.3
      specification)'
    inputBinding:
      position: 103
      prefix: --gff_cds_types
  - id: gff_exon_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GFF3 feature types to include as exons (for GFF3 only; default: use SO v2.5.3
      specification)'
    inputBinding:
      position: 103
      prefix: --gff_exon_types
  - id: gff_transcript_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "GFF3 feature types to include as transcripts, even if\nno exons are present
      (for GFF3 only; default: use SO\nv2.5.3 specification)"
    inputBinding:
      position: 103
      prefix: --gff_transcript_types
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum read length permitted to be included (BAM &\nbowtie files only.
      Default: 100)"
    inputBinding:
      position: 103
      prefix: --max_length
  - id: maxmem
    type:
      - 'null'
      - int
    doc: "Maximum desired memory footprint in MB to devote to\nBigBed/BigWig files.
      May be exceeded by large queries.\n(Default: 0, No maximum)"
    inputBinding:
      position: 103
      prefix: --maxmem
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum read length required to be included (BAM &\nbowtie files only. Default:
      25)"
    inputBinding:
      position: 103
      prefix: --min_length
  - id: nibble
    type:
      - 'null'
      - int
    doc: 'For use with `--center` only. nt to remove from each end of read before
      mapping (Default: 0)'
    inputBinding:
      position: 103
      prefix: --nibble
  - id: offset
    type:
      - 'null'
      - string
    doc: "For `--fiveprime` or `--threeprime`, provide an\ninteger representing the
      offset into the read, starting from either the 5' or 3' end, at which data should
      be plotted. For `--fiveprime_variable`, provide the filename of a two-column
      tab-delimited text file, in which first column represents read length or the
      special keyword 'default', and the second column represents the offset from
      the five prime end of that read length at which the read should be mapped. (Default:
      0)"
    inputBinding:
      position: 103
      prefix: --offset
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: "annotation_files are sorted by chromosomal position\n(Default: False)"
    inputBinding:
      position: 103
      prefix: --sorted
  - id: stylesheet
    type:
      - 'null'
      - string
    doc: Use this matplotlib stylesheet instead of matplotlibrc params
    inputBinding:
      position: 103
      prefix: --stylesheet
  - id: sum
    type:
      - 'null'
      - string
    doc: "Sum used in normalization of counts and RPKM/RPNT\ncalculations (Default:
      total mapped reads/counts in\ndataset)"
    inputBinding:
      position: 103
      prefix: --sum
  - id: tabix
    type:
      - 'null'
      - boolean
    doc: "annotation_files are tabix-compressed and indexed\n(Default: False). Ignored
      for BigBed files."
    inputBinding:
      position: 103
      prefix: --tabix
  - id: threeprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 3' position
    inputBinding:
      position: 103
      prefix: --threeprime
  - id: title
    type:
      - 'null'
      - string
    doc: Base title for plot(s).
    inputBinding:
      position: 103
      prefix: --title
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity. With '-v', show every warning.\nWith '-vv', turn warnings
      into exceptions. Cannot use\nwith '-q'. (Default: show each type of warning
      once)"
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid_phase_by_size.out
