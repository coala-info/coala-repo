cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rapmap
  - quasimap
label: rapmap_quasimap
doc: 'RapMap Mapper: quasi-maps single-end or paired-end reads to a transcriptome
  quasi-index; SAM is written to the output file or standard output.


  Tool homepage: https://github.com/COMBINE-lab/RapMap'
inputs:
  - id: index
    type: Directory
    doc: The location of the quasiindex
    inputBinding:
      position: 101
      prefix: --index
  - id: unmated_reads
    type:
      - 'null'
      - File
    doc: The location of single-end reads
    inputBinding:
      position: 101
      prefix: --unmatedReads
  - id: left_mates
    type:
      - 'null'
      - File
    doc: The location of the left paired-end reads
    inputBinding:
      position: 101
      prefix: --leftMates
  - id: right_mates
    type:
      - 'null'
      - File
    doc: The location of the right paired-end reads
    inputBinding:
      position: 101
      prefix: --rightMates
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable all console output apart from warnings and errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress the output SAM file using zlib
    inputBinding:
      position: 101
      prefix: --compressed
  - id: chaining
    type:
      - 'null'
      - boolean
    doc: Score the hits to find the best chain
    inputBinding:
      position: 101
      prefix: --chaining
  - id: fuzzy_intersection
    type:
      - 'null'
      - boolean
    doc: Find paired-end mapping locations using fuzzy intersection
    inputBinding:
      position: 101
      prefix: --fuzzyIntersection
  - id: no_strict_check
    type:
      - 'null'
      - boolean
    doc: Don't perform extra checks to try and assure that only equally "best" mappings
      for a read are reported
    inputBinding:
      position: 101
      prefix: --noStrictCheck
  - id: no_sensitive
    type:
      - 'null'
      - boolean
    doc: Perform a less sensitive quasi-mapping by enabling NIP skipping
    inputBinding:
      position: 101
      prefix: --noSensitive
  - id: quasi_coverage
    type:
      - 'null'
      - float
    doc: Require that this fraction of a read is covered by MMPs before it is considered
      mappable (0 to 1)
    inputBinding:
      position: 101
      prefix: --quasiCoverage
  - id: max_num_hits
    type:
      - 'null'
      - int
    doc: Reads mapping to more than this many loci are discarded
    inputBinding:
      position: 101
      prefix: --maxNumHits
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Don't write out any alignments (for speed testing purposes)
    inputBinding:
      position: 101
      prefix: --noOutput
  - id: output
    type:
      - 'null'
      - string
    doc: 'The output file (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: SAM alignments (empty when an output file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Alignments written with the output option
    outputBinding:
      glob: $(inputs.output || '__none__')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
stdout: rapmap_quasimap.out
