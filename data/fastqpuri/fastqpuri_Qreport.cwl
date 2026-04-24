cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./Qreport
label: fastqpuri_Qreport
doc: "Reads in a fq file (gz, bz2, z formats also accepted) and creates a quality
  report (html file) along with the necessary data to create it stored in binary format.\n\
  \nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs:
  - id: ascii_quality_zero
    type:
      - 'null'
      - int
    doc: ASCII value for quality score 0
    inputBinding:
      position: 101
      prefix: '-0'
  - id: filter_status
    type:
      - 'null'
      - int
    doc: 'Filter status: 0 original file, 1 file filtered with trimFilter, 2 file
      filtered with another tool.'
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type: File
    doc: Input file [*fq|*fq.gz|*fq.bz2]
    inputBinding:
      position: 101
      prefix: -i
  - id: low_quality_values
    type:
      - 'null'
      - string
    doc: quality values for low quality proportion plot. Format is either 
      <int>[,<int>]* or <min-int>:<max-int>
    inputBinding:
      position: 101
      prefix: -Q
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality allowed
    inputBinding:
      position: 101
      prefix: -q
  - id: num_quality_values
    type:
      - 'null'
      - int
    doc: Number of different quality values allowed
    inputBinding:
      position: 101
      prefix: -n
  - id: number_of_tiles
    type:
      - 'null'
      - int
    doc: Number of tiles
    inputBinding:
      position: 101
      prefix: -t
  - id: read_length
    type: int
    doc: Read length. Length of the reads.
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: output_file
    type: File
    doc: Output file prefix (with NO extension)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
