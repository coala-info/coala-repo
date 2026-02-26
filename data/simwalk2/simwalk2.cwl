cwlVersion: v1.2
class: CommandLineTool
baseCommand: simwalk2
label: simwalk2
doc: "SimWalk2 is a statistical genetics application that uses Markov chain Monte
  Carlo and simulated annealing algorithms to analyze any size pedigrees. SimWalk2
  can perform haplotype, parametric linkage, non-parametric linkage (NPL), identity
  by descent (IBD), and mistyping analyses.\n\nTool homepage: http://www.genetics.ucla.edu/software/"
inputs:
  - id: control_file
    type: File
    doc: The input control data file which contains the instruction parameters 
      to control this program.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simwalk2:2.91--h2761816_7
stdout: simwalk2.out
