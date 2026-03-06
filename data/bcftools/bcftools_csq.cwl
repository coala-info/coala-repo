cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- csq
label: bcftools_csq
doc: Haplotype-aware consequence caller.
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_vcf
  type: File
  doc: Input VCF file
  inputBinding:
    position: 1
- id: custom_tag
  type: string?
  doc: Use this tag instead of the default BCSQ
  inputBinding:
    position: 102
    prefix: --custom-tag
- id: dump_gff
  type: string
  doc: Dump the parsed GFF file (for debugging purposes)
  inputBinding:
    position: 102
    prefix: --dump-gff
- id: exclude
  type: string?
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
  type: boolean?
  doc: Run even if some sanity checks fail
  inputBinding:
    position: 102
    prefix: --force
- id: genetic_code
  type: string?
  doc: Specify the genetic code table to use, 'l' to print a list
  inputBinding:
    position: 102
    prefix: --genetic-code
- id: gff_annot
  type: File
  doc: GFF3 annotation file
  inputBinding:
    position: 102
    prefix: --gff
- id: include
  type: string?
  doc: Select sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --include
- id: local_csq
  type: boolean?
  doc: Localized predictions, consider only one VCF record at a time
  inputBinding:
    position: 102
    prefix: --local-csq
- id: ncsq
  type: int?
  doc: Maximum number of per-haplotype consequences to consider for each site
  inputBinding:
    position: 102
    prefix: --ncsq
- id: no_version
  type: boolean?
  doc: Do not append version and command line to the header
  inputBinding:
    position: 102
    prefix: --no-version
- id: output
  type: string
  doc: Write output to a file
  inputBinding:
    position: 102
    prefix: --output
- id: output_type
  type: string?
  doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
    VCF, t: plain tab-delimited text output'
  inputBinding:
    position: 102
    prefix: --output-type
- id: phase
  type: string?
  doc: 'How to handle unphased heterozygous genotypes: a (as is), m (merge), r (require
    phased), R (create non-ref), s (skip)'
  inputBinding:
    position: 102
    prefix: --phase
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
- id: samples
  type: string?
  doc: Samples to include or "-" to apply all variants and ignore samples
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type: File?
  doc: Samples to include
  inputBinding:
    position: 102
    prefix: --samples-file
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
  doc: Use multithreading with <int> worker threads
  inputBinding:
    position: 102
    prefix: --threads
- id: trim_protein_seq
  type: int?
  doc: Abbreviate protein-changing predictions to max INT aminoacids
  inputBinding:
    position: 102
    prefix: --trim-protein-seq
- id: unify_chr_names
  type: string?
  doc: Unify chromosome naming by stripping a prefix in VCF,GFF,fasta, 
    respectively
  inputBinding:
    position: 102
    prefix: --unify-chr-names
- id: write_index
  type: string?
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_dump_gff
  type: File?
  doc: Dump the parsed GFF file (for debugging purposes)
  outputBinding:
    glob: $(inputs.dump_gff)
- id: output_output
  type: File
  doc: Write output to a file
  outputBinding:
    glob: $(inputs.output)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
