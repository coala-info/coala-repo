cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_ovlp_ec
label: peregrine-2021_pg_ovlp_ec
doc: "Perform error correction from the haplotype specific overlaps (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: seqdb
    type: File
    doc: Path to the seqdb file
    inputBinding:
      position: 200
  - id: seqidx
    type: File
    doc: Path to the seqdb index file
    inputBinding:
      position: 201
  - id: prefix
    type: string
    doc: The prefix of the overlap files
    inputBinding:
      position: 202
  - id: out_prefix
    type: string
    doc: The prefix of the output error corrected read files
    inputBinding:
      position: 203
  - id: nthreads
    type: int
    doc: Number of threads
    inputBinding:
      position: 204
  - id: nchunks
    type: int
    doc: Number of partition
    inputBinding:
      position: 205
  - id: overlap_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Overlap files made by pg_ovlp; they are staged in the working directory so the prefix resolves.
  - id: min_ec_cov
    type:
      - 'null'
      - int
    doc: Minimum error coverage (default 1)
    inputBinding:
      position: 110
      prefix: --min_ec_cov
  - id: tol
    type:
      - 'null'
      - float
    doc: Alignment tolerance (default 0.01)
    inputBinding:
      position: 110
      prefix: --tol
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: corrected_reads
    type:
      type: array
      items: File
    doc: Error corrected reads, one fasta file per chunk
    outputBinding:
      glob: $(inputs.out_prefix)_*.fa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.overlap_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
