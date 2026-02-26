cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_from_bam
label: fast5-research_filter_from_bam
doc: "Filter FAST5 files based on BAM alignment information.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file containing alignment information.
    inputBinding:
      position: 1
  - id: fast5_dir
    type: Directory
    doc: Directory containing the FAST5 files to filter.
    inputBinding:
      position: 2
  - id: exclude_unmapped
    type:
      - 'null'
      - boolean
    doc: Exclude reads that are unmapped in the BAM file.
    inputBinding:
      position: 103
      prefix: --exclude_unmapped
  - id: include_unmapped
    type:
      - 'null'
      - boolean
    doc: Include reads that are unmapped in the BAM file.
    inputBinding:
      position: 103
      prefix: --include_unmapped
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality score for reads to be included.
    default: 0
    inputBinding:
      position: 103
      prefix: --min_mapq
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Directory where the filtered FAST5 files will be saved.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
