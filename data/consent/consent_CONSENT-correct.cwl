cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/CONSENT-correct
label: consent_CONSENT-correct
doc: "Indicate whether the long reads are from PacBio (--type PB) or Oxford Nanopore
  (--type ONT)\n\nTool homepage: https://github.com/morispi/CONSENT"
inputs:
  - id: in_long_reads
    type: File
    doc: fasta or fastq file of long reads to correct.
    inputBinding:
      position: 1
  - id: type_reads_technology
    type: string
    doc: Indicate whether the long reads are from PacBio (--type PB) or Oxford 
      Nanopore (--type ONT)
    inputBinding:
      position: 2
  - id: anchor_support
    type:
      - 'null'
      - int
    doc: Minimum number of sequences supporting (Ai) - (Ai+1) to keep the two 
      anchors in the chaining.
    inputBinding:
      position: 103
      prefix: --anchorSupport
  - id: max_support
    type:
      - 'null'
      - int
    doc: Maximum number of overlaps to include in a pile.
    inputBinding:
      position: 103
      prefix: --maxSupport
  - id: mer_size
    type:
      - 'null'
      - int
    doc: k-mer size for chaining and polishing.
    inputBinding:
      position: 103
      prefix: --merSize
  - id: min_anchors
    type:
      - 'null'
      - int
    doc: Minimum number of anchors in a window to allow consensus computation.
    inputBinding:
      position: 103
      prefix: --minAnchors
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum support to consider a window for correction.
    inputBinding:
      position: 103
      prefix: --minSupport
  - id: minimap_index
    type:
      - 'null'
      - int
    doc: Split minimap2 index every INT input bases
    inputBinding:
      position: 103
      prefix: --minimapIndex
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to run in parallel
    inputBinding:
      position: 103
      prefix: --nproc
  - id: solid
    type:
      - 'null'
      - int
    doc: Minimum number of occurrences to consider a k-mer as solid during 
      polishing.
    inputBinding:
      position: 103
      prefix: --solid
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Path where to store the temporary files
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: window_overlap
    type:
      - 'null'
      - int
    doc: Overlap size between consecutive windows.
    inputBinding:
      position: 103
      prefix: --windowOverlap
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the windows to process.
    inputBinding:
      position: 103
      prefix: --windowSize
outputs:
  - id: out_result
    type: File
    doc: fasta file where to output the corrected long reads.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consent:2.2.2--h3452944_6
