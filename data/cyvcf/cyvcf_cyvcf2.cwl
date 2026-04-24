cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf2
label: cyvcf_cyvcf2
doc: "cyvcf2 is a fast, zero-copy, Pythonic interface to htslib's VCF/BCF reading
  and writing capabilities.\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: exclude_samples
    type:
      - 'null'
      - File
    doc: File containing list of samples to exclude
    inputBinding:
      position: 102
      prefix: --exclude-samples
  - id: force_contigs
    type:
      - 'null'
      - boolean
    doc: Force contig names to be loaded from header
    inputBinding:
      position: 102
      prefix: --force-contigs
  - id: indels_only
    type:
      - 'null'
      - boolean
    doc: Only process indels
    inputBinding:
      position: 102
      prefix: --indels-only
  - id: no_contigs
    type:
      - 'null'
      - boolean
    doc: Do not load contig names from header
    inputBinding:
      position: 102
      prefix: --no-contigs
  - id: no_eof
    type:
      - 'null'
      - boolean
    doc: Do not check for EOF marker in BCF files
    inputBinding:
      position: 102
      prefix: --no-eof
  - id: no_genotypes
    type:
      - 'null'
      - boolean
    doc: Do not load genotypes
    inputBinding:
      position: 102
      prefix: --no-genotypes
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not load header
    inputBinding:
      position: 102
      prefix: --no-header
  - id: no_strict_somatic
    type:
      - 'null'
      - boolean
    doc: Do not enforce somatic variant calling conventions
    inputBinding:
      position: 102
      prefix: --no-strict-somatic
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to process (e.g., 'chr1:1000-2000')
    inputBinding:
      position: 102
      prefix: --region
  - id: samples
    type:
      - 'null'
      - File
    doc: File containing list of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: skip_all
    type:
      - 'null'
      - boolean
    doc: Skip all fields except POS, REF, ALT
    inputBinding:
      position: 102
      prefix: --skip-all
  - id: skip_fmt
    type:
      - 'null'
      - boolean
    doc: Skip FORMAT fields
    inputBinding:
      position: 102
      prefix: --skip-fmt
  - id: skip_genotype
    type:
      - 'null'
      - boolean
    doc: Skip genotype fields
    inputBinding:
      position: 102
      prefix: --skip-genotype
  - id: skip_info
    type:
      - 'null'
      - boolean
    doc: Skip INFO fields
    inputBinding:
      position: 102
      prefix: --skip-info
  - id: snps_only
    type:
      - 'null'
      - boolean
    doc: Only process SNPs
    inputBinding:
      position: 102
      prefix: --snps-only
  - id: strict_somatic
    type:
      - 'null'
      - boolean
    doc: Strictly enforce somatic variant calling conventions
    inputBinding:
      position: 102
      prefix: --strict-somatic
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for reading/writing
    inputBinding:
      position: 102
      prefix: --threads
  - id: variants_only
    type:
      - 'null'
      - boolean
    doc: Only load variants (skip INFO fields)
    inputBinding:
      position: 102
      prefix: --variants-only
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: 'Output VCF/BCF file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf:0.8.0--py36_0
