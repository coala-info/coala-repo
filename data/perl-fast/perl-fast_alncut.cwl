cwlVersion: v1.2
class: CommandLineTool
baseCommand: alncut
label: perl-fast_alncut
doc: "Select sites (columns) of a multiple sequence alignment by criteria such as gap content, parsimony informativeness or minor variant frequency.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type: File
    doc: Input alignment in multi-FASTA format (read from standard input)
  - id: gapfree
    type:
      - 'null'
      - boolean
    doc: Print only sites that contain no gaps
    inputBinding:
      position: 102
      prefix: --gapfree
  - id: allgap
    type:
      - 'null'
      - boolean
    doc: Print only sites that contain exclusively gaps
    inputBinding:
      position: 102
      prefix: --allgap
  - id: parsinf
    type:
      - 'null'
      - boolean
    doc: Print only sites that are parsimoniously informative
    inputBinding:
      position: 102
      prefix: --parsinf
  - id: negate
    type:
      - 'null'
      - boolean
    doc: Print set-complement of sites otherwise selected; as a sole option, will print only variable sites
    inputBinding:
      position: 102
      prefix: --negate
  - id: frequency
    type:
      - 'null'
      - float
    doc: Print sites that contain gaps or minor variants up to a maximum of this many sequences (integer) or this relative frequency (float between 0 and 1)
    inputBinding:
      position: 102
      prefix: --frequency
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print numbers and indices of sites selected by the criteria to standard error
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 102
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    inputBinding:
      position: 102
      prefix: --logname
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 102
      prefix: --comment
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for fasconvert for allowed formats.
    inputBinding:
      position: 102
      prefix: --format
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 102
      prefix: --moltype
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_alncut.out
stdin: $(inputs.multifasta_file.path)
