cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perform_controls.pl
label: mirdeep2_perform_controls.pl
doc: "Run the miRDeep2 core algorithm command line repeatedly on permuted RNAfold structures to estimate false positives\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_command_line
    type: File
    doc: File whose first line is the command line to run on the structure file (e.g. miRDeep2_core_algorithm.pl signature.arf precursors.str -s mature.fa -v -50 > output.mrd); the file names in it must be the base names of the staged files
    inputBinding:
      position: 1
  - id: file_structure
    type: File
    doc: RNAfold structure file named in the command line; it is staged in the working directory and passed by base name
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: rounds_controls
    type: int
    doc: Number of permutation rounds
    inputBinding:
      position: 3
  - id: command_files
    type: File[]
    doc: Other files named in the command line (e.g. signature and mature miRNA files); staged in the working directory by base name
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress to standard error
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Output of the command line for each permutation round
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.command_files.concat([inputs.file_structure]))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: output_permuted.mrd
