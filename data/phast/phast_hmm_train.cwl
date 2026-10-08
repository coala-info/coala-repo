cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmm_train
label: phast_hmm_train
doc: "Estimate the transition probabilities of an HMM, based on multiple alignments,
  sequence annotations, and a category map.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: msa_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of multiple sequence alignment files (-m). Currently, in testing mode,
      the list must be of length one. Required unless msa_lengths (-M) is given.
    inputBinding:
      position: 1
      prefix: -m
      itemSeparator: ','
  - id: category_map
    type: File
    doc: File defining mapping of feature types to category numbers.
    inputBinding:
      position: 1
      prefix: -c
  - id: gff_files
    type:
      type: array
      items: File
    doc: Files in GFF defining sequence features to be used in labeling sites. Must
      correspond in number and order to the alignment files.
    inputBinding:
      position: 1
      prefix: -g
      itemSeparator: ','
  - id: msa_lengths
    type:
      - 'null'
      - string
    doc: (Mutually exclusive with -m) Assume alignments of the specified lengths (comma-separated list) and do not map the coordinates in the GFFs.
    inputBinding:
      position: 1
      prefix: -M
  - id: msa_format
    type:
      - 'null'
      - string
    doc: "Alignment format: PHYLIP, FASTA, MPM or SS (default SS)."
    inputBinding:
      position: 1
      prefix: -i
  - id: reverse_compl_tag
    type:
      - 'null'
      - string
    doc: Group features by this tag (e.g. transcript_id) and reverse complement segments on the reverse strand.
    inputBinding:
      position: 1
      prefix: -R
  - id: indel_cats
    type:
      - 'null'
      - string
    doc: Model indels for the specified categories.
    inputBinding:
      position: 1
      prefix: -I
  - id: tree
    type:
      - 'null'
      - File
    doc: Use the specified tree topology when training for indels.
    inputBinding:
      position: 1
      prefix: -t
  - id: nseqs
    type:
      - 'null'
      - int
    doc: Train an indel model for this number of sequences.
    inputBinding:
      position: 1
      prefix: -n
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Proceed quietly (without updates to stderr).
    inputBinding:
      position: 1
      prefix: -q
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the output HMM file (standard output).
    default: out.hmm
outputs:
  - id: hmm
    type: File
    doc: Trained HMM.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
