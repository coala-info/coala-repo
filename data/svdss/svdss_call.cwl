cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SVDSS
  - call
label: svdss_call
doc: "Call SVs from the assembled superstrings; the VCF goes to standard output\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai?
    doc: "Reference FASTA."
    inputBinding:
      position: 101
      prefix: --reference
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: "Input BAM file (must be the one used in the search step and indexed)."
    inputBinding:
      position: 101
      prefix: --bam
  - id: sfs
    type: File
    doc: "Specific strings file from the search step."
    inputBinding:
      position: 101
      prefix: --sfs
  - id: poa
    type:
      - 'null'
      - string
    doc: "Store POA in .sam format to this file (default: do not store)."
    inputBinding:
      position: 101
      prefix: --poa
  - id: clusters
    type:
      - 'null'
      - string
    doc: "Store clusters to this file (default: do not store)."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: min_cluster_weight
    type:
      - 'null'
      - int
    doc: "Minimum number of supporting superstrings for a call to be reported (default: 2)."
    inputBinding:
      position: 101
      prefix: --min-cluster-weight
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: "Minimum length of reported SVs (default: 25)."
    inputBinding:
      position: 101
      prefix: --min-sv-length
  - id: noht
    type:
      - 'null'
      - boolean
    doc: "Do not use haplotagging information even if present."
    inputBinding:
      position: 101
      prefix: --noht
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (default: 20)."
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: clipped
    type:
      - 'null'
      - boolean
    doc: "Calls SVs from clipped SFS (EXPERIMENTAL)."
    inputBinding:
      position: 101
      prefix: --clipped
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 4)."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: calls_vcf
    type: stdout
    doc: SV calls (VCF) written to standard output.
  - id: poa_sam
    type:
      - 'null'
      - File
    doc: POA contig alignments, when --poa is given.
    outputBinding:
      glob: $(inputs.poa)
  - id: clusters_file
    type:
      - 'null'
      - File
    doc: Clusters, when --clusters is given.
    outputBinding:
      glob: $(inputs.clusters)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: calls.vcf
