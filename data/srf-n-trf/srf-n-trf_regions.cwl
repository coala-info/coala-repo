cwlVersion: v1.2
class: CommandLineTool
baseCommand: srf-n-trf_regions
label: srf-n-trf_regions
doc: "Generates regions based on TRF output, merging and filtering based on monomer
  composition and distance.\n\nTool homepage: https://github.com/koisland/srf-n-trf"
inputs:
  - id: bed_file
    type: File
    doc: Bed file from extract command
    inputBinding:
      position: 101
      prefix: --bed
  - id: diff
    type:
      - 'null'
      - float
    doc: Difference in required monomer size
    default: 0.02
    inputBinding:
      position: 101
      prefix: --diff
  - id: dst
    type:
      - 'null'
      - int
    doc: Distance to merge in base pairs
    default: 100000
    inputBinding:
      position: 101
      prefix: --dst
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length in base pairs
    default: 30000
    inputBinding:
      position: 101
      prefix: --min-len
  - id: sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: Required monomers in merged blocks. Merges iff one of these monomer 
      periods is in block. Also filters out monomers not within this period
    default:
      - 170
      - 340
      - 510
      - 680
      - 850
      - 1020
    inputBinding:
      position: 101
      prefix: --sizes
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Output BED9 file with columns: `chrom, st, end, comma-delimited_monomers,
      0, strand, st, end, '0,0,0'`"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
