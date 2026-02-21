cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - norm
label: bcftools_norm
doc: "Left-align and normalize indels; check if REF alleles match the reference; split
  multiallelic sites into multiple rows; recover multiallelics from multiple rows.\n\
  \nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: atom_overlaps
    type:
      - 'null'
      - string
    doc: Use the star allele (*) for overlapping alleles or set to missing (.)
    default: '*'
    inputBinding:
      position: 102
      prefix: --atom-overlaps
  - id: atomize
    type:
      - 'null'
      - boolean
    doc: Decompose complex variants (e.g. MNVs become consecutive SNVs)
    inputBinding:
      position: 102
      prefix: --atomize
  - id: check_ref
    type:
      - 'null'
      - string
    doc: Check REF alleles and exit (e), warn (w), exclude (x), or set (s) bad 
      sites
    default: e
    inputBinding:
      position: 102
      prefix: --check-ref
  - id: do_not_normalize
    type:
      - 'null'
      - boolean
    doc: Do not normalize indels (with -m or -c s)
    inputBinding:
      position: 102
      prefix: --do-not-normalize
  - id: exclude
    type:
      - 'null'
      - string
    doc: Do not normalize records for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Reference sequence
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: force
    type:
      - 'null'
      - boolean
    doc: Try to proceed even if malformed tags are encountered. Experimental, 
      use at your own risk
    inputBinding:
      position: 102
      prefix: --force
  - id: gff_annot
    type:
      - 'null'
      - File
    doc: Follow HGVS 3'rule and right-align variants in transcripts on the 
      forward strand
    inputBinding:
      position: 102
      prefix: --gff-annot
  - id: include
    type:
      - 'null'
      - string
    doc: Normalize only records for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: keep_sum
    type:
      - 'null'
      - type: array
        items: string
    doc: Keep vector sum constant when splitting multiallelics
    inputBinding:
      position: 102
      prefix: --keep-sum
  - id: multi_overlaps
    type:
      - 'null'
      - string
    doc: Fill in the reference (0) or missing (.) allele when splitting 
      multiallelics
    default: '0'
    inputBinding:
      position: 102
      prefix: --multi-overlaps
  - id: multiallelics
    type:
      - 'null'
      - string
    doc: 'Split multiallelics (-) or join biallelics (+), type: snps|indels|both|any'
    default: both
    inputBinding:
      position: 102
      prefix: --multiallelics
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: old_rec_tag
    type:
      - 'null'
      - string
    doc: Annotate modified records with INFO/STR indicating the original variant
    inputBinding:
      position: 102
      prefix: --old-rec-tag
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicate lines of the same type.
    inputBinding:
      position: 102
      prefix: --remove-duplicates
  - id: rm_dup
    type:
      - 'null'
      - string
    doc: Remove duplicate snps|indels|both|all|exact
    inputBinding:
      position: 102
      prefix: --rm-dup
  - id: site_win
    type:
      - 'null'
      - int
    doc: Buffer for sorting lines which changed position during realignment
    default: 1000
    inputBinding:
      position: 102
      prefix: --site-win
  - id: sort
    type:
      - 'null'
      - string
    doc: 'Sort order: chr_pos,lex'
    default: chr_pos
    inputBinding:
      position: 102
      prefix: --sort
  - id: strict_filter
    type:
      - 'null'
      - boolean
    doc: When merging (-m+), merged site is PASS only if all sites being merged 
      PASS
    inputBinding:
      position: 102
      prefix: --strict-filter
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 0
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
