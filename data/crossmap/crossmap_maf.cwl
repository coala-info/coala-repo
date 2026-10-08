cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - maf
label: crossmap_maf
doc: "CrossMap converts genome coordinates in MAF (mutation annotation format) files between assemblies.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_maf
    type: File
    doc: Input MAF (https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/) format
      file. The MAF file can be plain text or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: ref_genome
    type: File
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    doc: Chromosome sequences of target assembly in FASTA format (with a .fai index; a bgzip-compressed FASTA also needs a .gzi index).
    inputBinding:
      position: 3
  - id: build_name
    type: string
    doc: The name of the target assembly (e.g. "GRCh38").
    inputBinding:
      position: 4
  - id: out_maf
    type: string
    doc: Output MAF file.
    inputBinding:
      position: 5
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
outputs:
  - id: output_maf
    type: File
    doc: Lifted-over MAF file.
    outputBinding:
      glob: $(inputs.out_maf)
  - id: unmapped_maf
    type:
      - 'null'
      - File
    doc: MAF records that could not be lifted over.
    outputBinding:
      glob: $(inputs.out_maf).unmap
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
