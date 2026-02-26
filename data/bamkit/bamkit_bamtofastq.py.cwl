cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtofastq.py
label: bamkit_bamtofastq.py
doc: "Convert a coordinate sorted BAM file to FASTQ (ignores unpaired reads)\n\nTool
  homepage: https://github.com/hall-lab/bamkit"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s). If absent then defaults to stdin.
    inputBinding:
      position: 1
  - id: is_sam
    type:
      - 'null'
      - boolean
    doc: Input is SAM format
    inputBinding:
      position: 102
      prefix: --is_sam
  - id: readgroup
    type:
      - 'null'
      - string
    doc: Read group(s) to extract (comma separated)
    inputBinding:
      position: 102
      prefix: --readgroup
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Rename reads
    inputBinding:
      position: 102
      prefix: --rename
outputs:
  - id: header_file
    type:
      - 'null'
      - File
    doc: Write BAM header to file
    outputBinding:
      glob: $(inputs.header_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
