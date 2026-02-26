cwlVersion: v1.2
class: CommandLineTool
baseCommand: catfasta2phyml.pl
label: catfasta2phyml
doc: "Concatenate fasta files to a phyml readable format\n\nTool homepage: https://github.com/nylander/catfasta2phyml"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta files
    inputBinding:
      position: 1
  - id: basename
    type: string
    doc: Ensure the basename is used as partition definition. If the provided 
      "suffix" (required) matches the file suffix, it will be removed from the 
      output string.
    inputBinding:
      position: 102
      prefix: --basename
  - id: concatenate
    type:
      - 'null'
      - boolean
    doc: Concatenate files even when number of taxa differ among alignments. 
      Missing data will be filled with all gap (-) sequences.
    inputBinding:
      position: 102
      prefix: --concatenate
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: Print output in FASTA format (default is PHYML format).
    inputBinding:
      position: 102
      prefix: --fasta
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: Concatenate sequences for sequence labels occuring in all input files 
      (intersection).
    inputBinding:
      position: 102
      prefix: --intersect
  - id: noprint
    type:
      - 'null'
      - boolean
    doc: Do not print the concatenation, just check if all files have the same 
      sequence lables and lengths. Program returns 1 on exit. See also the 
      combination with -v.
    inputBinding:
      position: 102
      prefix: --noprint
  - id: phylip_format
    type:
      - 'null'
      - boolean
    doc: Print output in a strict PHYLIP format. See 
      <http://evolution.genetics.washington.edu/phylip/doc/sequence.html>.
    inputBinding:
      position: 102
      prefix: --phylip
  - id: sequential_format
    type:
      - 'null'
      - boolean
    doc: Print output in sequential format (default is interleaved).
    inputBinding:
      position: 102
      prefix: --sequential
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose by showing some useful output. See the combination with -n.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catfasta2phyml:1.2.1--hdfd78af_0
stdout: catfasta2phyml.out
