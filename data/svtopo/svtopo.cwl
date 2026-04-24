cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtopo
label: svtopo
doc: "svtopo is a tool for analyzing structural variants from PacBio HiFi sequencing
  data.\n\nTool homepage: https://github.com/PacificBiosciences/HiFi-SVTopo"
inputs:
  - id: bam
    type: File
    doc: pbmm2-aligned BAM filename
    inputBinding:
      position: 101
      prefix: --bam
  - id: exclude_regions
    type: File
    doc: BED file of regions to exclude from analysis. GZIP files allowed
    inputBinding:
      position: 101
      prefix: --exclude-regions
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Filter threshold for maximum coverage, to remove regions with coverage 
      spikes due to e.g. alignment issues
    inputBinding:
      position: 101
      prefix: --max-coverage
  - id: prefix
    type: string
    doc: Sample or project ID. No underscores allowed
    inputBinding:
      position: 101
      prefix: --prefix
  - id: svtopo_dir
    type: Directory
    doc: Output directory path
    inputBinding:
      position: 101
      prefix: --svtopo-dir
  - id: variant_readnames
    type:
      - 'null'
      - string
    doc: json with readnames for variant IDs from VCF. Requires `--vcf`
    inputBinding:
      position: 101
      prefix: --variant-readnames
  - id: vcf
    type:
      - 'null'
      - File
    doc: structual variant VCF filename
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Optional flag to print verbose output for debugging purposes
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtopo:0.3.0--h9ee0642_0
stdout: svtopo.out
