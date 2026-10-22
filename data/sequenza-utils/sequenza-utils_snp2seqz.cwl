cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - snp2seqz
label: sequenza-utils_snp2seqz
doc: 'Process a VCF file and GC-content genome-wide information to produce a seqz file.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: vcf
    type: File
    doc: VCF input file.
    inputBinding:
      position: 1
      prefix: --vcf
  - id: gc
    type: File
    doc: The GC-content wiggle file.
    inputBinding:
      position: 2
      prefix: -gc
  - id: output_name
    type: string
    doc: Output file. For gzip compressed output name the file ending in .gz. Default STDOUT.
    inputBinding:
      position: 3
      prefix: --output
  - id: vcf_depth
    type:
      - 'null'
      - string
    doc: Colon separated VCF tags for the read depth of the normal and the tumor. Default "DP:DP".
    inputBinding:
      position: 4
      prefix: --vcf-depth
  - id: vcf_samples
    type:
      - 'null'
      - type: enum
        symbols:
          - n/t
          - t/n
        name: vcf_samples_order
    doc: Order of the normal and tumor sample in the VCF columns. Default "n/t".
    inputBinding:
      position: 5
      prefix: --vcf-samples
  - id: vcf_alleles
    type:
      - 'null'
      - string
    doc: Colon separated VCF tags for the allele depth of the normal and the tumor. Default "AD:AD".
    inputBinding:
      position: 6
      prefix: --vcf-alleles
  - id: preset
    type:
      - 'null'
      - type: enum
        symbols:
          - caveman
          - mutect
          - mpileup
          - strelka2_som
        name: preset_values
    doc: Preset options to parse VCF from popular variant callers.
    inputBinding:
      position: 7
      prefix: --preset
  - id: hom
    type:
      - 'null'
      - float
    doc: Threshold to select homozygous positions. Default 0.9.
    inputBinding:
      position: 8
      prefix: --hom
  - id: het
    type:
      - 'null'
      - float
    doc: Threshold to select heterozygous positions. Default 0.25.
    inputBinding:
      position: 9
      prefix: --het
  - id: het_f
    type:
      - 'null'
      - float
    doc: Threshold of frequency in the forward strand to trust heterozygous calls. Default -0.2 (disabled).
    inputBinding:
      position: 10
      prefix: --het_f
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: Threshold to filter positions by the sum of read depth of the two samples. Default 20.
    inputBinding:
      position: 11
      prefix: -N
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path of the tabix binary. Default "tabix".
    inputBinding:
      position: 12
      prefix: --tabix
outputs:
  - id: output_seqz
    type: File
    doc: Output seqz file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
