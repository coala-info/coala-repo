cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - align
label: pangwas_align
doc: "Align clusters using mafft and create a pangenome alignment.\n\nTakes as input the clusters from summarize and the sequence regions\nfrom collect. Outputs multiple sequence alignments per cluster \nas well as a pangenome alignment of concatenated clusters.\n\nAny additional arguments will be passed to `mafft`. If no additional\narguments are used, the following default args will apply:\n  --adjustdirection --localpair --maxiterate 1000 --addfragments\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: "TSV of clusters from summarize."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: regions
    type: File
    doc: "TSV of sequence regions from collect."
    inputBinding:
      position: 101
      prefix: --regions
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: "CPU threads for running mafft in parallel. (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: exclude_singletons
    type:
      - 'null'
      - boolean
    doc: "Exclude clusters found in only 1 sample."
    inputBinding:
      position: 101
      prefix: --exclude-singletons
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Additional arguments passed on to `mafft`."
    inputBinding:
      position: 200
outputs:
  - id: pangenome_alignment
    type: File
    doc: "Pangenome alignment of concatenated clusters"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'pangenome.aln')"
  - id: pangenome_bed
    type: File
    doc: "BED file of cluster coordinates in the pangenome alignment"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'pangenome.bed')"
  - id: pangenome_consensus
    type: File
    doc: "Consensus sequence of the pangenome alignment"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'pangenome.consensus.fasta')"
  - id: pangenome_gff
    type:
      - 'null'
      - File
    doc: "GFF3 of the pangenome alignment"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'pangenome.gff3')"
  - id: cluster_alignments
    type: Directory
    doc: "Directory of multiple sequence alignments per cluster"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'alignments')"
  - id: consensus_dir
    type:
      - 'null'
      - Directory
    doc: "Directory of consensus alignments per cluster"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'consensus')"
  - id: representative_dir
    type:
      - 'null'
      - Directory
    doc: "Directory of representative sequences per cluster"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'representative')"
  - id: sequences_dir
    type:
      - 'null'
      - Directory
    doc: "Directory of sequences per cluster"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'sequences')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
