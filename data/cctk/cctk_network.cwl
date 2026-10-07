cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cctk
  - network
label: cctk_network
doc: "Builds a network of CRISPR arrays based on shared spacers.\n\nTool homepage:
  https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: input
    type: File
    doc: Array_IDs.txt or Array_seqs.txt
    inputBinding:
      position: 101
      prefix: --input
  - id: min_shared
    type:
      - 'null'
      - int
    doc: minimum spacers shared to draw an edge in network
    inputBinding:
      position: 101
      prefix: --min-shared
  - id: outdir
    type:
      - 'null'
      - string
    doc: output directory path. Default ./ (created when given)
    inputBinding:
      position: 101
      prefix: --outdir
  - id: types
    type:
      - 'null'
      - File
    doc: 'array CRISPR subtypes file. 2 columns: Array Type'
    inputBinding:
      position: 101
      prefix: --types
outputs:
  - id: network_file
    type: File
    doc: Array network file (Array_network.txt)
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/' : '')Array_network.txt"
  - id: clusters_file
    type: File
    doc: Array cluster file (Array_clusters.txt)
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/' : '')Array_clusters.txt"
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: output directory path. Default ./ (created when given)
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return inputs.outdir ? [{class: 'Directory', basename: inputs.outdir,
        listing: [], writable: true}] : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
stdout: cctk_network.out
