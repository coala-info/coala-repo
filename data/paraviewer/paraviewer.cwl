cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraviewer
label: paraviewer
doc: "A tool for visualizing paraphase and PureTarget Carrier Panel results.\n\nTool
  homepage: https://github.com/PacificBiosciences/Paraviewer"
inputs:
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it already exists
    inputBinding:
      position: 101
      prefix: --clobber
  - id: exclude_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of region names to exclude.
    inputBinding:
      position: 101
      prefix: --exclude-regions
  - id: exclude_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of sample IDs to exclude.
    inputBinding:
      position: 101
      prefix: --exclude-samples
  - id: genome
    type: string
    doc: Desired genome build. Choose between GRCh37/HG19 (hg19) and GRCh38/HG38 (hg38)
    inputBinding:
      position: 101
      prefix: --genome
  - id: include_only_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of region names to include. Regions not specified will
      be excluded.
    inputBinding:
      position: 101
      prefix: --include-only-regions
  - id: include_only_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of sample IDs to include. Samples not specified will
      be excluded.
    inputBinding:
      position: 101
      prefix: --include-only-samples
  - id: max_reads_per_haplotype
    type:
      - 'null'
      - int
    doc: Maximum number of reads to show per haplotype.
    inputBinding:
      position: 101
      prefix: --max-reads-per-haplotype
  - id: paraphase_dir
    type:
      - 'null'
      - Directory
    doc: Path to paraphase result directory.
    inputBinding:
      position: 101
      prefix: --paraphase-dir
  - id: pedigree
    type:
      - 'null'
      - File
    doc: Path to GATK-format PED file containing pedigree information - unrepresented
      samples will be excluded.
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: ptcp_dir
    type:
      - 'null'
      - Directory
    doc: Path to PureTarget Carrier Panel result directory.
    inputBinding:
      position: 101
      prefix: --ptcp-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output for debugging purposes
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type: Directory
    doc: Path to output directory - should not already exist
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paraviewer:0.1.0--pyhdfd78af_0
