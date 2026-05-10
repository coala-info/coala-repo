cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barbell
  - inspect
label: barbell_inspect
doc: "View most common patterns in annotation\n\nTool homepage: https://github.com/rickbeeloo/barbell"
inputs:
  - id: bucket_size
    type:
      - 'null'
      - int
    doc: To summarize results we uses "buckets", such that matches 100 and 103 
      from the start end up in the same bucket
    inputBinding:
      position: 101
      prefix: --bucket-size
  - id: input
    type: File
    doc: Input filtered annotation file
    inputBinding:
      position: 101
      prefix: --input
  - id: top_n
    type:
      - 'null'
      - int
    doc: Top N
    inputBinding:
      position: 101
      prefix: --top-n
  - id: read_pattern_out_path
    type: string
    doc: Output or path parameter `read_pattern_out_path`
    inputBinding:
      position: 102
      prefix: --read-pattern-out
outputs:
  - id: read_pattern_out
    type:
      - 'null'
      - File
    doc: Write pattern for each read to this file (optional)
    outputBinding:
      glob: $(inputs.read_pattern_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
