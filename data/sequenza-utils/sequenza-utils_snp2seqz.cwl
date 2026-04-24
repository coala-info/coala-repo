cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - snp2seqz
label: sequenza-utils_snp2seqz
doc: "Convert SNP-calling results to seqz format\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_file
    type: File
    doc: Input file containing SNP-calling results (e.g., VCF, TSV)
    inputBinding:
      position: 1
  - id: assembly
    type: string
    doc: Reference genome assembly version (e.g., hg19, hg38)
    inputBinding:
      position: 102
      prefix: --assembly
  - id: max_alt_freq
    type:
      - 'null'
      - float
    doc: Maximum alternative allele frequency to consider a variant
    inputBinding:
      position: 102
      prefix: --max-alt-freq
  - id: min_alt_freq
    type:
      - 'null'
      - float
    doc: Minimum alternative allele frequency to consider a variant
    inputBinding:
      position: 102
      prefix: --min-alt-freq
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum sequencing depth to consider a variant
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: sample_id
    type: string
    doc: Sample ID to be used in the seqz file
    inputBinding:
      position: 102
      prefix: --sample-id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file path for the seqz format file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
