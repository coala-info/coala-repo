cwlVersion: v1.2
class: CommandLineTool
baseCommand: stats_from_bam
label: pomoxis_stats_from_bam
doc: "Parse a bamfile (from a stream) and output summary stats for each read.\n\n\
  Tool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Path to bam file.
    inputBinding:
      position: 1
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Include secondary and supplementary alignments.
    inputBinding:
      position: 102
      prefix: --all_alignments
  - id: bed
    type:
      - 'null'
      - File
    doc: .bed file of reference regions to include.
    inputBinding:
      position: 102
      prefix: --bed
  - id: min_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --min_length
  - id: summary
    type:
      - 'null'
      - File
    doc: Output summary to file instead of stderr.
    inputBinding:
      position: 102
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output alignment stats to file instead of stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
