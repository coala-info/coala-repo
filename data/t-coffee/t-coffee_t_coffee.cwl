cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - t_coffee
label: t-coffee_t_coffee
doc: "T-Coffee multiple sequence alignment: reads sequences, builds a library of
  pairwise alignments with the chosen methods and combines them into one alignment
  (default output: <name>.aln, <name>.dnd and <name>.html).\n\nTool homepage:
  https://github.com/cbcrg/tcoffee"
inputs:
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
    doc: List of sequences in any acceptable format
    inputBinding:
      position: 1
      prefix: -seq
  - id: infile
    type:
      - 'null'
      - File
    doc: Input a pre-computed alignment, or a file to reformat
    inputBinding:
      position: 3
      prefix: -infile
  - id: method
    type:
      - 'null'
      - type: array
        items: string
    doc: List of methods used to build the library (for example 
      clustalw_pair, lalign_id_pair, mafft_msa)
    inputBinding:
      position: 4
      prefix: -method
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Specifies a special mode: genome, quickaln, dali, 3dcoffee'
    inputBinding:
      position: 5
      prefix: -mode
  - id: type
    type:
      - 'null'
      - string
    doc: PROTEIN, DNA or RNA. Automatically set, but can be forced with this 
      flag
    inputBinding:
      position: 6
      prefix: -type
  - id: output
    type:
      - 'null'
      - type: array
        items: string
    doc: One or many output formats, for example clustalw_aln, fasta_aln, 
      msf_aln, score_ascii, html
    inputBinding:
      position: 7
      prefix: -output
      itemSeparator: ','
  - id: outfile
    type:
      - 'null'
      - string
    doc: Name of the output alignment
    inputBinding:
      position: 8
      prefix: -outfile
  - id: outorder
    type:
      - 'null'
      - string
    doc: 'Order of the sequences in the alignment: input or aligned'
    inputBinding:
      position: 9
      prefix: -outorder
  - id: newtree
    type:
      - 'null'
      - string
    doc: Name of the output guide tree
    inputBinding:
      position: 10
      prefix: -newtree
  - id: usetree
    type:
      - 'null'
      - File
    doc: Use an existing guide tree
    inputBinding:
      position: 11
      prefix: -usetree
  - id: case
    type:
      - 'null'
      - string
    doc: 'Case of the output residues: keep, lower or upper'
    inputBinding:
      position: 12
      prefix: -case
  - id: run_name
    type:
      - 'null'
      - string
    doc: Sets the prefix of all the output files
    inputBinding:
      position: 13
      prefix: -run_name
  - id: n_core
    type:
      - 'null'
      - int
    doc: Number of cores to be used by the machine
    inputBinding:
      position: 14
      prefix: -n_core
  - id: align
    type:
      - 'null'
      - boolean
    doc: Forces the program to make the alignment
    inputBinding:
      position: 15
      prefix: -align
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Forces the program to make a conversion
    inputBinding:
      position: 16
      prefix: -convert
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: Evaluate an existing alignment (use with -infile)
    inputBinding:
      position: 17
      prefix: -evaluate
  - id: quiet
    type:
      - 'null'
      - string
    doc: Defines the file in which the log output is written
    inputBinding:
      position: 18
      prefix: -quiet
  - id: type_only
    type:
      - 'null'
      - boolean
    doc: Exit after checking the type and returning it to the stdout
    inputBinding:
      position: 19
      prefix: -type_only
outputs:
  - id: alignment_files
    type:
      type: array
      items: File
    doc: Alignment, guide tree and report files written by t_coffee
    outputBinding:
      glob:
        - '*.aln'
        - '*.dnd'
        - '*.html'
        - '*.msf'
        - '*_aln'
        - '*.score_ascii'
        - '*.sp_ascii'
        - '*.phylip'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TMP_4_TCOFFEE
        envValue: /tmp
      - envName: LOCKDIR_4_TCOFFEE
        envValue: /tmp
      - envName: CACHE_4_TCOFFEE
        envValue: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
stdout: t-coffee_t_coffee.out
