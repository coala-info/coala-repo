cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - union
label: dashing_union
doc: "Performs a union between sets of sketches\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: sketches
    type:
      type: array
      items: File
    doc: Sketch files to merge
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Perform compression parallel with [int] threads (0)
    inputBinding:
      position: 102
      prefix: -p
  - id: output_path
    type: string
    doc: Write union sketch to file [/dev/stdout]
    inputBinding:
      position: 102
      prefix: -o
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Emit compressed sketch
    inputBinding:
      position: 102
      prefix: -z
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Set gzip compression level
    inputBinding:
      position: 102
      prefix: -Z
  - id: bottom_k
    type:
      - 'null'
      - boolean
    doc: Bottom-k sketches
    inputBinding:
      position: 102
      prefix: -r
  - id: full_khash_sets
    type:
      - 'null'
      - boolean
    doc: Full Khash Sets
    inputBinding:
      position: 102
      prefix: -H
  - id: bloom_filters
    type:
      - 'null'
      - boolean
    doc: Bloom Filters
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: union_sketch
    type: File
    doc: Union sketch
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_union.out
