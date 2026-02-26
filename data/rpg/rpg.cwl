cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpg
label: rpg
doc: "This software takes protein sequences as input (-i option). All sequences will
  be cleaved according to selected enzymes (-e option) and given miscleavage percentage
  (-m option). Cleaving can be sequential or concurrent (-d option). Resulting peptides
  are outputted in a file (-o option) in fasta, csv or tsv format (-f option). Classical
  enzymes are included (-l option to print available enzymes) but it is possible to
  define other enzymes (-a option). See https://gitlab.pasteur.fr/nmaillet/rpg/ and
  https://rapid-peptide- generator.readthedocs.io for more informations.\n\nTool homepage:
  https://github.com/jynew/jynew"
inputs:
  - id: add_enzyme
    type:
      - 'null'
      - boolean
    doc: Create a new enzyme. See https://rapid-peptide- 
      generator.readthedocs.io for more informations
    inputBinding:
      position: 101
      prefix: --addenzyme
  - id: digest
    type:
      - 'null'
      - string
    doc: "Digestion mode. Either 's', 'sequential', 'c' or 'concurrent' (default:
      s)"
    default: s
    inputBinding:
      position: 101
      prefix: --digest
  - id: enzymes
    type:
      - 'null'
      - type: array
        items: string
    doc: Id of enzyme(s) to use (i.e. -e 0 5 10 to use enzymes 0, 5 and 10). Use
      -l first to get enzyme ids
    inputBinding:
      position: 101
      prefix: --enzymes
  - id: input_data
    type:
      - 'null'
      - File
    doc: Input file, in fasta / fastq format
    inputBinding:
      position: 101
      prefix: --inputdata
  - id: list_enzymes
    type:
      - 'null'
      - boolean
    doc: Display the list of available enzymes
    inputBinding:
      position: 101
      prefix: --list
  - id: miscleavage
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Percentage of miscleavage, between 0 and 100, by enzyme(s). It should be
      in the same order than -enzymes options (i.e. -m 15 5 10). Only for sequential
      digestion (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --miscleavage
  - id: noninteractive
    type:
      - 'null'
      - boolean
    doc: Non-interactive mode. No standard output, only error(s) (--quiet 
      enable, overwrite -v). If output filename already exists, output file will
      be overwritten.
    inputBinding:
      position: 101
      prefix: --noninteractive
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output file format. Either 'fasta', 'csv', or 'tsv' (default: fasta)"
    default: fasta
    inputBinding:
      position: 101
      prefix: --fmt
  - id: pka
    type:
      - 'null'
      - string
    doc: "Define pKa values. Either 'ipc' or 'stryer' (default: ipc)"
    default: ipc
    inputBinding:
      position: 101
      prefix: --pka
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No standard output, only error(s)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: random_name
    type:
      - 'null'
      - boolean
    doc: Random (not used) output file name
    inputBinding:
      position: 101
      prefix: --randomname
  - id: sequence
    type:
      - 'null'
      - string
    doc: Input a single protein sequence without commentary
    inputBinding:
      position: 101
      prefix: --sequence
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity. -vv will increase more than -v
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Optional result file to output result peptides.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rpg:v1.1.0_cv1
