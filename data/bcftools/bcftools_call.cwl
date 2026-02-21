cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - call
label: bcftools_call
doc: "SNP/indel variant calling from VCF/BCF. To be used in conjunction with bcftools
  mpileup.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - string
    doc: Optional tags to output (lowercase allowed); '?' to list available tags
    inputBinding:
      position: 102
      prefix: --annotate
  - id: consensus_caller
    type:
      - 'null'
      - boolean
    doc: The original calling method (conflicts with -m)
    inputBinding:
      position: 102
      prefix: --consensus-caller
  - id: constrain
    type:
      - 'null'
      - string
    doc: 'One of: alleles, trio (see manual)'
    inputBinding:
      position: 102
      prefix: --constrain
  - id: group_samples
    type:
      - 'null'
      - File
    doc: Group samples by population (file with "sample\tgroup") or "-" for 
      single-sample calling
    inputBinding:
      position: 102
      prefix: --group-samples
  - id: group_samples_tag
    type:
      - 'null'
      - string
    doc: The tag to use with -G, by default FORMAT/QS and FORMAT/AD are checked 
      automatically
    inputBinding:
      position: 102
      prefix: --group-samples-tag
  - id: gvcf
    type:
      - 'null'
      - type: array
        items: int
    doc: Group non-variant sites into gVCF blocks by minimum per-sample DP
    inputBinding:
      position: 102
      prefix: --gvcf
  - id: insert_missed
    type:
      - 'null'
      - boolean
    doc: Output also sites missed by mpileup but present in -T
    inputBinding:
      position: 102
      prefix: --insert-missed
  - id: keep_alts
    type:
      - 'null'
      - boolean
    doc: Keep all possible alternate alleles at variant sites
    inputBinding:
      position: 102
      prefix: --keep-alts
  - id: keep_masked_ref
    type:
      - 'null'
      - boolean
    doc: Keep sites with masked reference allele (REF=N)
    inputBinding:
      position: 102
      prefix: --keep-masked-ref
  - id: keep_unseen_allele
    type:
      - 'null'
      - boolean
    doc: Keep the unobserved allele <*> or <NON_REF>
    inputBinding:
      position: 102
      prefix: --keep-unseen-allele
  - id: multiallelic_caller
    type:
      - 'null'
      - boolean
    doc: Alternative model for multiallelic and rare-variant calling (conflicts 
      with -c)
    inputBinding:
      position: 102
      prefix: --multiallelic-caller
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: novel_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: Likelihood of novel mutation for constrained trio calling
    default: 1e-8,1e-9,1e-9
    inputBinding:
      position: 102
      prefix: --novel-rate
  - id: output_type
    type:
      - 'null'
      - string
    doc: "Output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF;
      'v' uncompressed VCF"
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: ploidy
    type:
      - 'null'
      - string
    doc: Predefined ploidy, 'list' to print available settings, append '?' for 
      details
    default: '2'
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: ploidy_file
    type:
      - 'null'
      - File
    doc: Space/tab-delimited list of CHROM,FROM,TO,SEX,PLOIDY
    inputBinding:
      position: 102
      prefix: --ploidy-file
  - id: prior
    type:
      - 'null'
      - float
    doc: Mutation rate (use bigger for greater sensitivity), use with -m
    default: 0.0011
    inputBinding:
      position: 102
      prefix: --prior
  - id: prior_freqs
    type:
      - 'null'
      - string
    doc: Use prior allele frequencies, determined from these pre-filled tags 
      (AN,AC)
    inputBinding:
      position: 102
      prefix: --prior-freqs
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: Variant if P(ref|D)<FLOAT with -c
    default: 0.5
    inputBinding:
      position: 102
      prefix: --pval-threshold
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
    doc: List of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: PED file or a file with an optional column with sex
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: skip_variants
    type:
      - 'null'
      - string
    doc: Skip indels/snps
    inputBinding:
      position: 102
      prefix: --skip-variants
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: variants_only
    type:
      - 'null'
      - boolean
    doc: Output variant sites only
    inputBinding:
      position: 102
      prefix: --variants-only
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
