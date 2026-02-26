cwlVersion: v1.2
class: CommandLineTool
baseCommand: structureHarvester.py
label: structureharvester_structureHarvester.py
doc: "Takes a STRUCTURE results directory (--dir) and an output directory (--out will
  be created if it does not exist) and then depending on the other options selected
  harvests data from the results directory and performs the selected analyses\n\n\
  Tool homepage: http://alumni.soe.ucsc.edu/~dearl/software/structureHarvester/"
inputs:
  - id: clumpp
    type:
      - 'null'
      - boolean
    doc: Generates one K*.indfile for each value of K run, for use with CLUMPP.
    default: false
    inputBinding:
      position: 101
      prefix: --clumpp
  - id: dir
    type: Directory
    doc: The structure Results/ directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: evanno
    type:
      - 'null'
      - boolean
    doc: If possible, performs the Evanno 2005 method. Written to evanno.txt.
    default: false
    inputBinding:
      position: 101
      prefix: --evanno
outputs:
  - id: out
    type: Directory
    doc: The out directory. If it does not exist, it will be created. Output 
      written to summary.txt
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/structureharvester:0.6.94--py27_0
