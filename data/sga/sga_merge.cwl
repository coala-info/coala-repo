cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga_merge
label: sga_merge
doc: "Merge the sequence files READS1, READS2 into a single file/index\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: reads1
    type: File
    doc: First sequence file to merge
    inputBinding:
      position: 1
  - id: reads2
    type: File
    doc: Second sequence file to merge
    inputBinding:
      position: 2
  - id: gap_array
    type:
      - 'null'
      - int
    doc: use N bits of storage for each element of the gap array. Acceptable 
      values are 4,8,16 or 32. Lower values can substantially reduce the amount 
      of memory required at the cost of less predictable memory usage. When this
      value is set to 32, the memory requirement is essentially deterministic 
      and requires ~5N bytes where N is the size of the FM-index of READS2.
    inputBinding:
      position: 103
      prefix: --gap-array
  - id: no_forward
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the forward index. Use this option when merging the
      index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-forward
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the reverse index. Use this option when merging the
      index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-reverse
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the sequence files. Use this option when merging 
      the index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-sequence
  - id: prefix
    type:
      - 'null'
      - string
    doc: write final index to files starting with PREFIX (the default is to 
      concatenate the input filenames)
    inputBinding:
      position: 103
      prefix: --prefix
  - id: remove
    type:
      - 'null'
      - boolean
    doc: remove the original BWT, SAI and reads files after the merge
    inputBinding:
      position: 103
      prefix: --remove
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to merge the indices
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_merge.out
