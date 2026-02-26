cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap
label: rapmap_quasimap
doc: "RapMap Mapper\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs:
  - id: chaining
    type:
      - 'null'
      - boolean
    doc: Score the hits to find the best chain
    inputBinding:
      position: 101
      prefix: --chaining
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress the output SAM file using zlib
    inputBinding:
      position: 101
      prefix: --compressed
  - id: fuzzy_intersection
    type:
      - 'null'
      - boolean
    doc: Find paired-end mapping locations using fuzzy intersection
    inputBinding:
      position: 101
      prefix: --fuzzyIntersection
  - id: index
    type: File
    doc: The location of the quasiindex
    inputBinding:
      position: 101
      prefix: --index
  - id: left_mates
    type:
      - 'null'
      - File
    doc: The location of the left paired-end reads
    inputBinding:
      position: 101
      prefix: --leftMates
  - id: max_num_hits
    type:
      - 'null'
      - int
    doc: Reads mapping to more than this many loci are discarded
    inputBinding:
      position: 101
      prefix: --maxNumHits
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Don't write out any alignments (for speed testing purposes)
    inputBinding:
      position: 101
      prefix: --noOutput
  - id: no_sensitive
    type:
      - 'null'
      - boolean
    doc: Perform a less sensitive quasi-mapping by enabling NIP skipping
    inputBinding:
      position: 101
      prefix: --noSensitive
  - id: no_strict_check
    type:
      - 'null'
      - boolean
    doc: Don't perform extra checks to try and assure that only equally "best" 
      mappings for a read are reported
    inputBinding:
      position: 101
      prefix: --noStrictCheck
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: quasi_coverage
    type:
      - 'null'
      - float
    doc: Require that this fraction of a read is covered by MMPs before it is 
      considered mappable.
    inputBinding:
      position: 101
      prefix: --quasiCoverage
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable all console output apart from warnings and errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: right_mates
    type:
      - 'null'
      - File
    doc: The location of the right paired-end reads
    inputBinding:
      position: 101
      prefix: --rightMates
  - id: unmated_reads
    type:
      - 'null'
      - File
    doc: The location of single-end reads
    inputBinding:
      position: 101
      prefix: --unmatedReads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'The output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
