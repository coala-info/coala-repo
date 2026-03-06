cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- call
label: bcftools_call
doc: |-
  SNP/indel variant calling from VCF/BCF. To be used in conjunction with 
  bcftools mpileup. This command replaces the former 'bcftools view' caller.
inputs:
- id: input_file
  type: File
  doc: Input VCF/BCF file
  inputBinding:
    position: 200
- id: annotate
  type: string?
  doc: Optional tags to output (lowercase allowed); '?' to list available tags
  inputBinding:
    position: 102
    prefix: --annotate
- id: consensus_caller
  type: boolean?
  doc: The original calling method (conflicts with -m)
  inputBinding:
    position: 102
    prefix: --consensus-caller
- id: constrain
  type: string?
  doc: 'One of: alleles, trio'
  inputBinding:
    position: 102
    prefix: --constrain
- id: group_samples
  type: File?
  doc: |-
    Group samples by population (file with "sample\tgroup") or "-" for 
    single-sample calling
  inputBinding:
    position: 102
    prefix: --group-samples
- id: group_samples_tag
  type: string?
  doc: |-
    The tag to use with -G, by default FORMAT/QS and FORMAT/AD are checked 
    automatically
  inputBinding:
    position: 102
    prefix: --group-samples-tag
- id: gvcf
  type: int[]?
  doc: Group non-variant sites into gVCF blocks by minimum per-sample DP
  inputBinding:
    position: 102
    prefix: --gvcf
- id: insert_missed
  type: boolean?
  doc: Output also sites missed by mpileup but present in -T
  inputBinding:
    position: 102
    prefix: --insert-missed
- id: keep_alts
  type: boolean?
  doc: Keep all possible alternate alleles at variant sites
  inputBinding:
    position: 102
    prefix: --keep-alts
- id: keep_masked_ref
  type: boolean?
  doc: Keep sites with masked reference allele (REF=N)
  inputBinding:
    position: 102
    prefix: --keep-masked-ref
- id: keep_unseen_allele
  type: boolean?
  doc: Keep the unobserved allele <*> or <NON_REF>
  inputBinding:
    position: 102
    prefix: --keep-unseen-allele
- id: multiallelic_caller
  type: boolean?
  doc: |-
    Alternative model for multiallelic and rare-variant calling (conflicts 
    with -c)
  inputBinding:
    position: 102
    prefix: --multiallelic-caller
- id: no_version
  type: boolean?
  doc: Do not append version and command line to the header
  inputBinding:
    position: 102
    prefix: --no-version
- id: novel_rate
  type: float[]?
  doc: Likelihood of novel mutation for constrained trio calling
  inputBinding:
    position: 102
    prefix: --novel-rate
- id: output
  type: string
  doc: Write output to a file [standard output]
  inputBinding:
    position: 102
    prefix: --output
- id: output_type
  type: string?
  doc: |-
    Output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF;
    'v' uncompressed VCF. Can also include compression level 0-9.
  inputBinding:
    position: 102
    prefix: --output-type
- id: ploidy
  type: string?
  doc: |-
    Predefined ploidy, 'list' to print available settings, append '?' for 
    details
  inputBinding:
    position: 102
    prefix: --ploidy
- id: ploidy_file
  type: File?
  doc: Space/tab-delimited list of CHROM,FROM,TO,SEX,PLOIDY
  inputBinding:
    position: 102
    prefix: --ploidy-file
- id: prior
  type: float?
  doc: Mutation rate (use bigger for greater sensitivity), use with -m
  inputBinding:
    position: 102
    prefix: --prior
- id: prior_freqs
  type: string?
  doc: |-
    Use prior allele frequencies, determined from these pre-filled tags 
    (AN,AC)
  inputBinding:
    position: 102
    prefix: --prior-freqs
- id: pval_threshold
  type: float?
  doc: Variant if P(ref|D)<FLOAT with -c
  inputBinding:
    position: 102
    prefix: --pval-threshold
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
  doc: |-
    Include if POS in the region (0), record overlaps (1), variant overlaps
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: samples
  type: string?
  doc: List of samples to include
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type: File?
  doc: PED file or a file with an optional column with sex
  inputBinding:
    position: 102
    prefix: --samples-file
- id: skip_variants
  type: string?
  doc: Skip indels/snps
  inputBinding:
    position: 102
    prefix: --skip-variants
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
- id: threads
  type: int?
  doc: Use multithreading with INT worker threads
  inputBinding:
    position: 102
    prefix: --threads
- id: variants_only
  type: boolean?
  doc: Output variant sites only
  inputBinding:
    position: 102
    prefix: --variants-only
- id: write_index
  type: string?
  doc: Automatically index the output files [off]
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_output
  type: File
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
