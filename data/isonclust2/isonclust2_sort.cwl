cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isONclust2, sort]
label: isonclust2_sort
doc: "Sort reads and write out batches for clustering.\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs:
  - id: fastq
    type: File
    doc: Input fastq file.
    inputBinding:
      position: 100
  - id: batch_size
    type: ['null', int]
    doc: Batch size in kilobases (default 50000).
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: batch_max_seq
    type: ['null', int]
    doc: Maximum number of sequences per batch (default 3000).
    inputBinding:
      position: 2
      prefix: --batch-max-seq
  - id: kmer_size
    type: ['null', int]
    doc: Kmer size (default 11).
    inputBinding:
      position: 3
      prefix: --kmer-size
  - id: window_size
    type: ['null', int]
    doc: Window size (default 15).
    inputBinding:
      position: 4
      prefix: --window-size
  - id: min_shared
    type: ['null', int]
    doc: Minimum number of minimizers shared between read and cluster (default 5).
    inputBinding:
      position: 5
      prefix: --min-shared
  - id: min_qual
    type: ['null', float]
    doc: Minimum average quality value (default 7.0).
    inputBinding:
      position: 6
      prefix: --min-qual
  - id: mode
    type:
      - 'null'
      - type: enum
        symbols:
          - sahlin
          - fast
          - furious
    doc: Clustering mode, sahlin (default) uses minimizers first and alignment second, fast uses minimizers only, furious always uses alignment.
    inputBinding:
      position: 7
      prefix: -x
  - id: low_cons_size
    type: ['null', int]
    doc: Use all sequences for consensus below this size (default 20).
    inputBinding:
      position: 8
      prefix: --low-cons-size
  - id: max_cons_size
    type: ['null', int]
    doc: Maximum number of sequences used for consensus (default 150).
    inputBinding:
      position: 9
      prefix: --max-cons-size
  - id: cons_period
    type: ['null', int]
    doc: Do not recalculate consensus after this many sequences added (default 500).
    inputBinding:
      position: 10
      prefix: --cons-period
  - id: mapped_threshold
    type: ['null', float]
    doc: Minimum mapped fraction of read to be included in cluster (default 0.65).
    inputBinding:
      position: 11
      prefix: --mapped-threshold
  - id: aligned_threshold
    type: ['null', float]
    doc: Minimum aligned fraction of read to be included in cluster (default 0.2).
    inputBinding:
      position: 12
      prefix: --aligned-threshold
  - id: min_fraction
    type: ['null', float]
    doc: Minimum fraction of minimizers shared compared to best hit, in order to continue mapping (default 0.8).
    inputBinding:
      position: 13
      prefix: --min-fraction
  - id: min_prob_no_hits
    type: ['null', float]
    doc: Minimum probability for i consecutive minimizers to be different between read and representative (default 0.1).
    inputBinding:
      position: 14
      prefix: --min-prob-no-hits
  - id: min_cls_size
    type: ['null', int]
    doc: Skip clusters smaller than this in the left batch (default 3).
    inputBinding:
      position: 15
      prefix: --min-cls-size
  - id: outfolder
    type: string
    default: isONclust2_batches
    doc: Output folder.
    inputBinding:
      position: 16
      prefix: --outfolder
  - id: verbose
    type: ['null', boolean]
    doc: Verbose output.
    inputBinding:
      position: 17
      prefix: --verbose
  - id: debug
    type: ['null', boolean]
    doc: Print debug info.
    inputBinding:
      position: 18
      prefix: --debug
outputs:
  - id: batches_folder
    type: Directory
    doc: Output folder with the sorted reads, scores and batches.
    outputBinding:
      glob: $(inputs.outfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
