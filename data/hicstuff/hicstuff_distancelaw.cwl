cwlVersion: v1.2
class: CommandLineTool
baseCommand: distancelaw
label: hicstuff_distancelaw
doc: "Take the distance law file from hicstuff and can average it, normalize it compute
  the\n    slope of the curve and plot it.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: average
    type:
      - 'null'
      - boolean
    doc: "If set, calculate the average of the distance\n                        \
      \                    law of the different chromosomes/arms in each\n       \
      \                                     condition. If two file given average is\n\
      \                                            mandatory."
    inputBinding:
      position: 101
      prefix: --average
  - id: base
    type:
      - 'null'
      - float
    doc: "Float corresponding of the base of the log to\n                        \
      \                    make the logspace which will slice the genomes\n      \
      \                                      in logbins. These slices will be in basepairs\n\
      \                                            unit."
    inputBinding:
      position: 101
      prefix: --base
  - id: big_arm_only
    type:
      - 'null'
      - int
    doc: "Integer. It given will take only the arms bigger\n                     \
      \                       than the value given as argument."
    inputBinding:
      position: 101
      prefix: --big-arm-only
  - id: centromeres
    type:
      - 'null'
      - File
    doc: "Positions of the centromeres separated by\n                            \
      \                a space and in the same order as the\n                    \
      \                        chromosomes. This allows to plot chromosomal arms\n\
      \                                            separately. Note this will only
      work with --pairs\n                                            input, as the
      distance law needs to be recomputed.\n                                     \
      \       Incompatible with the circular option."
    inputBinding:
      position: 101
      prefix: --centromeres
  - id: circular
    type:
      - 'null'
      - boolean
    doc: "Enable if the genome is circular. Discordant\n                         \
      \                   with the centromeres option."
    inputBinding:
      position: 101
      prefix: --circular
  - id: dist_tbl
    type:
      - 'null'
      - type: array
        items: File
    doc: "Directory to the file or files containing the\n                        \
      \                    compute distance law. File should have the same\n     \
      \                                       format than the ones made by hicstuff
      pipeline."
    inputBinding:
      position: 101
      prefix: --dist-tbl
  - id: frags
    type:
      - 'null'
      - File
    doc: "Tab-separated file with headers, containing\n                          \
      \                  columns id, chrom, start_pos, end_pos size.\n           \
      \                                 This is the file \"fragments_list.txt\" generated
      by\n                                            hicstuff pipeline. Required
      if pairs are given."
    inputBinding:
      position: 101
      prefix: --frags
  - id: inf
    type:
      - 'null'
      - int
    doc: "Inferior born to plot the distance law. By\n                           \
      \                 default the value is 3000 bp (3 kb). Have to\n           \
      \                                 be strictly positive."
    inputBinding:
      position: 101
      prefix: --inf
  - id: labels
    type:
      - 'null'
      - Directory
    doc: "List of string of the labels for the plot\n                            \
      \                separated by a coma. If no labels given, give\n           \
      \                                 the names \"Sample 1\", \"Sample 2\"..."
    inputBinding:
      position: 101
      prefix: --labels
  - id: pairs
    type:
      - 'null'
      - File
    doc: "Pairs file. Format from 4D Nucleome Omics Data\n                       \
      \                     Standards Working Group with the 8th and 9th\n       \
      \                                     coulumns are the ID of the fragments of
      the\n                                            reads 1 and 2. Only add if
      no distance_law table\n                                            given. It
      will compute the table from these pairs\n                                  \
      \          and the fragments from the fragments file."
    inputBinding:
      position: 101
      prefix: --pairs
  - id: remove_centromeres
    type:
      - 'null'
      - int
    doc: "Integer. Number of kb that will be remove around\n                     \
      \                       the centromere position given by in the centromere\n\
      \                                            file. [default: 0]"
    inputBinding:
      position: 101
      prefix: --remove-centromeres
  - id: sup
    type:
      - 'null'
      - int
    doc: "Superior born to plot the distance law. By\n                           \
      \                 default the value is the maximum length of all\n         \
      \                                   the dataset given. Also if big arm only
      set, it\n                                            will be the minimum size
      of the arms/chromosomes\n                                            taken to
      make the average."
    inputBinding:
      position: 101
      prefix: --sup
outputs:
  - id: outputfile_img
    type:
      - 'null'
      - File
    doc: "Output file. Format must be compatible with\n                          \
      \                  plt.savefig. Default : None."
    outputBinding:
      glob: $(inputs.outputfile_img)
  - id: outputfile_tabl
    type:
      - 'null'
      - File
    doc: 'Output file. Default : None.'
    outputBinding:
      glob: $(inputs.outputfile_tabl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
