cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - bed
label: crossmap_bed
doc: "CrossMap converts genome coordinates in BED, BED-like, or bigBed files between assemblies (e.g. lift over from human hg18 to hg19). The first 3 columns of the input must be chrom, start and end.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: The input BED file. The first 3 columns must be "chrom", "start", and "end".
      The file can be plain text or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    default: output.bed
    doc: Output BED file. If the argument is missing, CrossMap writes the BED file
      to STDOUT.
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
  - id: unmap_file
    type:
      - 'null'
      - string
    doc: File to save unmapped entries. This will be ignored if [out_bed] was not
      provided.
    inputBinding:
      position: 104
      prefix: --unmap-file
  - id: naive_bed_parsing
    type:
      - 'null'
      - boolean
    doc: Perform "naive" parsing on the input BED file. Focus on the first 3 columns
      (chr, start, end) without making assumptions about the expected format or content
      of the other columns.
    inputBinding:
      position: 104
      prefix: --naive-bed-parsing
outputs:
  - id: output_bed
    type: File
    doc: Lifted-over BED file.
    outputBinding:
      glob: $(inputs.out_bed)
  - id: unmapped_bed
    type:
      - 'null'
      - File
    doc: BED entries that could not be lifted over (out_bed.unmap, or the --unmap-file
      path).
    outputBinding:
      glob: '$(inputs.unmap_file ? inputs.unmap_file : inputs.out_bed + ".unmap")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
