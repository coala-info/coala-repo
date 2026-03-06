cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- consensus
label: bcftools_consensus
doc: |-
  Create consensus sequence by applying VCF variants to a reference fasta 
  file. By default, the program will apply all ALT variants. Using the --samples
  (and, optionally, --haplotype) option will apply genotype (or haplotype) calls
  from FORMAT/GT.
inputs:
- id: input_file
  type: File
  doc: Input VCF file (file.vcf.gz)
  secondaryFiles:
  - .tbi
  inputBinding:
    position: 1
- id: absent
  type: string?
  doc: Replace positions absent from VCF with CHAR
  inputBinding:
    position: 102
    prefix: --absent
- id: chain
  type: string
  doc: Write a chain file for liftover
  inputBinding:
    position: 102
    prefix: --chain
- id: exclude
  type: string?
  doc: Exclude sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --exclude
- id: fasta_ref
  type: File?
  doc: Reference sequence in fasta format
  inputBinding:
    position: 102
    prefix: --fasta-ref
- id: haplotype
  type: string?
  doc: Choose which allele to use from the FORMAT/GT field (N, R, A, I, LR, LA, 
    SR, SA, NpIu)
  inputBinding:
    position: 102
    prefix: --haplotype
- id: include
  type: string?
  doc: Select sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --include
- id: iupac_codes
  type: boolean?
  doc: Output IUPAC codes based on FORMAT/GT, use -s/-S to subset samples
  inputBinding:
    position: 102
    prefix: --iupac-codes
- id: mark_del
  type: string?
  doc: Instead of removing sequence, insert character CHAR for deletions
  inputBinding:
    position: 102
    prefix: --mark-del
- id: mark_ins
  type: string?
  doc: Highlight insertions in uppercase (uc), lowercase (lc), or use CHAR, 
    leaving the rest as is
  inputBinding:
    position: 102
    prefix: --mark-ins
- id: mark_snv
  type: string?
  doc: Highlight substitutions in uppercase (uc), lowercase (lc), or use CHAR, 
    leaving the rest as is
  inputBinding:
    position: 102
    prefix: --mark-snv
- id: mask
  type: File?
  doc: Replace regions according to the next --mask-with option. The default is 
    --mask-with N
  inputBinding:
    position: 102
    prefix: --mask
- id: mask_with
  type: string?
  doc: Replace with CHAR (skips overlapping variants); change to uppercase (uc) 
    or lowercase (lc)
  inputBinding:
    position: 102
    prefix: --mask-with
- id: missing
  type: string?
  doc: Output CHAR instead of skipping a missing genotype "./."
  inputBinding:
    position: 102
    prefix: --missing
- id: output
  type: string
  doc: Write output to a file [standard output]
  inputBinding:
    position: 102
    prefix: --output
- id: prefix
  type: string?
  doc: Prefix to add to output sequence names
  inputBinding:
    position: 102
    prefix: --prefix
- id: regions_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: samples
  type: string?
  doc: Comma-separated list of samples to include, "-" to ignore samples and use
    REF,ALT
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type: File?
  doc: File of samples to include
  inputBinding:
    position: 102
    prefix: --samples-file
outputs:
- id: output_chain
  type: File?
  doc: Write a chain file for liftover
  outputBinding:
    glob: $(inputs.chain)
- id: output_output
  type: File?
  doc: Write output to a file [standard output]
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
