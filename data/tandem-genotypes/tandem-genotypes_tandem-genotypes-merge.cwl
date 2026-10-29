cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-merge
label: tandem-genotypes_tandem-genotypes-merge
doc: "Merge the DNA reads of each tandem-repeat allele into a consensus sequence.\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs:
  - id: seqs_file
    type: File
    doc: seqs.fx, the DNA reads (FASTA or FASTQ)
    inputBinding:
      position: 1
  - id: last_train_file
    type:
      - 'null'
      - File
    doc: last-train.out, alignment parameters from last-train (omit to print unmerged sequences)
    inputBinding:
      position: 2
  - id: genotypes_file
    type: File
    doc: tan-gen.txt, output of tandem-genotypes
    inputBinding:
      position: 3
  - id: num
    type:
      - 'null'
      - int
    doc: get the top NUM repeats
    inputBinding:
      position: 101
      prefix: --num
  - id: gap_max
    type:
      - 'null'
      - int
    doc: use alignment columns with <= G% gaps
    inputBinding:
      position: 101
      prefix: --gap-max
  - id: end
    type:
      - 'null'
      - boolean
    doc: "... including gaps past the ends of the sequences"
    inputBinding:
      position: 101
      prefix: --end
  - id: seq_min
    type:
      - 'null'
      - int
    doc: omit consensus flanks with < S sequences
    inputBinding:
      position: 101
      prefix: --seq-min
  - id: prob
    type:
      - 'null'
      - float
    doc: use pairwise restrictions with error probability <= P
    inputBinding:
      position: 101
      prefix: --prob
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads (LAST option)
    inputBinding:
      position: 101
      prefix: -P
  - id: window
    type:
      - 'null'
      - int
    doc: use minimum positions in length-W windows (LAST option)
    inputBinding:
      position: 101
      prefix: -W
  - id: max_initial_matches
    type:
      - 'null'
      - int
    doc: max initial matches per query position (LAST option)
    inputBinding:
      position: 101
      prefix: -m
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: max gap length (LAST option)
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes-merge.out
