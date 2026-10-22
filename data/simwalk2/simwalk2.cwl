cwlVersion: v1.2
class: CommandLineTool
baseCommand: simwalk2
label: simwalk2
doc: "SimWalk2 is a statistical genetics application that uses Markov chain Monte
  Carlo and simulated annealing algorithms to analyze any size pedigrees. SimWalk2
  can perform haplotype, parametric linkage, non-parametric linkage (NPL), identity
  by descent (IBD), and mistyping analyses. The program takes no command line
  arguments: it reads the control file BATCH2.DAT from the current directory, and
  the pedigree, locus and map files named in it.\n\nTool homepage: http://www.genetics.ucla.edu/software/"
inputs:
  - id: control_file
    type: File
    doc: The input control data file which contains the instruction parameters
      to control this program. It is staged as BATCH2.DAT in the working directory.
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The pedigree, locus, map and other input files named in the control
      file. They are staged in the working directory under their own names.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result and log files written to the working directory (all upper-case names, for example ERROR-00.TXT, or the result files named in the control file)
    outputBinding:
      glob: ["*.TXT", "*.OUT"]
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: BATCH2.DAT
        entry: $(inputs.control_file)
      - $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simwalk2:2.91--h2761816_7
stdout: simwalk2.out
