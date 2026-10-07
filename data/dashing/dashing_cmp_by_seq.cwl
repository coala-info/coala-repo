cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - cmp_by_seq
label: dashing_cmp_by_seq
doc: "Compares sketches made by sketch_by_seq, one per sequence record (distance,\
  \ similarity or containment).\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: input_file
    type: File
    doc: Sketch file written by sketch_by_seq
    inputBinding:
      position: 1
  - id: namefile
    type: File
    doc: Names file written by sketch_by_seq (<sketch>.names)
    inputBinding:
      position: 102
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: threads [1]
    inputBinding:
      position: 102
      prefix: -p
  - id: output_path
    type:
      - 'null'
      - string
    doc: output path [/dev/stdout]
    inputBinding:
      position: 102
      prefix: -o
  - id: emit_binary
    type:
      - 'null'
      - boolean
    doc: emit binary output
    inputBinding:
      position: 102
      prefix: -b
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: emit PHYLIP Upper Triangular output
    inputBinding:
      position: 102
      prefix: -U
  - id: full_tsv
    type:
      - 'null'
      - boolean
    doc: emit full TSV format
    inputBinding:
      position: 102
      prefix: -T
  - id: bbit_minhash
    type:
      - 'null'
      - boolean
    doc: b-bit minhash (use when the sketches were made with --use-bb-minhash)
    inputBinding:
      position: 102
      prefix: '-8'
  - id: bloom_filter
    type:
      - 'null'
      - boolean
    doc: Bloom Filter
    inputBinding:
      position: 102
      prefix: -B
  - id: counting_range_minhash
    type:
      - 'null'
      - boolean
    doc: Counting Range MinHash
    inputBinding:
      position: 102
      prefix: -C
  - id: range_minhash
    type:
      - 'null'
      - boolean
    doc: Range MinHash
    inputBinding:
      position: 102
      prefix: -r
  - id: joint_mle
    type:
      - 'null'
      - boolean
    doc: Joint MLE
    inputBinding:
      position: 102
      prefix: -J
  - id: original_flajolet
    type:
      - 'null'
      - boolean
    doc: Original Flajolet
    inputBinding:
      position: 102
      prefix: -E
  - id: ertl_improved
    type:
      - 'null'
      - boolean
    doc: Ertl Improved
    inputBinding:
      position: 102
      prefix: -I
  - id: containment_index
    type:
      - 'null'
      - boolean
    doc: Emit containment index
    inputBinding:
      position: 102
      prefix: --containment-index
  - id: containment_dist
    type:
      - 'null'
      - boolean
    doc: Emit containment distnace
    inputBinding:
      position: 102
      prefix: --containment-dist
  - id: mash_dist
    type:
      - 'null'
      - boolean
    doc: Emit mash distance
    inputBinding:
      position: 102
      prefix: --mash-dist
  - id: symmetric_containment_index
    type:
      - 'null'
      - boolean
    doc: Emit symmetric containment index
    inputBinding:
      position: 102
      prefix: --symmetric-containment-index
  - id: symmetric_containment_dist
    type:
      - 'null'
      - boolean
    doc: Emit symmetric containment distance
    inputBinding:
      position: 102
      prefix: --symmetric-containment-dist
  - id: sizes
    type:
      - 'null'
      - boolean
    doc: Emit intersection sizes
    inputBinding:
      position: 102
      prefix: --sizes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
    doc: Distance matrix
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_cmp_by_seq.out
