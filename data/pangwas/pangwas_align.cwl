cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas_align
label: pangwas_align
doc: "Align clusters using mafft and create a pangenome alignment.\n\nTakes as input
  the clusters from summarize and the sequence regions\nfrom collect. Outputs multiple
  sequence alignments per cluster \nas well as a pangenome alignment of concatenated
  clusters.\n\nAny additional arguments will be passed to `mafft`. If no additional\n\
  arguments are used, the following default args will apply:\n  --adjustdirection
  --localpair --maxiterate 1000 --addfragments\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: TSV of clusters from summarize.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: exclude_singletons
    type:
      - 'null'
      - boolean
    doc: Exclude clusters found in only 1 sample.
    inputBinding:
      position: 101
      prefix: --exclude-singletons
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: regions
    type: File
    doc: TSV of sequence regions from collect.
    inputBinding:
      position: 101
      prefix: --regions
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for running mafft in parallel.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
