cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxseqgen]
label: phyx_pxseqgen
doc: |-
  Basic sequence simulator under the GTR model.
  This will take a newick- or nexus-formatted tree from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: out_file_path
    type: ['null', string]
    doc: "output seq file name (standard output otherwise)"
    inputBinding:
      prefix: -o
  - id: length
    type: ['null', int]
    doc: "length of sequences to generate. default is 1000"
    inputBinding:
      prefix: -l
  - id: basef
    type: ['null', string]
    doc: "comma-delimited base freqs in order: A,C,G,T. default is equal"
    inputBinding:
      prefix: -b
  - id: gamma
    type: ['null', float]
    doc: "gamma shape value. default is no rate variation"
    inputBinding:
      prefix: -g
  - id: pinvar
    type: ['null', float]
    doc: "proportion of invariable sites. default is 0.0"
    inputBinding:
      prefix: -i
  - id: ratemat
    type: ['null', string]
    doc: "comma-delimited input values for rate matrix. default is JC69; order: A<->C,A<->G,A<->T,C<->G,C<->T,G<->T"
    inputBinding:
      prefix: -r
  - id: aaratemat
    type: ['null', string]
    doc: "comma-delimited amino acid rate matrix. default is all freqs equal; order is ARNDCQEGHILKMFPSTWYV"
    inputBinding:
      prefix: -w
  - id: aabasefreq
    type: ['null', string]
    doc: "AA frequencies, order: ARNDCQEGHILKMFPSTWYV"
    inputBinding:
      prefix: -q
  - id: protein
    type: ['null', boolean]
    doc: "run as amino acid"
    inputBinding:
      prefix: -c
  - id: nreps
    type: ['null', int]
    doc: "number of replicates (accepted but not implemented in phyx 1.1: one replicate is always written)"
    inputBinding:
      prefix: -n
  - id: seed
    type: ['null', int]
    doc: "random number seed, clock otherwise"
    inputBinding:
      prefix: -x
  - id: ancestors
    type: ['null', boolean]
    doc: "print the ancestral node sequences. default is no; use printnodelabels for the nodes labels"
    inputBinding:
      prefix: -a
  - id: printnodelabels
    type: ['null', boolean]
    doc: "print newick with internal node labels. default is no"
    inputBinding:
      prefix: -p
  - id: multimodel
    type: ['null', string]
    doc: "specify multiple models across tree; input is A<->C,A<->G,A<->T,C<->G,C<->T,G<->T,Node#,A<->C,A<->G,A<->T,C<->G,C<->T,G<->T (EX: .3,.3,.3,.3,.3,1,.3,.3,.2,.5,.4)"
    inputBinding:
      prefix: -m
  - id: rootseq
    type: ['null', string]
    doc: "set root sequence. default is random (from basefreqs)"
    inputBinding:
      prefix: -k
outputs:
  - id: out_file
    type: ['null', File]
    doc: "simulated sequences (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: stdout_text
    type: stdout
    doc: "standard output (the labelled tree when printnodelabels is set)"
stdout: pxseqgen.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
