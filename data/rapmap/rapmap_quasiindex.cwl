cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap
label: rapmap_quasiindex
doc: "RapMap Indexer\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs:
  - id: header_sep
    type:
      - 'null'
      - string
    doc: Instead of a space or tab, break the header at the first occurrence of 
      this string, and name the transcript as the token before the first 
      separator
    inputBinding:
      position: 101
      prefix: --headerSep
  - id: index
    type: Directory
    doc: The location where the index should be written
    inputBinding:
      position: 101
      prefix: --index
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Retain and index transcripts, even if they are exact sequence-level 
      duplicates of others.
    inputBinding:
      position: 101
      prefix: --keepDuplicates
  - id: klen
    type:
      - 'null'
      - int
    doc: The length of k-mer to index
    inputBinding:
      position: 101
      prefix: --klen
  - id: no_clip
    type:
      - 'null'
      - boolean
    doc: Don't clip poly-A tails from the ends of target sequences
    inputBinding:
      position: 101
      prefix: --noClip
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Use this many threads to build the perfect hash function
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: perfect_hash
    type:
      - 'null'
      - boolean
    doc: Use a perfect hash instead of sparse hash --- somewhat slows 
      construction, but uses less memory
    inputBinding:
      position: 101
      prefix: --perfectHash
  - id: transcripts
    type: File
    doc: The transcript file to be indexed
    inputBinding:
      position: 101
      prefix: --transcripts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
stdout: rapmap_quasiindex.out
