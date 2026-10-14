cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bpcomp
label: phylobayes-mpi_bpcomp
doc: "Compare bipartition frequencies between independent chains and build a consensus tree based on the merged lists of trees.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "only partitions with max probability > cutoff (default 0.5)"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "detailed output into files <output>.bpdiff, <output>.bplist and <output>.con.tre (default prefix bpcomp)"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: postscript
    type:
      - 'null'
      - boolean
    doc: "postscript output (requires LaTeX)"
    inputBinding:
      position: 1
      prefix: "-ps"
  - id: extract
    type:
      - 'null'
      - type: array
        items: int
    doc: "burnin, and optionally every and until (default burnin = 1/10 of the chain)"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: chain_names
    type:
      type: array
      items: string
    doc: "names of the chains (prefix of the <chain>.treelist files)"
    inputBinding:
      position: 2
  - id: chain_files
    type:
      type: array
      items: File
    doc: "files of the chains (<chain>.treelist)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output (maxdiff and meandiff)"
  - id: comparison
    type:
      - 'null'
      - type: array
        items: File
    doc: "Bipartition comparison, bipartition list and consensus tree"
    outputBinding:
      glob:
        - "$(inputs.output_prefix || \"bpcomp\").bpdiff"
        - "$(inputs.output_prefix || \"bpcomp\").bplist"
        - "$(inputs.output_prefix || \"bpcomp\").con.tre"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.chain_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_bpcomp.out
