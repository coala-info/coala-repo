cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - sdf2fastq
label: rtg-tools_rtg_sdf2fastq
doc: 'Converts SDF data into FASTQ file(s). Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: Directory
    doc: 'SDF containing sequences'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output filename (extension added if not present). Use ''-'' to write to standard output'
    inputBinding:
      position: 101
      prefix: --output
  - id: end_id
    type:
      - 'null'
      - long
    doc: 'exclusive upper bound on sequence id'
    inputBinding:
      position: 101
      prefix: --end-id
  - id: id_file
    type:
      - 'null'
      - File
    doc: 'file containing sequence ids, or sequence names if --names flag is set, one per line'
    inputBinding:
      position: 101
      prefix: --id-file
  - id: names
    type:
      - 'null'
      - boolean
    doc: 'interpret supplied sequence as names instead of numeric ids'
    inputBinding:
      position: 101
      prefix: --names
  - id: start_id
    type:
      - 'null'
      - long
    doc: 'inclusive lower bound on sequence id'
    inputBinding:
      position: 101
      prefix: --start-id
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: 'id of sequence to extract, or sequence name if --names flag is set. May be specified 0 or more times'
    inputBinding:
      position: 200
  - id: default_quality
    type:
      - 'null'
      - int
    doc: 'default quality value to use if the SDF does not contain quality data (0-63)'
    inputBinding:
      position: 101
      prefix: --default-quality
  - id: interleave
    type:
      - 'null'
      - boolean
    doc: 'interleave paired data into a single output file. Default is to split to separate output files'
    inputBinding:
      position: 101
      prefix: --interleave
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'maximum number of nucleotides to print on a line of output. A value of 0 indicates no limit (Default is 0)'
    inputBinding:
      position: 101
      prefix: --line-length
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fastq
    type:
      type: array
      items: File
    doc: Output FASTQ file(s) (one per arm for paired data)
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_sdf2fastq.out
