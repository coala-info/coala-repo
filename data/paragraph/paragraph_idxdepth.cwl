cwlVersion: v1.2
class: CommandLineTool
baseCommand: paragraph_idxdepth
label: paragraph_idxdepth
doc: "Estimate coverage depth from BAM/CRAM files using index information.\n\nTool
  homepage: https://github.com/Illumina/paragraph"
inputs:
  - id: altcontig
    type:
      - 'null'
      - int
    doc: Include ALT contigs in estimation
    inputBinding:
      position: 101
      prefix: --altcontig
  - id: autosome_regex
    type:
      - 'null'
      - string
    doc: Regex to identify autosome chromosome names
    inputBinding:
      position: 101
      prefix: --autosome-regex
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM / CRAM input file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_index
    type:
      - 'null'
      - File
    doc: BAM / CRAM index file when not at default location.
    inputBinding:
      position: 101
      prefix: --bam-index
  - id: include_regex
    type:
      - 'null'
      - string
    doc: Regex to identify contigs to include
    inputBinding:
      position: 101
      prefix: --include-regex
  - id: log_async
    type:
      - 'null'
      - int
    doc: Enable / disable async logging.
    inputBinding:
      position: 101
      prefix: --log-async
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log level (error, warning, info).
    inputBinding:
      position: 101
      prefix: --log-level
  - id: reference
    type:
      - 'null'
      - File
    doc: FASTA with reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: sex_chromosome_regex
    type:
      - 'null'
      - string
    doc: Regex to identify sex chromosome names
    inputBinding:
      position: 101
      prefix: --sex-chromosome-regex
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel estimation.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name. Will output to stdout if omitted.
    outputBinding:
      glob: $(inputs.output)
  - id: output_bins
    type:
      - 'null'
      - File
    doc: Output binned coverage in tsv format.
    outputBinding:
      glob: $(inputs.output_bins)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file instead of stderr.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
