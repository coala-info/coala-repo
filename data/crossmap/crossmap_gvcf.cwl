cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - gvcf
label: crossmap_gvcf
doc: "CrossMap converts genome coordinates in gVCF (genomic variant call format) files between assemblies.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_gvcf
    type: File
    doc: Input gVCF (genomic variant call format). The gVCF file can be plain text
      or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: ref_genome
    type: File
    secondaryFiles:
      - .fai
    doc: Chromosome sequences of target assembly in FASTA format (with a .fai index).
    inputBinding:
      position: 3
  - id: out_gvcf
    type: string
    doc: Output gVCF file.
    inputBinding:
      position: 4
  - id: chromid
    type:
      - 'null'
      - type: enum
        symbols:
          - a
          - s
          - l
          - n
    doc: 'The style of the output chromosome IDs. "a" = "as-is", "l" = "long style",
      "s" = "short style", and "n" = "no-change".'
    inputBinding:
      position: 104
      prefix: --chromid
  - id: ref_consistent
    type:
      - 'null'
      - boolean
    doc: If set, CrossMap will check if reference allele is consistent during liftover.
    inputBinding:
      position: 104
      prefix: --ref-consistent
  - id: no_comp_alleles
    type:
      - 'null'
      - boolean
    doc: If set, CrossMap does NOT check if the reference allele is different from
      the alternate allele.
    inputBinding:
      position: 104
      prefix: --no-comp-alleles
  - id: compress
    type:
      - 'null'
      - boolean
    doc: If set, compress the output file by calling the system "gzip".
    inputBinding:
      position: 104
      prefix: --compress
outputs:
  - id: output_gvcf
    type: File
    doc: Output gVCF file (gzip-compressed with a .gz suffix when compress is set).
    outputBinding:
      glob: '$(inputs.compress ? inputs.out_gvcf + ".gz" : inputs.out_gvcf)'
  - id: unmapped_gvcf
    type:
      - 'null'
      - File
    doc: gVCF records that could not be lifted over.
    outputBinding:
      glob: $(inputs.out_gvcf).unmap*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
