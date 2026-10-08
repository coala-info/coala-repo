cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - bam-depth
label: rust-bio-tools_bam-depth
doc: "Print depth of BAM or CRAM file at given positions from STDIN (tab separated:
  chrom, pos). Depths are written to stdout as tab-separated lines (chrom, pos, depth).\n  \nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: bam_path
    type: File
    secondaryFiles:
      - .bai
    doc: Path to indexed BAM file
    inputBinding:
      position: 1
  - id: positions
    type: File
    doc: Positions file with one reference name and one position per line (tab
      separated), read from STDIN
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: 'Skip reads with mask bits set [UNMAP, SECONDARY, QCFAIL, DUP] [default:
      1796]'
    inputBinding:
      position: 101
      prefix: --excl-flags
  - id: include_flags
    type:
      - 'null'
      - int
    doc: 'Skip reads with mask bits unset [] [default: 0]'
    inputBinding:
      position: 101
      prefix: --incl-flags
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length to consider. This affects the speed of the involved
      pileup. Reads longer than this length can be missed when calculating the depth
      [default: 1000]'
    inputBinding:
      position: 101
      prefix: --max-read-length
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality [default: 0]'
    inputBinding:
      position: 101
      prefix: --min-mapq
outputs:
  - id: depth
    type: stdout
    doc: Tab-separated chrom, pos, depth lines
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdin: $(inputs.positions.path)
stdout: depth.txt
