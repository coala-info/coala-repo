cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - merge
label: sga_merge
doc: 'Merge the sequence files READS1, READS2 into a single file/index


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: reads1
    type: File
    doc: First sequence file to merge
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
    secondaryFiles:
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
      - ^.popidx?
  - id: reads2
    type: File
    doc: Second sequence file to merge
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
    secondaryFiles:
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
      - ^.popidx?
  - id: gap_array
    type:
      - 'null'
      - int
    doc: use N bits of storage for each element of the gap array. Acceptable values are 4,8,16 or 32. Lower values can substantially reduce the amount of memory required at the cost of less predictable memory usage. When this value is set to 32, the memory requirement is essentially deterministic and requires ~5N bytes where N is the size of the FM-index of READS2.
    inputBinding:
      position: 103
      prefix: --gap-array
  - id: no_forward
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the forward index. Use this option when merging the index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-forward
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the reverse index. Use this option when merging the index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-reverse
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Suppress merging of the sequence files. Use this option when merging the index(es) separate e.g. in parallel
    inputBinding:
      position: 103
      prefix: --no-sequence
  - id: prefix
    type: string
    doc: Write the merged files starting with PREFIX (PREFIX.fa, PREFIX.bwt, PREFIX.rbwt, PREFIX.sai, PREFIX.rsai).
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
  - id: merged_reads
    type:
      - 'null'
      - File
    doc: Merged reads.
    outputBinding:
      glob: $(inputs.prefix).fa
  - id: bwt
    type:
      - 'null'
      - File
    doc: Merged forward BWT.
    outputBinding:
      glob: $(inputs.prefix).bwt
  - id: rbwt
    type:
      - 'null'
      - File
    doc: Merged reverse BWT.
    outputBinding:
      glob: $(inputs.prefix).rbwt
  - id: sai
    type:
      - 'null'
      - File
    doc: Merged sampled suffix array.
    outputBinding:
      glob: $(inputs.prefix).sai
  - id: rsai
    type:
      - 'null'
      - File
    doc: Merged reverse sampled suffix array.
    outputBinding:
      glob: $(inputs.prefix).rsai
  - id: popidx
    type:
      - 'null'
      - File
    doc: Merged population index (when both inputs have one).
    outputBinding:
      glob: $(inputs.prefix).popidx
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_merge.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads1)
      - $(inputs.reads2)
