cwlVersion: v1.2
class: CommandLineTool
baseCommand: sstacks
label: stacks_sstacks
doc: "Stacks de novo assembly pipeline\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: catalog
    type: File
    doc: path to the catalog.
    inputBinding:
      position: 101
      prefix: --catalog
  - id: disable_gapped
    type:
      - 'null'
      - boolean
    doc: 'disable gapped alignments between stacks (default: enable gapped alignments).'
    inputBinding:
      position: 101
      prefix: --disable-gapped
  - id: dont_verify_haplotype
    type:
      - 'null'
      - boolean
    doc: don't verify haplotype of matching locus.
    inputBinding:
      position: 101
      prefix: -x
  - id: in_path
    type: Directory
    doc: path to the directory containing Stacks files.
    inputBinding:
      position: 101
      prefix: --in-path
  - id: popmap
    type: File
    doc: path to a population map file from which to take sample names.
    inputBinding:
      position: 101
      prefix: --popmap
  - id: sample
    type:
      type: array
      items: File
    doc: filename prefix from which to load sample loci.
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: enable parallel execution with n_threads threads.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_path
    type:
      - 'null'
      - Directory
    doc: output path to write results.
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
