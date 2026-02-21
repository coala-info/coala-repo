cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - csq
label: bcftools_csq
doc: "Haplotype-aware consequence caller.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: custom_tag
    type:
      - 'null'
      - string
    doc: Use this tag instead of the default BCSQ
    inputBinding:
      position: 102
      prefix: --custom-tag
  - id: dump_gff
    type:
      - 'null'
      - File
    doc: Dump the parsed GFF file (for debugging purposes)
    inputBinding:
      position: 102
      prefix: --dump-gff
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fasta_ref
    type: File
    doc: Reference file in fasta format
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: force
    type:
      - 'null'
      - boolean
    doc: Run even if some sanity checks fail
    inputBinding:
      position: 102
      prefix: --force
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: Specify the genetic code table to use, 'l' to print a list
    default: '0'
    inputBinding:
      position: 102
      prefix: --genetic-code
  - id: gff_annot
    type: File
    doc: GFF3 annotation file
    inputBinding:
      position: 102
      prefix: --gff-annot
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: local_csq
    type:
      - 'null'
      - boolean
    doc: Localized predictions, consider only one VCF record at a time
    inputBinding:
      position: 102
      prefix: --local-csq
  - id: ncsq
    type:
      - 'null'
      - int
    doc: Maximum number of per-haplotype consequences to consider for each site
    default: 15
    inputBinding:
      position: 102
      prefix: --ncsq
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
      VCF, t: plain tab-delimited text output'
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: phase
    type:
      - 'null'
      - string
    doc: 'How to handle unphased heterozygous genotypes: a (as is), m (merge), r (require
      phased), R (non-ref), s (skip)'
    default: r
    inputBinding:
      position: 102
      prefix: --phase
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
  - id: samples
    type:
      - 'null'
      - string
    doc: Samples to include or "-" to apply all variants and ignore samples
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: Samples to include
    inputBinding:
      position: 102
      prefix: --samples-file
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
    doc: Use multithreading with <int> worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_protein_seq
    type:
      - 'null'
      - int
    doc: Abbreviate protein-changing predictions to max INT aminoacids
    inputBinding:
      position: 102
      prefix: --trim-protein-seq
  - id: unify_chr_names
    type:
      - 'null'
      - string
    doc: Unify chromosome naming by stripping a prefix in VCF,GFF,fasta, 
      respectively
    default: '0'
    inputBinding:
      position: 102
      prefix: --unify-chr-names
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level 0-6
    default: 1
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
