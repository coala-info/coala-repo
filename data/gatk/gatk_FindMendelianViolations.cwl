cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FindMendelianViolations
label: gatk_FindMendelianViolations
doc: |-
  Takes in VCF or BCF and a pedigree file and looks for high confidence calls where the genotype of the offspring is incompatible with the genotypes of the parents. Key features: - Checks for regular MVs in diploid regions and invalid transmissions in haploid regions (using the declared gender of the offspring in the pedigree file to determine how to deal with the male and female chromosomes.) - Outputs metrics about the different kinds of MVs found. - Can output a per-trio VCF with violations; INFO field will indicate the type of violation in the MV field Example java -jar picard.jar FindMendelianViolations\ I=input.vcf \ TRIO=pedigree.fam \ O=report.mendelian_violation_metrics \ MIN_DP=20 Caveates Assumptions The tool assumes the existence of FORMAT fields AD, DP, GT, GQ, and PL. Ignored Variants This tool ignores variants that are: - Not SNPs - Filtered - Multiallelic (i.e., trio has more than 2 alleles) - Within the SKIP_CHROMS contigs PseudoAutosomal Region This tool assumes that variants in the PAR will be mapped onto the female chromosome, and will treat variants in that region as as autosomal. The mapping to female requires that the PAR in the male chromosome be masked so that the aligner maps reads to single contig. This is normally done for the public releases of the human reference. The tool has default values for PAR that are sensible for humans on either build b37 or hg38.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: Input VCF or BCF with genotypes.
  inputBinding:
    prefix: --INPUT
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output
  type: string
  doc: Output metrics file.
  inputBinding:
    prefix: --OUTPUT
- id: trios
  type: File
  doc: File of Trio information in PED format (with no genotype columns).
  inputBinding:
    prefix: --TRIOS
- id: create_index
  type:
  - 'null'
  - boolean
  doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --CREATE_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: female_chroms
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --FEMALE_CHROMS
  doc: 'List of possible names for female sex chromosome(s) This argument may be specified
    0 or more times. Default value: [chrX, X].'
- id: male_chroms
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --MALE_CHROMS
  doc: 'List of possible names for male sex chromosome(s) This argument may be specified
    0 or more times. Default value: [chrY, Y].'
- id: min_dp
  type:
  - 'null'
  - int
  doc: 'Minimum depth in each sample to consider possible mendelian violations. Default
    value: 0.'
  inputBinding:
    prefix: --MIN_DP
- id: min_gq
  type:
  - 'null'
  - int
  doc: 'Minimum genotyping quality (or non-ref likelihood) to perform tests. Default
    value: 30.'
  inputBinding:
    prefix: --MIN_GQ
- id: min_het_fraction
  type:
  - 'null'
  - double
  doc: 'Minimum allele balance at sites that are heterozygous in the offspring. Default
    value: 0.3.'
  inputBinding:
    prefix: --MIN_HET_FRACTION
- id: pseudo_autosomal_regions
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --PSEUDO_AUTOSOMAL_REGIONS
  doc: 'List of chr:start-end for pseudo-autosomal regions on the female sex chromosome.
    Defaults to HG19/b37 & HG38 coordinates. This argument may be specified 0 or more
    times. Default value: [X:154931044-155260560, X:60001-2699520, chrX:10001-2781479,
    chrX:155701383-156030895].'
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    prefix: --REFERENCE_SEQUENCE
- id: skip_chroms
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --SKIP_CHROMS
  doc: 'List of chromosome names to skip entirely. This argument may be specified
    0 or more times. Default value: [MT, chrM].'
- id: tab_mode
  type:
  - 'null'
  - boolean
  doc: 'If true then fields need to be delimited by a single tab. If false the delimiter
    is one or more whitespace characters. Note that tab mode does not strictly follow
    the PED spec Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --TAB_MODE
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: thread_count
  type:
  - 'null'
  - int
  doc: 'The number of threads that will be used to collect the metrics. Default value:
    1.'
  inputBinding:
    prefix: --THREAD_COUNT
- id: vcf_dir
  type:
  - 'null'
  - string
  doc: If provided, output per-family VCFs of mendelian violations into this directory.
  inputBinding:
    prefix: --VCF_DIR
outputs:
- id: output_output
  type: File
  doc: Output metrics file.
  outputBinding:
    glob: $(inputs.output)
- id: output_vcf_dir
  type:
  - 'null'
  - Directory
  doc: If provided, output per-family VCFs of mendelian violations into this directory.
  outputBinding:
    glob: $(inputs.vcf_dir)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
