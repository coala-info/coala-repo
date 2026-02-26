cwlVersion: v1.2
class: CommandLineTool
baseCommand: cawlign
label: cawlign
doc: "perform a pairwise alignment between a reference sequence and a set of other
  sequences\n\nTool homepage: https://github.com/veg/cawlign"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: read sequences to compare from this file (default=stdin)
    inputBinding:
      position: 1
  - id: datatype
    type:
      - 'null'
      - string
    doc: "datatype (default=nucleotide)\n                           nucleotide : align
      sequences in the nucleotide space;\n                           protein    :
      align sequences in the protein space;\n                           codon: align
      sequences in the codon space (reference must be in frame; stop codons are defined
      in the scoring file);"
    default: nucleotide
    inputBinding:
      position: 102
      prefix: -t
  - id: format
    type:
      - 'null'
      - string
    doc: "controls the format of the output (default=refmap)\n                   \
      \        refmap   : aligns query sequences to the reference and does NOT retain
      instertions relative to the reference;\n                           refalign
      : aligns query sequences to the reference and DOES retain instertions relative
      to the reference;\n                                      no MSA is generated,
      but rather individual alignments to reference with likely different lengths
      are reported ;\n                           pairwise : aligns query sequences
      to the reference and DOES retain instertions relative to the reference;\n  \
      \                                    no MSA is generated, but rather pair-wise
      alignments are all reported (2x the number of sequences);"
    default: refmap
    inputBinding:
      position: 102
      prefix: -f
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: genetic code identifier (NCBI code like 1, 2, 4, or a name like 
      standard);
    inputBinding:
      position: 102
      prefix: -c
  - id: local_alignment
    type:
      - 'null'
      - string
    doc: "global/local alignment (default=trim)\n                           global
      : full string alignment; all gaps in the alignments are scored the same\n  \
      \                         local  : partial string local (smith-waterman type)
      alignment which maximizes the alignment score"
    default: trim
    inputBinding:
      position: 102
      prefix: -l
  - id: no_affine_gap_scoring
    type:
      - 'null'
      - boolean
    doc: do NOT use affine gap scoring (use by default)
    inputBinding:
      position: 102
      prefix: -a
  - id: reference
    type:
      - 'null'
      - File
    doc: "read the reference sequence from this file (default=\"HXB2_pol\")\n    \
      \                       first checks to see if the filepath exists, if not looks
      inside the res/references directory\n                           relative to
      the install path (/usr/local/share/cawlign by default).\n                  \
      \         If not a file, it is treated as a literal sequence."
    inputBinding:
      position: 102
      prefix: -r
  - id: reverse_complement
    type:
      - 'null'
      - string
    doc: "options of reverse complementation [rc] (default=none)\n               \
      \            none       : do not consider reverse complements of sequences;\n\
      \                           silent     : align both the sequence and its rc
      to the reference, select the one with the highest score and report it;\n   \
      \                        annotated  : align both the sequence and its rc to
      the reference, select the one with the highest score and report it\n       \
      \                                 annotate sequences whose reverse complements
      were reported in the FASTA by appending '|RC' to the sequence name;"
    default: none
    inputBinding:
      position: 102
      prefix: -R
  - id: score
    type:
      - 'null'
      - File
    doc: "read the scoring matrices and options from this file (default=\"Nucleotide-BLAST\"\
      )\n                           first checks to see if the filepath exists, if
      not looks inside the res/scoring directory\n                           relative
      to the install path (/usr/local/share/cawlign by default)\n                \
      \           see INSERT URL later for how to read and create alignment scoring
      files"
    inputBinding:
      position: 102
      prefix: -s
  - id: space
    type:
      - 'null'
      - string
    doc: "which version of the algorithm to use (an integer >0, default=quadratic):\n\
      \                           quadratic : build the entire dynamic programming
      matrix (NxM);\n                           linear    : use the divide and conquer
      recursion to keep only 6 columns in memory (~ max (N,M));\n                \
      \                       NOT IMPLEMENTED FOR CODON DATA"
    default: quadratic
    inputBinding:
      position: 102
      prefix: -S
  - id: write_reference
    type:
      - 'null'
      - boolean
    doc: write out the reference sequence for refmap and refalign output options
      (default = no)
    inputBinding:
      position: 102
      prefix: -I
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: direct the output to a file named OUTPUT (default=stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cawlign:0.1.16--he91c24d_0
