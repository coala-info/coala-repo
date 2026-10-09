cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isONclust2, cluster]
label: isonclust2_cluster
doc: "Cluster and/or merge batches.\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs:
  - id: left_batch
    type: File
    doc: Left input batch.
    inputBinding:
      position: 1
      prefix: --left-batch
  - id: right_batch
    type: ['null', File]
    doc: Right input batch.
    inputBinding:
      position: 2
      prefix: --right-batch
  - id: outfile
    type: string
    doc: Output batch.
    inputBinding:
      position: 3
      prefix: --outfile
  - id: mode
    type:
      - 'null'
      - type: enum
        symbols:
          - sahlin
          - fast
          - furious
    default: sahlin
    doc: Clustering mode, sahlin (default) uses minimizers first and alignment second, fast uses minimizers only, furious uses alignment only. The tool fails with "Invalid clustering mode" when the option is left out, so the default is passed explicitly.
    inputBinding:
      position: 4
      prefix: -x
  - id: spoa_algo
    type: ['null', int]
    doc: Spoa alignment algorithm, 0 local (default), 1 global, 2 semi-global.
    inputBinding:
      position: 5
      prefix: --spoa-algo
  - id: min_purge
    type: ['null', boolean]
    doc: Purge minimizer database from output batch.
    inputBinding:
      position: 6
      prefix: --min-purge
  - id: keep_seq
    type: ['null', boolean]
    doc: Do not purge non-representative sequences from output batches.
    inputBinding:
      position: 7
      prefix: --keep-seq
  - id: min_cls_size
    type: ['null', int]
    doc: Skip clusters smaller than this in the left batch.
    inputBinding:
      position: 8
      prefix: --min-cls-size
  - id: verbose
    type: ['null', boolean]
    doc: Verbose output.
    inputBinding:
      position: 9
      prefix: --verbose
  - id: quiet
    type: ['null', boolean]
    doc: Suppress progress bar.
    inputBinding:
      position: 10
      prefix: --quiet
  - id: debug
    type: ['null', boolean]
    doc: Print debug info.
    inputBinding:
      position: 11
      prefix: --debug
outputs:
  - id: output_batch
    type: File
    doc: Clustered output batch.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
