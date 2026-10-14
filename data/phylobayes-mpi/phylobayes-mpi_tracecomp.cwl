cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracecomp
label: phylobayes-mpi_tracecomp
doc: "Measure the effective sizes and overlap between the 95% credibility intervals of several independent chains.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "detailed output into file <output>.contdiff (default prefix tracecomp)"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: extract
    type:
      - 'null'
      - type: array
        items: int
    doc: "burnin, and optionally every and until (default burnin = 20% of the chain)"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: chain_names
    type:
      type: array
      items: string
    doc: "names of the chains (prefix of the <chain>.trace files)"
    inputBinding:
      position: 2
  - id: chain_files
    type:
      type: array
      items: File
    doc: "files of the chains (<chain>.trace)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output (effective sizes and relative differences)"
  - id: comparison
    type:
      - 'null'
      - File
    doc: "Detailed comparison of the chains"
    outputBinding:
      glob: "$(inputs.output_prefix || \"tracecomp\").contdiff"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.chain_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_tracecomp.out
