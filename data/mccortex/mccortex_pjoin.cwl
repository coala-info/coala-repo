cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - pjoin
label: mccortex_pjoin
doc: "Merge cortex link files.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: memory
    type: string
    doc: Memory to use (required by the tool; recommended 80G for human).
    inputBinding:
      position: 1
      prefix: --memory
    default: 1GB
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M, 1G). Default 4M.
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit on processing threads (default 2).
    inputBinding:
      position: 1
      prefix: --threads
  - id: out
    type: string
    default: joined.ctp.gz
    doc: Output link file (.ctp.gz).
    inputBinding:
      position: 1
      prefix: --out
  - id: graph
    type:
      - 'null'
      - File
    doc: 'Get the number of hash table entries from this graph file. Known problem: in mccortex 1.0 this can stop with ''Out of memory''; give --nkmers instead.'
    inputBinding:
      position: 1
      prefix: --graph
  - id: outcols
    type:
      - 'null'
      - int
    doc: How many colours the output file should have.
    inputBinding:
      position: 1
      prefix: --outcols
  - id: noredundant
    type:
      - 'null'
      - boolean
    doc: 'Remove redundant paths. Known problem: in mccortex 1.0 the option parser expects a value after this flag and swallows the next argument, so leave it off.'
    inputBinding:
      position: 1
      prefix: --noredundant
  - id: links
    type:
      type: array
      items: File
    doc: Input link files (.ctp.gz), merged in order. The forms offset:file.ctp and file.ctp:2,3 are not available.
    inputBinding:
      position: 100
outputs:
  - id: links_out
    type: File
    doc: Merged link file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
