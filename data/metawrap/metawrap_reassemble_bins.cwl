cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - reassemble_bins
label: metawrap_reassemble_bins
doc: "Reassemble metagenomic bins using provided reads.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: bin_folder
    type: Directory
    doc: folder with metagenomic bins
    inputBinding:
      position: 101
      prefix: -b
  - id: max_contamination
    type:
      - 'null'
      - int
    doc: maximum desired bin contamination %
    inputBinding:
      position: 101
      prefix: -x
  - id: memory
    type:
      - 'null'
      - int
    doc: memory in GB
    inputBinding:
      position: 101
      prefix: -m
  - id: min_completion
    type:
      - 'null'
      - int
    doc: minimum desired bin completion %
    inputBinding:
      position: 101
      prefix: -c
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length to be included in reassembly
    inputBinding:
      position: 101
      prefix: -l
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: run spades reassembly in parallel, but only using 1 thread per bin
    inputBinding:
      position: 101
      prefix: --parallel
  - id: permissive_cut_off
    type:
      - 'null'
      - boolean
    doc: maximum allowed SNPs for permissive read mapping
    inputBinding:
      position: 101
      prefix: --permissive-cut-off
  - id: reads_1
    type: File
    doc: forward reads to use for reassembly
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads_2
    type: File
    doc: reverse reads to use for reassembly
    inputBinding:
      position: 101
      prefix: '-2'
  - id: skip_checkm
    type:
      - 'null'
      - boolean
    doc: dont run CheckM to assess bins
    inputBinding:
      position: 101
      prefix: --skip-checkm
  - id: strict_cut_off
    type:
      - 'null'
      - boolean
    doc: maximum allowed SNPs for strict read mapping
    inputBinding:
      position: 101
      prefix: --strict-cut-off
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
