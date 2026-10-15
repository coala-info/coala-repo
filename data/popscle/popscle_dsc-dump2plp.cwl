cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popscle, dsc-dump2plp]
label: popscle_dsc-dump2plp
doc: "Produce a pileup from a dump of dsc-dump.\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: in_prefix
    type: string
    doc: "Input prefix from popscle dsc-dump"
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 1
      prefix: --out
  - id: chunk_id
    type:
      - 'null'
      - int
    doc: "Chunk ID to focus on. By default, it runs across all chunks Default: -1"
    inputBinding:
      position: 1
      prefix: --chunk-id
  - id: dump_files
    type:
      type: array
      items: File
    doc: "Dump files <prefix>.barcodes.tsv.gz and <prefix>.variants.tsv.gz written by dsc-dump"
  - id: dump_tmp
    type: Directory
    doc: "Chunk folder <prefix>.tmp written by dsc-dump"
outputs:
  - id: pileup_files
    type:
      type: array
      items: File
    doc: "Pileup files: <out>.plp.gz, .var.gz, .cel.gz and .umi.gz"
    outputBinding:
      glob: "$(inputs.out).*"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dump_tmp)
        entryname: $(inputs.in_prefix).tmp
      - $(inputs.dump_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_dsc-dump2plp.out
stderr: popscle_dsc-dump2plp.log
