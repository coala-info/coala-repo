cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastRemap
label: fastremap-bio_FastRemap
doc: "A Tool for Quickly Remapping Reads between Genome Assemblies\n\nTool homepage:
  https://github.com/CMU-SAFARI/FastRemap"
inputs:
  - id: append_tags
    type:
      - 'null'
      - boolean
    doc: 'Add tag to each alignment in BAM file. Tags for pair-end alignments include:
      QF = QC failed, NN = both read1 and read2 unmapped, NU = read1 unmapped, read2
      unique mapped, NM = read1 unmapped, multiple mapped, UN = read1 uniquely mapped,
      read2 unmap, UU = both read1 and read2 uniquely mapped, UM = read1 uniquely
      mapped, read2 multiple mapped, MN = read1 multiple mapped, read2 unmapped, MU
      = read1 multiple mapped, read2 unique mapped, MM = both read1 and read2 multiple
      mapped. Tags for single-end alignments include: QF = QC failed, SN = unmaped,
      SM = multiple mapped, SU = uniquely mapped.'
    inputBinding:
      position: 101
      prefix: --append-tags
  - id: chain_file
    type:
      - 'null'
      - File
    doc: A chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) that 
      describes regions of similarity between references.
    inputBinding:
      position: 101
      prefix: --chain-file
  - id: file_type
    type:
      - 'null'
      - string
    doc: "'bam', 'sam', or 'bed' file depending on input file One of bam, sam, and
      bed."
    inputBinding:
      position: 101
      prefix: --file-type
  - id: input
    type:
      - 'null'
      - File
    doc: '{s,b}am or bed file containing elements to be remapped based on chain file'
    inputBinding:
      position: 101
      prefix: --input
  - id: mean
    type:
      - 'null'
      - int
    doc: Average insert size of pair-end sequencing (bp). In range [0..inf].
    inputBinding:
      position: 101
      prefix: --mean
  - id: stdev
    type:
      - 'null'
      - int
    doc: Stanadard deviation of insert size. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --stdev
  - id: times
    type:
      - 'null'
      - int
    doc: A mapped pair is considered as proper pair if both ends mapped to 
      different strand and the distance between them is less then '-t' * stdev 
      from the mean. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --times
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File containing all the remapped elements from the input file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_unmapped
    type:
      - 'null'
      - File
    doc: File containing all the elements that could not be remapped from the 
      input file based on the provided chain file
    outputBinding:
      glob: $(inputs.output_unmapped)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastremap-bio:1.0.0--h077b44d_2
