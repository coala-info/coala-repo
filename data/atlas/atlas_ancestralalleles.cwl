cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - ancestralalleles
label: atlas_ancestralalleles
doc: "Writing FASTA-file with ancestral alleles\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: ancestral_alleles_file
    type:
      - 'null'
      - File
    doc: File containing ancestral alleles
    inputBinding:
      position: 102
      prefix: --ancestral-alleles
  - id: include_ambiguous
    type:
      - 'null'
      - boolean
    doc: Include ambiguous sites in the output
    inputBinding:
      position: 102
      prefix: --include-ambiguous
  - id: include_missing
    type:
      - 'null'
      - boolean
    doc: Include missing sites in the output
    inputBinding:
      position: 102
      prefix: --include-missing
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage to call an allele
    inputBinding:
      position: 102
      prefix: --max-coverage
  - id: min_allele_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele fraction to call an allele
    inputBinding:
      position: 102
      prefix: --min-allele-fraction
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base
    inputBinding:
      position: 102
      prefix: --min-baseq
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage to call an allele
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
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
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
