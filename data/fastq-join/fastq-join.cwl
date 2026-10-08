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
  - id: mate
    type:
      - 'null'
      - File
    doc: Optional third input file (e.g., barcode/index read). When given, the
      files un3 and join2 are also created.
    inputBinding:
      position: 3
  - id: output_template
    type: string
    doc: Output file name template. The suffix un1, un2 or join is appended to
      it, or replaces a % character if present (e.g., out.%.fq).
    inputBinding:
      position: 101
      prefix: -o
  - id: verify_ids
    type:
      - 'null'
      - string
    doc: Verifies that the 2 files probe id's match up to char C. Use ' ' (space)
      for Illumina reads.
    inputBinding:
      position: 101
      prefix: -v
  - id: max_diff_percentage
    type:
      - 'null'
      - int
    doc: N-percent maximum difference (8)
    inputBinding:
      position: 101
      prefix: -p
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: N-minimum overlap (6)
    inputBinding:
      position: 101
      prefix: -m
  - id: report_file
    type:
      - 'null'
      - string
    doc: Verbose stitch length report
    inputBinding:
      position: 101
      prefix: -r
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: No reverse complement
    inputBinding:
      position: 101
      prefix: -R
  - id: allow_short_insert
    type:
      - 'null'
      - boolean
    doc: Allow insert < read length
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: joined
    type:
      - 'null'
      - File
    doc: Joined reads (join)
    outputBinding:
      glob: |
        $(inputs.output_template.indexOf('%') >= 0 ? inputs.output_template.replace('%', 'join') : inputs.output_template + 'join')
  - id: unjoined1
    type:
      - 'null'
      - File
    doc: Read 1 of the pairs that could not be joined (un1)
    outputBinding:
      glob: |
        $(inputs.output_template.indexOf('%') >= 0 ? inputs.output_template.replace('%', 'un1') : inputs.output_template + 'un1')
  - id: unjoined2
    type:
      - 'null'
      - File
    doc: Read 2 of the pairs that could not be joined (un2)
    outputBinding:
      glob: |
        $(inputs.output_template.indexOf('%') >= 0 ? inputs.output_template.replace('%', 'un2') : inputs.output_template + 'un2')
  - id: unjoined3
    type:
      - 'null'
      - File
    doc: Mate (barcode) reads of the pairs that could not be joined (un3); only
      with a mate input
    outputBinding:
      glob: |
        $(inputs.output_template.indexOf('%') >= 0 ? inputs.output_template.replace('%', 'un3') : inputs.output_template + 'un3')
  - id: joined2
    type:
      - 'null'
      - File
    doc: Mate (barcode) reads of the joined pairs (join2); only with a mate input
    outputBinding:
      glob: |
        $(inputs.output_template.indexOf('%') >= 0 ? inputs.output_template.replace('%', 'join2') : inputs.output_template + 'join2')
  - id: stitch_report
    type:
      - 'null'
      - File
    doc: Verbose stitch length report
    outputBinding:
      glob: $(inputs.report_file)
  - id: stdout
    type: stdout
    doc: Standard output (summary of joined reads)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-join:1.3.1--h9948957_8
stdout: fastq-join.out
