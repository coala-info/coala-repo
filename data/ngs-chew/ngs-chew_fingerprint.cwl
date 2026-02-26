cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngs-chew
  - fingerprint
label: ngs-chew_fingerprint
doc: "Compute fingerprint to numpy .npz files.\n\nTool homepage: https://github.com/bihealth/ngs-chew"
inputs:
  - id: genome_release
    type:
      - 'null'
      - string
    doc: Genome release used.
    inputBinding:
      position: 101
      prefix: --genome-release
  - id: input_bam
    type: File
    doc: Path to input BAM file.
    inputBinding:
      position: 101
      prefix: --input-bam
  - id: max_sites
    type:
      - 'null'
      - int
    doc: Maximal number of sites to consider.
    inputBinding:
      position: 101
      prefix: --max-sites
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimal required coverage.
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: no_output_aafs
    type:
      - 'null'
      - boolean
    doc: Write alternate allele fractions to .npz file.
    inputBinding:
      position: 101
      prefix: --no-output-aafs
  - id: no_step_autosomal_snps
    type:
      - 'null'
      - boolean
    doc: 'Enable autosomal SNP step (default: yes)'
    inputBinding:
      position: 101
      prefix: --no-step-autosomal-snps
  - id: no_step_bcftools_roh
    type:
      - 'null'
      - boolean
    doc: 'Enable bcftools roh step (default: yes)'
    inputBinding:
      position: 101
      prefix: --no-step-bcftools-roh
  - id: no_step_chrx_snps
    type:
      - 'null'
      - boolean
    doc: 'Enable chrX SNP step (default: yes)'
    inputBinding:
      position: 101
      prefix: --no-step-chrx-snps
  - id: no_step_samtools_idxstats
    type:
      - 'null'
      - boolean
    doc: 'Enable samtools idxstats step (default: yes)'
    inputBinding:
      position: 101
      prefix: --no-step-samtools-idxstats
  - id: no_write_vcf
    type:
      - 'null'
      - boolean
    doc: Enable writing of call VCF.
    inputBinding:
      position: 101
      prefix: --no-write-vcf
  - id: output_aafs
    type:
      - 'null'
      - boolean
    doc: Write alternate allele fractions to .npz file.
    inputBinding:
      position: 101
      prefix: --output-aafs
  - id: reference
    type: File
    doc: Path to reference FASTA file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: step_autosomal_snps
    type:
      - 'null'
      - boolean
    doc: 'Enable autosomal SNP step (default: yes)'
    inputBinding:
      position: 101
      prefix: --step-autosomal-snps
  - id: step_bcftools_roh
    type:
      - 'null'
      - boolean
    doc: 'Enable bcftools roh step (default: yes)'
    inputBinding:
      position: 101
      prefix: --step-bcftools-roh
  - id: step_chrx_snps
    type:
      - 'null'
      - boolean
    doc: 'Enable chrX SNP step (default: yes)'
    inputBinding:
      position: 101
      prefix: --step-chrx-snps
  - id: step_samtools_idxstats
    type:
      - 'null'
      - boolean
    doc: 'Enable samtools idxstats step (default: yes)'
    inputBinding:
      position: 101
      prefix: --step-samtools-idxstats
  - id: write_vcf
    type:
      - 'null'
      - boolean
    doc: Enable writing of call VCF.
    inputBinding:
      position: 101
      prefix: --write-vcf
outputs:
  - id: output_fingerprint
    type: File
    doc: Path to output .npz file (extension will be added automatically if 
      necessary)
    outputBinding:
      glob: $(inputs.output_fingerprint)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
