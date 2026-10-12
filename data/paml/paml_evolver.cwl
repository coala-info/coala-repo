cwlVersion: v1.2
class: CommandLineTool
baseCommand: evolver
label: paml_evolver
doc: "A program from the PAML suite used for simulating DNA, codon, and amino acid
  sequences, as well as generating random trees and calculating tree distances.\n\n
  Tool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: choice
    type: int
    doc: 'The evolver option (1: random unrooted trees, 2: random rooted trees, 3: list
      all unrooted trees, 4: list all rooted trees, 5: simulate nucleotide data sets
      (MCbase.dat), 6: simulate codon data sets (MCcodon.dat), 7: simulate amino acid
      data sets (MCaa.dat), 8: identical bi-partitions between trees, 9: clade support
      values, 11: label clades)'
    inputBinding:
      position: 1
  - id: control_file
    type: File
    doc: The control file or data file for the chosen option (MCbase.dat for 5, MCcodon.dat
      for 6, MCaa.dat for 7, or a tree file for 8)
    inputBinding:
      position: 2
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the control file with relative paths (sequence file, tree file,
      substitution rate file such as jones.dat). Staged in the working directory.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Result files written by the program.
    outputBinding:
      glob:
        - 'evolver.out'
        - 'mc.paml'
        - 'mc.nex'
        - 'mc.txt'
        - 'ancestral.txt'
        - 'siterates.txt'
        - 'mc*.paml'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_evolver.out
