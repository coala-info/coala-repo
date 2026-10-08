cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - bigwig
label: crossmap_bigwig
doc: "CrossMap converts genome coordinates in bigWig format files between assemblies. The output is written as bigWig and as sorted bedGraph.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_bw
    type: File
    doc: The input bigWig format file (https://genome.ucsc.edu/goldenPath/help/bigWig.html).
    inputBinding:
      position: 2
  - id: out_bw
    type: string
    doc: Output prefix of the bigWig file. CrossMap writes <prefix>.bw and <prefix>.sorted.bgr.
    inputBinding:
      position: 3
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
  - id: output_bigwig
    type: File
    doc: Lifted-over signal in bigWig format (<prefix>.bw).
    outputBinding:
      glob: $(inputs.out_bw).bw
  - id: output_bedgraph
    type: File
    doc: Lifted-over, merged and sorted signal in bedGraph format (<prefix>.sorted.bgr).
    outputBinding:
      glob: $(inputs.out_bw).sorted.bgr
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
