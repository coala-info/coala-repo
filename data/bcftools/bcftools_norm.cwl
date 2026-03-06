cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- norm
label: bcftools_norm
doc: |-
  Left-align and normalize indels; check if REF alleles match the reference; 
  split multiallelic sites into multiple rows; recover multiallelics from 
  multiple rows.
inputs:
- id: input_file
  type: File
  doc: Input VCF/BCF file
  inputBinding:
    position: 200
- id: atom_overlaps
  type: string?
  doc: Use the star allele (*) for overlapping alleles or set to missing (.)
  inputBinding:
    position: 102
    prefix: --atom-overlaps
- id: atomize
  type: boolean?
  doc: Decompose complex variants (e.g. MNVs become consecutive SNVs)
  inputBinding:
    position: 102
    prefix: --atomize
- id: check_ref
  type: string?
  doc: Check REF alleles and exit (e), warn (w), exclude (x), or set (s) bad 
    sites
  inputBinding:
    position: 102
    prefix: --check-ref
- id: do_not_normalize
  type: boolean?
  doc: Do not normalize indels (with -m or -c s)
  inputBinding:
    position: 102
    prefix: --do-not-normalize
- id: exclude
  type: string?
  doc: Do not normalize records for which the expression is true
  inputBinding:
    position: 102
    prefix: --exclude
- id: fasta_ref
  type: File?
  doc: Reference sequence
  inputBinding:
    position: 102
    prefix: --fasta-ref
- id: force
  type: boolean?
  doc: Try to proceed even if malformed tags are encountered. Experimental, use 
    at your own risk
  inputBinding:
    position: 102
    prefix: --force
- id: gff_annot
  type: File?
  doc: Follow HGVS 3'rule and right-align variants in transcripts on the forward
    strand
  inputBinding:
    position: 102
    prefix: --gff-annot
- id: include
  type: string?
  doc: Normalize only records for which the expression is true
  inputBinding:
    position: 102
    prefix: --include
- id: keep_sum
  type: string[]?
  doc: Keep vector sum constant when splitting multiallelics
  inputBinding:
    position: 102
    prefix: --keep-sum
- id: multi_overlaps
  type: string?
  doc: Fill in the reference (0) or missing (.) allele when splitting 
    multiallelics
  inputBinding:
    position: 102
    prefix: --multi-overlaps
- id: multiallelics
  type: string?
  doc: 'Split multiallelics (-) or join biallelics (+), type: snps|indels|both|any'
  inputBinding:
    position: 102
    prefix: --multiallelics
- id: no_version
  type: boolean?
  doc: Do not append version and command line to the header
  inputBinding:
    position: 102
    prefix: --no-version
- id: old_rec_tag
  type: string?
  doc: Annotate modified records with INFO/STR indicating the original variant
  inputBinding:
    position: 102
    prefix: --old-rec-tag
- id: output
  type: string
  doc: Write output to a file
  inputBinding:
    position: 102
    prefix: --output
- id: output_type
  type: string?
  doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
  inputBinding:
    position: 102
    prefix: --output-type
- id: regions
  type: string?
  doc: Restrict to comma-separated list of regions
  inputBinding:
    position: 102
    prefix: --regions
- id: regions_file
  type: File?
  doc: Restrict to regions listed in a file
  inputBinding:
    position: 102
    prefix: --regions-file
- id: regions_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: remove_duplicates
  type: boolean?
  doc: Remove duplicate lines of the same type.
  inputBinding:
    position: 102
    prefix: --remove-duplicates
- id: rm_dup
  type: string?
  doc: Remove duplicate snps|indels|both|all|exact
  inputBinding:
    position: 102
    prefix: --rm-dup
- id: site_win
  type: int?
  doc: Buffer for sorting lines which changed position during realignment
  inputBinding:
    position: 102
    prefix: --site-win
- id: sort
  type: string?
  doc: 'Sort order: chr_pos,lex'
  inputBinding:
    position: 102
    prefix: --sort
- id: strict_filter
  type: boolean?
  doc: When merging (-m+), merged site is PASS only if all sites being merged 
    PASS
  inputBinding:
    position: 102
    prefix: --strict-filter
- id: targets
  type: string?
  doc: Similar to -r but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets
- id: targets_file
  type: File?
  doc: Similar to -R but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets-file
- id: targets_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --targets-overlap
- id: threads
  type: int?
  doc: Use multithreading with INT worker threads
  inputBinding:
    position: 102
    prefix: --threads
- id: write_index
  type: string?
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_output
  type: File
  doc: Write output to a file
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
