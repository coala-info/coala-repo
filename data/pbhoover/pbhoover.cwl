cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbhoover
label: pbhoover
doc: "A tool for calling variants and consensus from PacBio cmp.h5 files.\n\nTool
  homepage: https://gitlab.com/LPCDRP/pbhoover"
inputs:
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Genome chunk size used for parallelizaton, 5000 by default
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Call consensus (output all positions to VCF)
    inputBinding:
      position: 101
      prefix: --consensus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Flag for debugging purposes. Writes more information to log
    inputBinding:
      position: 101
      prefix: --debug
  - id: input
    type:
      - 'null'
      - File
    doc: Input cmp.h5 file
    inputBinding:
      position: 101
      prefix: --input
  - id: min_vf
    type:
      - 'null'
      - float
    doc: Minimum variant frequency to call heterogeneous SNPs and multi-base indels
      (default 0.1)
    inputBinding:
      position: 101
      prefix: --min-vf
  - id: min_vf_si
    type:
      - 'null'
      - float
    doc: Minimum variant frequency to call heterogeneous single-base indels (default
      0.2)
    inputBinding:
      position: 101
      prefix: --min-vf-si
  - id: nproc
    type:
      - 'null'
      - int
    doc: number of processors to be used, uses all available by default
    inputBinding:
      position: 101
      prefix: --nproc
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA file for indel normalization
    inputBinding:
      position: 101
      prefix: --reference
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for analysis.
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file name, stdout by default
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbhoover:1.1.0--pyhdfd78af_1
