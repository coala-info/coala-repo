cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/CONSENT-polish
label: consent_CONSENT-polish
doc: "Polishes contigs using long reads.\n\nTool homepage: https://github.com/morispi/CONSENT"
inputs:
  - id: anchor_support
    type:
      - 'null'
      - int
    doc: Minimum number of sequences supporting (Ai) - (Ai+1) to keep the two 
      anchors in the chaining.
    default: 8
    inputBinding:
      position: 101
      prefix: --anchorSupport
  - id: contigs
    type: File
    doc: fasta or fastq file of contigs to polish.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: max_support
    type:
      - 'null'
      - int
    doc: Maximum number of overlaps to include in a pile.
    default: 20000
    inputBinding:
      position: 101
      prefix: --maxSupport
  - id: mer_size
    type:
      - 'null'
      - int
    doc: k-mer size for chaining and polishing.
    default: 9
    inputBinding:
      position: 101
      prefix: --merSize
  - id: min_anchors
    type:
      - 'null'
      - int
    doc: Minimum number of anchors in a window to allow consensus computation.
    default: 10
    inputBinding:
      position: 101
      prefix: --minAnchors
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum support to consider a window for correction.
    default: 1
    inputBinding:
      position: 101
      prefix: --minSupport
  - id: minimap_index
    type:
      - 'null'
      - int
    doc: Split minimap2 index every INT input bases
    default: 500M
    inputBinding:
      position: 101
      prefix: --minimapIndex
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to run in parallel
    inputBinding:
      position: 101
      prefix: --nproc
  - id: reads
    type: File
    doc: fasta or fastq file of long reads to use for polishing.
    inputBinding:
      position: 101
      prefix: --reads
  - id: solid
    type:
      - 'null'
      - int
    doc: Minimum number of occurrences to consider a k-mer as solid during 
      polishing.
    default: 4
    inputBinding:
      position: 101
      prefix: --solid
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path where to store the temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: window_overlap
    type:
      - 'null'
      - int
    doc: Overlap size between consecutive windows.
    default: 50
    inputBinding:
      position: 101
      prefix: --windowOverlap
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the windows to process.
    default: 500
    inputBinding:
      position: 101
      prefix: --windowSize
outputs:
  - id: out
    type: File
    doc: fasta file where to output the polished contigs.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consent:2.2.2--h3452944_6
