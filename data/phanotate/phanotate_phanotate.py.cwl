cwlVersion: v1.2
class: CommandLineTool
baseCommand: phanotate.py
label: phanotate_phanotate.py
doc: "PHANOTATE: A phage genome annotator. It identifies genes in phage genomes
  with a weighted graph and a shortest-path search.\n\nTool homepage:
  https://github.com/deprekate/PHANOTATE"
inputs:
  - id: infile
    type: File
    doc: input file in fasta format
    inputBinding:
      position: 100
  - id: outfile
    type:
      - 'null'
      - string
    doc: where to write the output [stdout]
    inputBinding:
      position: 1
      prefix: --outfile
  - id: format
    type:
      - 'null'
      - string
    doc: Output the features in the specified format (genbank, gff, gff3,
      tabular, fasta, fna, faa) [tabular]
    inputBinding:
      position: 2
      prefix: --format
  - id: start_codons
    type:
      - 'null'
      - string
    doc: comma separated list of start codons and frequency
      [atg:0.85,gtg:0.10,ttg:0.05]
    inputBinding:
      position: 3
      prefix: --start_codons
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: comma separated list of stop codons [tag,tga,taa]
    inputBinding:
      position: 4
      prefix: --stop_codons
  - id: min_orf_len
    type:
      - 'null'
      - int
    doc: minimum ORF length to store
    inputBinding:
      position: 5
      prefix: --minlen
  - id: dump
    type:
      - 'null'
      - boolean
    doc: dump the graph (option -d, --dump)
    inputBinding:
      position: 6
      prefix: --dump
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the predictions when --outfile is not given)
  - id: output
    type:
      - 'null'
      - File
    doc: Output file written with --outfile
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1
stdout: phanotate_phanotate.py.out
