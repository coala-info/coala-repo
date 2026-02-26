cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare-out-to-gff.prl
label: repeatscout_compare-out-to-gff.prl
doc: "Compares RepeatMasker output to a set of GFF feature files.\n\nTool homepage:
  https://github.com/Dfam-consortium/RepeatScout"
inputs:
  - id: calculate_by_instances
    type:
      - 'null'
      - boolean
    doc: 'Determines how the overlap calculation is done. If this is not specified,
      the overlap is calculated by bases: if 40 bases of a repeat element overlaps
      a feature in one of the GFF files, it is counted as 40 bases. The sum is taken
      over all features and all repeats of a given type and divided by the total length
      of the repeat. If --instances is specified, the "overlap" is considered to be
      the number of instances of a given type that overlap any feature, divided by
      the total number of instances of that type.'
    inputBinding:
      position: 101
      prefix: --instances
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: A fasta formatted file. If this is given, then sequences that are under
      (over) the overlap threshold will be in the output. This is a sequence 
      filter.
    inputBinding:
      position: 101
      prefix: --f
  - id: gff_files
    type:
      type: array
      items: File
    doc: A GFF-formatted file of features. More than one file may be specified 
      with multiple --gff options.
    inputBinding:
      position: 101
      prefix: --gff
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: The maximum (minimum) amount of overlap tolerated by any one type of 
      repeat.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: overlap_type
    type:
      - 'null'
      - boolean
    doc: Determines if the threshold is a minimum or a maximum (defaults to 
      maximum; including --over makes it a minimum)
    inputBinding:
      position: 101
      prefix: --over
  - id: repeatmasker_instances
    type: string
    doc: RepeatMasker instances in either .cat format or .out format (prefer 
      .out)
    inputBinding:
      position: 101
      prefix: --cat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_compare-out-to-gff.prl.out
