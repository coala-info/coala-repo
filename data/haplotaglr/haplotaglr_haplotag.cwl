cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HaplotagLR
  - haplotag
label: haplotaglr_haplotag
doc: "Haplotag individual long reads using pre-phased haplotypes.\n\nTool homepage: https://github.com/Boyle-Lab/HaplotagLR"
inputs:
  - id: vcf
    type: File
    secondaryFiles:
      - .tbi
    doc: "Path to vcf file with pre-phased haplotype data, in VCF format. (Must be in .vcf.gz format with tabix index in same folder. If .vcf file is provided, bgzip and tabix must be installed and available on PATH because HaplotagLR will attempt to convert it.)"
    inputBinding:
      position: 101
      prefix: --vcf
  - id: input_reads
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: "Path to sequencing file (.fasta) or alignment file (.bam or .sam) of long reads that will be used for haplotagging. If a .fastq file is given, the reference argument is required."
    inputBinding:
      position: 101
      prefix: --input_reads
  - id: output_directory_name
    type:
      - 'null'
      - string
    doc: "Name given to directory where results will be output"
    inputBinding:
      position: 101
      prefix: --output_directory_name
  - id: reference
    type:
      - 'null'
      - File
    doc: "Path to reference genome sequence file. REQUIRED if input reads are in fastq format."
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_assembly
    type:
      - 'null'
      - string
    doc: "Assembly for the reference genome. EX: -A hg38."
    inputBinding:
      position: 101
      prefix: --reference_assembly
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for mapping and indexing steps."
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Output to stderr from subprocesses will be muted."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Output to stderr and stdout from subprocesses will be muted."
    inputBinding:
      position: 101
      prefix: --silent
  - id: output_mode
    type:
      - 'null'
      - string
    doc: "Specify whether/how haplotaggeded, untagged, and nontaggable reads are printed to output. Modes available: combined, phase_tagged, full."
    inputBinding:
      position: 101
      prefix: --output_mode
  - id: one_sample
    type:
      - 'null'
      - string
    doc: "Haplotag a specific sample present in the input reads and vcf file. (-s HG001)"
    inputBinding:
      position: 101
      prefix: --one_sample
  - id: global_epsilon
    type:
      - 'null'
      - float
    doc: "Use a global value for the sequencing error rate, epsilon."
    inputBinding:
      position: 101
      prefix: --global_epsilon
  - id: epsilon_from_quality_scores
    type:
      - 'null'
      - boolean
    doc: "Obtain the sequencing error rate, epsilon, as per-base observed error rates, calculated directly from Phred scores in each BAM record."
    inputBinding:
      position: 101
      prefix: --epsilon_from_quality_scores
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: "Control the false discovery rate at the given value. Set this to zero to skip this step and return all haplotagging predictions. Default = 0."
    inputBinding:
      position: 101
      prefix: --FDR_threshold
  - id: log_likelihood_threshold
    type:
      - 'null'
      - float
    doc: "Use a hard threshold on log-likelihood ratios when haplotagging reads."
    inputBinding:
      position: 101
      prefix: --log_likelihood_threshold
  - id: no_multcoeff
    type:
      - 'null'
      - boolean
    doc: "Do not apply the multinomial coefficient in the likelihood calculation. Default=False"
    inputBinding:
      position: 101
      prefix: --no_multcoeff
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Haplotagged output directory"
    outputBinding:
      glob: $(inputs.output_directory_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotaglr:1.1.13--pyhdfd78af_0
