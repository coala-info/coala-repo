cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstacks
label: stacks_cstacks
doc: "Build a catalog of loci from sample data.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: catalog
    type:
      - 'null'
      - File
    doc: add to an existing catalog.
    inputBinding:
      position: 101
      prefix: --catalog
  - id: disable_gapped
    type:
      - 'null'
      - boolean
    doc: 'disable gapped alignments between stacks (default: use gapped alignments).'
    inputBinding:
      position: 101
  - id: in_dir
    type: Directory
    doc: path to the directory containing Stacks files.
    inputBinding:
      position: 101
      prefix: --in-path
  - id: k_len
    type:
      - 'null'
      - int
    doc: specify k-mer size for matching between between catalog loci 
      (automatically calculated by default).
    inputBinding:
      position: 101
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: 'number of gaps allowed between stacks before merging (default: 2).'
    default: 2
    inputBinding:
      position: 101
  - id: min_aln_len
    type:
      - 'null'
      - float
    doc: 'minimum length of aligned sequence in a gapped alignment (default: 0.80).'
    default: 0.8
    inputBinding:
      position: 101
  - id: num_mismatches
    type:
      - 'null'
      - int
    doc: 'number of mismatches allowed between sample loci when build the catalog
      (default 1; suggested: set to ustacks -M).'
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: num_threads
    type:
      - 'null'
      - int
    doc: enable parallel execution with num_threads threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: popmap
    type: File
    doc: path to a population map file.
    inputBinding:
      position: 101
      prefix: --popmap
  - id: report_mmatches
    type:
      - 'null'
      - boolean
    doc: report query loci that match more than one catalog locus.
    inputBinding:
      position: 101
  - id: sample_prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: sample prefix from which to load loci into the catalog.
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_path
    type: Directory
    doc: output path to write results.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
