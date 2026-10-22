cwlVersion: v1.2
class: CommandLineTool
baseCommand: phasedstacks
label: stacks_phasedstacks
doc: "Calculate D' statistics and haplotype blocks from phased Stacks data (fastPHASE or Beagle output).

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: batch_id
    type: int
    doc: "Stacks batch ID"
    inputBinding:
      position: 101
      prefix: -b
  - id: phased_path
    type: Directory
    doc: "path to the phased output files"
    inputBinding:
      position: 101
      prefix: -P
  - id: stacks_path
    type: Directory
    doc: "path to the Stacks output files"
    inputBinding:
      position: 101
      prefix: -S
  - id: file_type
    type: string
    doc: "input file type. Supported types: fastphase, and beagle"
    inputBinding:
      position: 101
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of processes to run in parallel sections of code"
    inputBinding:
      position: 101
      prefix: -p
  - id: popmap
    type:
      - 'null'
      - File
    doc: "path to the population map, a tab separated file describing which individuals belong in which population"
    inputBinding:
      position: 101
      prefix: -M
  - id: haplotypes
    type:
      - 'null'
      - boolean
    doc: "data were phased as RAD locus haplotypes"
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: dprime_bin_size
    type:
      - 'null'
      - int
    doc: "size of buckets for binning SNPs at a particular distance to calculate the mean D' value"
    inputBinding:
      position: 101
      prefix: --dprime-bin-size
  - id: dprime_threshold
    type:
      - 'null'
      - float
    doc: "if D' values fall above <val>, set the D' to 1, otherwise set D' to 0"
    inputBinding:
      position: 101
      prefix: --dprime-threshold
  - id: skip_zeros
    type:
      - 'null'
      - boolean
    doc: "do not include D' values of zero in the D' output"
    inputBinding:
      position: 101
      prefix: --skip-zeros
  - id: minor_allele_freq
    type:
      - 'null'
      - float
    doc: "specify a minimum minor allele frequency required to process a nucleotide site (0 < a < 0.5)"
    inputBinding:
      position: 101
      prefix: --minor-allele-freq
  - id: min_inform_pairs
    type:
      - 'null'
      - float
    doc: "when building D' haplotype blocks, the minimum number of informative D' measures to combine two blocks (default 0.9)"
    inputBinding:
      position: 101
      prefix: --min-inform-pairs
outputs:
  - id: stacks_dir_out
    type: Directory
    doc: Stacks directory with the D' output files
    outputBinding:
      glob: $(inputs.stacks_path.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.stacks_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_phasedstacks.out
