cwlVersion: v1.2
class: CommandLineTool
baseCommand: dreme
label: meme_dreme
doc: "Finds discriminative regular expressions in two sets of DNA sequences. It can
  also find motifs in a single set of DNA sequences, in which case it uses a dinucleotide
  shuffled version of the first set of sequences as the second set.\n\nTool homepage:
  https://meme-suite.org"
inputs:
  - id: alphabet_file
    type:
      - 'null'
      - File
    doc: use custom alphabet (some restrictions apply - see manual)
    inputBinding:
      position: 101
      prefix: -alph
  - id: description_file
    type:
      - 'null'
      - File
    doc: acts like -desc but reads the description from the specified file
    inputBinding:
      position: 101
      prefix: -dfile
  - id: description_text
    type:
      - 'null'
      - string
    doc: store the description in the output
    inputBinding:
      position: 101
      prefix: -desc
  - id: dna
    type:
      - 'null'
      - boolean
    doc: use the standard DNA alphabet; this is the default
    inputBinding:
      position: 101
      prefix: -dna
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: stop if motif E-value > <ethresh>
    inputBinding:
      position: 101
      prefix: -e
  - id: eps
    type:
      - 'null'
      - boolean
    doc: create EPS logos
    inputBinding:
      position: 101
      prefix: -eps
  - id: k_width
    type:
      - 'null'
      - int
    doc: sets mink=maxk=<k>
    inputBinding:
      position: 101
      prefix: -k
  - id: list_enrichment
    type:
      - 'null'
      - boolean
    doc: print list of enrichment of all REs tested
    inputBinding:
      position: 101
      prefix: -l
  - id: max_k
    type:
      - 'null'
      - int
    doc: maximum width of core motif
    inputBinding:
      position: 101
      prefix: -maxk
  - id: max_motifs
    type:
      - 'null'
      - int
    doc: 'stop if <m> motifs have been output; default: only stop at E-value threshold'
    inputBinding:
      position: 101
      prefix: -m
  - id: max_time
    type:
      - 'null'
      - int
    doc: 'stop if the specified time has elapsed (seconds); default: only stop at
      E-value threshold'
    inputBinding:
      position: 101
      prefix: -t
  - id: min_k
    type:
      - 'null'
      - int
    doc: minimum width of core motif
    inputBinding:
      position: 101
      prefix: -mink
  - id: negative_sequences
    type:
      - 'null'
      - File
    doc: 'negative sequence file name; default: the positive sequences are shuffled
      to create the negative set if -n is not used'
    inputBinding:
      position: 101
      prefix: -n
  - id: norc
    type:
      - 'null'
      - boolean
    doc: search given strand only for motifs (not reverse complement)
    inputBinding:
      position: 101
      prefix: -norc
  - id: num_gen
    type:
      - 'null'
      - int
    doc: number of REs to generalize
    inputBinding:
      position: 101
      prefix: -g
  - id: png
    type:
      - 'null'
      - boolean
    doc: create PNG logos
    inputBinding:
      position: 101
      prefix: -png
  - id: positive_sequences
    type: File
    doc: positive sequence file name
    inputBinding:
      position: 101
      prefix: -p
  - id: protein
    type:
      - 'null'
      - boolean
    doc: use the standard Protein alphabet (may not work well)
    inputBinding:
      position: 101
      prefix: -protein
  - id: rna
    type:
      - 'null'
      - boolean
    doc: use the standard RNA alphabet
    inputBinding:
      position: 101
      prefix: -rna
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for shuffling sequences; ignored if -n <filename> given
    inputBinding:
      position: 101
      prefix: -s
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 1..5 for varying degrees of extra output
    inputBinding:
      position: 101
      prefix: -verbosity
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: create the specified output directory and write all output to files in that
      directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_directory_overwrite
    type:
      - 'null'
      - Directory
    doc: 'create the specified output directory overwritting it if it already exists;
    outputBinding:
      glob: $(inputs.output_directory_overwrite)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
