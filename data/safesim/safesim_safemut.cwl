cwlVersion: v1.2
class: CommandLineTool
baseCommand: safemut
label: safesim_safemut
doc: "This is a NGS variant simulator that is aware of the molecular-barcodes (also
  known as unique molecular identifiers (UMIs))\n\nTool homepage: https://github.com/genetronhealth/safesim"
inputs:
  - id: denominator_randomness_reads
    type:
      - 'null'
      - int
    doc: The number of reads used to generate the randomness for simulating the 
      denominator of the allele fraction used with the -p cmd-line param
    default: 500
    inputBinding:
      position: 101
      prefix: -B
  - id: input_bam
    type: File
    doc: INPUT-BAM
    inputBinding:
      position: 101
      prefix: -b
  - id: input_vcf
    type: File
    doc: INPUT-VCF
    inputBinding:
      position: 101
      prefix: -v
  - id: inserted_bases_quality
    type:
      - 'null'
      - int
    doc: The base quality of the inserted bases in the simulated insertion 
      variants.
    default: 30
    inputBinding:
      position: 101
      prefix: -i
  - id: log_normal_overdispersion
    type:
      - 'null'
      - float
    doc: the log-normal over-dispersion parameter in Phred scale. Negative value
      means that no over-dispersion is simulated.
    default: 15.0
    inputBinding:
      position: 101
      prefix: -q
  - id: nominator_randomness_reads
    type:
      - 'null'
      - int
    doc: The number of reads used to generate the randomness for simulating the 
      nominator of the allele fraction used with the -p cmd-line param
    default: 50
    inputBinding:
      position: 101
      prefix: -A
  - id: power_law_exponent
    type:
      - 'null'
      - float
    doc: The power-law exponent simulating the over-dispersion of allele 
      fractions in NGS. Negative value means that no over-dispersion is 
      simulated.
    default: -1.0
    inputBinding:
      position: 101
      prefix: -p
  - id: random_seed_allele_fractions
    type:
      - 'null'
      - int
    doc: The random seed used to simulate allele fractions from read names 
      labeled with UMIs
    default: 13
    inputBinding:
      position: 101
      prefix: -s
  - id: random_seed_basecalling_error
    type:
      - 'null'
      - int
    doc: The random seed used to simulate basecalling error
    default: 13
    inputBinding:
      position: 101
      prefix: -C
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample name used for the -F command-line parameter. The special values 
      NULL pointer, empty-string, and INFO mean using the INFO column instead of
      the FORMAT column.
    default: NULL pointer
    inputBinding:
      position: 101
      prefix: -S
  - id: sequencing_error_rates
    type:
      - 'null'
      - float
    doc: Phred-scale sequencing error rates of simulated SNV variants where -2 
      means zero error and -1 means using sequencer BQ
    default: -1.0
    inputBinding:
      position: 101
      prefix: -x
  - id: variant_allele_fraction
    type:
      - 'null'
      - float
    doc: Fraction of variant allele (FA) to simulate. This value is overriden by
      the INFO/FA tag (specified by the -F command-line parameter) in the 
      INPUT-VCF. Please note that INFO/FA must be defined the header of 
      INPUT-VCF to be effective. Otherwise, the value defined by -f is used in 
      the simulation
    default: 0.1
    inputBinding:
      position: 101
      prefix: -f
  - id: vcf_allele_fraction_tag
    type:
      - 'null'
      - string
    doc: allele fraction TAG in the VCF file.
    default: FA
    inputBinding:
      position: 101
      prefix: -F
outputs:
  - id: output_r1_fastq
    type: File
    doc: OUTPUT-R1-FASTQ
    outputBinding:
      glob: $(inputs.output_r1_fastq)
  - id: output_r2_fastq_gz
    type: File
    doc: OUTPUT-R2-FASTQ.gz
    outputBinding:
      glob: $(inputs.output_r2_fastq_gz)
  - id: output_unpaired_fastq_gz
    type: File
    doc: OUTPUT-UNPAIRED-FASTQ.GZ
    outputBinding:
      glob: $(inputs.output_unpaired_fastq_gz)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
