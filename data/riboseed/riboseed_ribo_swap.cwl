cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - swap
label: riboseed_ribo_swap
doc: "Given de novo and de fere novo contig files, a misjoined de fere novo contig name, and a colon:separated list of de novo contig names, replace the offending contig with the de novo contig(s).\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: de_novo_file
    type: File
    doc: "multifasta containing de novo contigs"
    inputBinding:
      position: 1
  - id: de_fere_novo_file
    type: File
    doc: "multifasta containing de fere novo contigs"
    inputBinding:
      position: 2
  - id: bad_contig
    type: string
    doc: "name of the bad contig"
    inputBinding:
      position: 3
  - id: good_contigs
    type: string
    doc: "colon separated good contigs for replacement"
    inputBinding:
      position: 4
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_swap.out
