cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - polyphasegenetic
label: whatshap_polyphasegenetic
doc: "Phase variants in a polyploid VCF using a clustering+threading algorithm.\n\n\
  Tool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file with variants to be phased (can be gzip-compressed)
    inputBinding:
      position: 1
  - id: pedigree
    type: File
    doc: Pedigree file.
    inputBinding:
      position: 2
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome to phase. If not given, all chromosomes in the input
      VCF are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: complexity_support
    type:
      - 'null'
      - int
    doc: Indicates what level of genotype complexity is allowed for phased 
      variants. 0 = simplex-nulliplex only, 1 = simplex-simplex on top, 2 = 
      duplex-nulliplex on top. Default is 0.
    inputBinding:
      position: 103
      prefix: --complexity-support
  - id: distrust_genotypes
    type:
      - 'null'
      - boolean
    doc: Internally retypes the reported parent genotypes based on allele 
      distribution in progeny samples.
    inputBinding:
      position: 103
      prefix: --distrust-genotypes
  - id: exclude_chromosome
    type:
      - 'null'
      - string
    doc: Name of chromosome not to phase.
    inputBinding:
      position: 103
      prefix: --exclude-chromosome
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Phase only SNVs
    inputBinding:
      position: 103
      prefix: --only-snvs
  - id: ploidy
    type: int
    doc: The ploidy of the sample(s). Argument is required.
    inputBinding:
      position: 103
      prefix: --ploidy
  - id: progeny_file
    type:
      - 'null'
      - File
    doc: File with progeny genotypes. If not specified, information is taken 
      from main input file.
    inputBinding:
      position: 103
      prefix: --progeny_file
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to phase. If not given, all samples in the input VCF 
      are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
  - id: scoring_window
    type:
      - 'null'
      - int
    doc: Size of the window (in variants) for statistical progeny scoring.
    inputBinding:
      position: 103
      prefix: --scoring-window
  - id: tag
    type:
      - 'null'
      - string
    doc: 'Store phasing information with PS tag (standardized) or HP tag (used by
      GATK ReadBackedPhasing) (default: PS)'
    inputBinding:
      position: 103
      prefix: --tag
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file. Add .gz to the file name to get compressed output. If 
      omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
