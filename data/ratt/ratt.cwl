cwlVersion: v1.2
class: CommandLineTool
baseCommand: ratt
label: ratt
doc: "A tool for transferring annotations between biological sequences.\n\nTool homepage:
  http://ratt.sourceforge.net"
inputs:
  - id: embl_directory
    type: Directory
    doc: This directory contains all the embl files that should be transfered to
      the query.
    inputBinding:
      position: 1
  - id: query_fasta
    type: File
    doc: A multifasta file to, which the annotation will be mapped.
    inputBinding:
      position: 2
  - id: reference_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: "Name of multi-fasta. VERY I M P O R T A N T The name of each\n         \
      \                             sequence in the fasta description,\n         \
      \                             MUST be the same name as its corresponding embl
      file. So if\n                                      your embl file is call Tuberculosis.embl,
      in your reference.fasta file, the description has to be:\n                 \
      \                        >Tuberculosis\n                                   \
      \      ATTGCGTACG\n                                         ..."
    inputBinding:
      position: 103
      prefix: --refseq
  - id: result_prefix
    type: string
    doc: The prefix you wish to give to each result file.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: transfer_type
    type: string
    doc: "Following parameters can be used (see below for the different used sets)\n\
      \       (i)   Assembly:                  Transfer between different assemblies.\n\
      \       (ii)  Assembly.Repetitive:       As before, but the genome is extremely
      repetitive.\n                                        This should be run, only
      if the parameter Assembly\n                                        doesn't return
      good results (misses too many annotation tags).\n       (iii) Strain:      \
      \              Transfer between strains. Similarity is between 95-99%.\n   \
      \    (iv)  Strain.Repetitive:         As before, but the genome is extremely
      repetitive.\n                                        This should be run, only
      if the parameter Strain doesn't\n                                        return
      good results (misses too many annotation tags).\n       (v)   Species:     \
      \              Transfer between species. Similarity is between 50-94%.\n   \
      \    (vi)  Species.Repetitive:        As before, but the genome is extremely
      repetitive.\n                                        This should be run, only
      if the parameter Species\n                                        doesn't return
      good results (misses too many annotation tags).\n       (vii) Multiple:    \
      \              When many annotated strains are used as a reference, and you\n\
      \                                        assume the newly sequenced genome has
      many insertions\n                                        compared to the strains
      in the query (reference?). This parameter will\n                           \
      \             use the best regions of each reference strain to transfer tags.\n\
      \       (viii)Free:                      The user sets all parameters individually."
    inputBinding:
      position: 103
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ratt:1.1.0--hdfd78af_0
stdout: ratt.out
