cwlVersion: v1.2
class: CommandLineTool
baseCommand: transmute
label: entrez-direct_transmute
doc: "Converts and edits XML, JSON, tabular and sequence data read from standard input (pretty-printing, JSON/ASN.1/table/CSV/YAML to XML, GenBank to XML, sequence editing, translation and searching).\n\nPass one mode flag (for example -x2p, -j2p, -j2x, -t2x, -c2x, -g2x, -revcomp, -cds2prot, -molwt, -hgvs, -counts) and its options in the order transmute expects.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: data_input
    type: File
    doc: Input data, sent to transmute on standard input
  - id: mode
    type: string
    doc: "Mode flag, for example -x2p, -j2p, -f2p, -align, -j2x, -a2x, -t2x, -c2x,\n      -i2x, -m2x, -y2x, -txf, -f2x, -g2x, -g2r, -r2p, -gbf, -revcomp, -remove,\n      -retain, -replace, -extract, -cds2prot, -molwt, -hgvs, -counts, -diff,\n      -codons, -search"
    inputBinding:
      position: 1
  - id: mode_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Options of the mode, in order (for example -set, Set, -rec, Rec for -j2x)"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdin: $(inputs.data_input.path)
stdout: entrez-direct_transmute.out
