cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelible
label: indelible
doc: "INDELible V1.03 by Will Fletcher: simulation of nucleotide, amino-acid and
  codon sequence evolution along a tree with insertions and deletions. The program
  always reads the control file named control.txt in the working directory, so the
  control file input is staged under that name.\n\nTool homepage:
  http://abacus.gene.ucl.ac.uk/software/indelible/"
inputs:
  - id: control_file
    type: File
    doc: Control file for INDELible (staged as control.txt in the working directory)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: Simulated alignments, true alignments, tree and log files written by
      INDELible
    outputBinding:
      glob:
        - '*.fas'
        - '*.fasta'
        - '*.phy'
        - '*.phylip'
        - '*.nex'
        - '*.paml'
        - '*.txt'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: control.txt
        entry: $(inputs.control_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/indelible:v1.03-4-deb_cv1
stdout: indelible.out
