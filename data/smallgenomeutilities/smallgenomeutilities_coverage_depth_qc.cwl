cwlVersion: v1.2
class: CommandLineTool
baseCommand: coverage_depth_qc
label: smallgenomeutilities_coverage_depth_qc
doc: "Computes 'fraction of genome covered a depth' QC metrics from coverage TSV files
  (made by aln2basecnt, samtools depth, etc.)\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: tsv_files
    type:
      type: array
      items: File
    doc: coverage TSV file
    inputBinding:
      position: 1
  - id: chrom_size
    type:
      - 'null'
      - File
    doc: uses reference size table (made by chromsize, bioawk, seqkit, fasta 
      indexing, etc.) to compute relative instead of absolute
    inputBinding:
      position: 102
      prefix: --fract
  - id: depths
    type:
      - 'null'
      - type: array
        items: int
    doc: depths at wich to computer ther percentage of genome covered
    inputBinding:
      position: 102
      prefix: --depth
  - id: names
    type:
      - 'null'
      - type: array
        items: int
    doc: name to use for each TSV file (by default extract from the TSV column)
    inputBinding:
      position: 102
      prefix: --names
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file to write stats to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
