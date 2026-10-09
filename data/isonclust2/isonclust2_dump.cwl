cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isONclust2, dump]
label: isonclust2_dump
doc: "Dump a clustered batch (cluster assignments, consensus and reads).\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs:
  - id: batch
    type: File
    doc: Clustered batch to dump.
    inputBinding:
      position: 100
  - id: outdir
    type: string
    default: isONclust2_dump
    doc: Output directory.
    inputBinding:
      position: 1
      prefix: --outdir
  - id: sort_folder
    type: Directory
    doc: Output folder of the sort step. It is staged in the working directory under its own name, because the read index stores the relative path of sorted_reads.fastq. The index sorted_reads_idx.cer inside it is passed to --index.
  - id: verbose
    type: ['null', boolean]
    doc: Verbose output.
    inputBinding:
      position: 3
      prefix: --verbose
  - id: debug
    type: ['null', boolean]
    doc: Print debug info.
    inputBinding:
      position: 4
      prefix: --debug
arguments:
  - prefix: --index
    position: 2
    valueFrom: $(inputs.sort_folder.basename)/sorted_reads_idx.cer
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sort_folder)
outputs:
  - id: dump_dir
    type: Directory
    doc: Output directory with clusters.tsv, clusters_info.tsv, cluster_cons.fq and per-cluster fastq files.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
