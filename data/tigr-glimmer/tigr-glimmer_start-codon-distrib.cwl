cwlVersion: v1.2
class: CommandLineTool
baseCommand: start-codon-distrib
label: tigr-glimmer_start-codon-distrib
doc: "Read fasta-format <sequence-file> and count the number of different start codons
  for the genes specified in <coords>. By default, <coords> is the name of a file
  containing lines of the form <tag> <start> <stop> [<frame>] ... Coordinates are
  inclusive counting from 1, e.g., \"1 3\" represents the 1st 3 characters of the
  sequence. Output goes to stdout.\n\nTool homepage: https://github.com/alexdobin/STAR"
inputs:
  - id: sequence_file
    type: File
    doc: Fasta-format sequence file
    inputBinding:
      position: 1
  - id: coords
    type: File
    doc: File containing gene coordinates
    inputBinding:
      position: 2
  - id: direction
    type:
      - 'null'
      - boolean
    doc: Use the 4th column of each input line to specify the direction of the 
      sequence. Positive is forward, negative is reverse. The input sequence is 
      assumed to be circular
    inputBinding:
      position: 103
      prefix: --dir
  - id: nowrap
    type:
      - 'null'
      - boolean
    doc: Use the actual input coordinates without any wraparound that would be 
      needed by a circular genome. Without this option, the output sequence is 
      the shorter of the two ways around the circle. Use the -d option to 
      specify direction explicitly.
    inputBinding:
      position: 103
      prefix: --nowrap
  - id: three_comma
    type:
      - 'null'
      - boolean
    doc: output only a comma separated list (no spaces) of atg, gtg, ttg start 
      proportions, in that order
    inputBinding:
      position: 103
      prefix: --3comma
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_start-codon-distrib.out
