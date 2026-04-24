cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-join
label: fastq-join
doc: "Joins two paired-end reads on the overlapping ends.\n\nTool homepage: https://github.com/movingpictures83/FastQJoin"
inputs:
  - id: read1
    type: File
    doc: First mate input file (e.g., read1.fq)
    inputBinding:
      position: 1
  - id: read2
    type: File
    doc: Second mate input file (e.g., read2.fq)
    inputBinding:
      position: 2
  - id: read3
    type:
      - 'null'
      - File
    doc: Optional third input file (e.g., barcode/index read)
    inputBinding:
      position: 3
  - id: max_diff_percentage
    type:
      - 'null'
      - int
    doc: Maximum difference percentage allowed in the overlap
    inputBinding:
      position: 104
      prefix: -p
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap length
    inputBinding:
      position: 104
      prefix: -m
  - id: verify_ids
    type:
      - 'null'
      - string
    doc: Verifies that the files have matching IDs for each read. Accepts a 
      character to filter on.
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_format
    type: File
    doc: Output file name format. Use '%' as a placeholder for 'un1', 'un2', and
      'join' (e.g., output.%.fq)
    outputBinding:
      glob: $(inputs.output_format)
  - id: report_file
    type:
      - 'null'
      - File
    doc: Write joining statistics report to the specified file
    outputBinding:
      glob: $(inputs.report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-join:1.3.1--h9948957_8
