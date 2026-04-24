cwlVersion: v1.2
class: CommandLineTool
baseCommand: lohhla
label: lohhla
doc: "This tool is used for HLA typing from sequencing data.\n\nTool homepage: https://bitbucket.org/mcgranahanlab/lohhla"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file containing sequencing reads.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory to store results.
    inputBinding:
      position: 2
  - id: hla_alleles
    type:
      - 'null'
      - File
    doc: Optional FASTA file containing specific HLA alleles to consider.
    inputBinding:
      position: 103
      prefix: --hla-alleles
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum sequencing depth to consider.
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum sequencing depth required for calling HLA alleles.
    inputBinding:
      position: 103
      prefix: --min-depth
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the sample (e.g., 2 for diploid, 1 for haploid).
    inputBinding:
      position: 103
      prefix: --ploidy
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Optional FASTA file of the reference genome.
    inputBinding:
      position: 103
      prefix: --reference-genome
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file name for HLA genotypes.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lohhla:20171108--hdfd78af_3
