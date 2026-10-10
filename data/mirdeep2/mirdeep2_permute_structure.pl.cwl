cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - permute_structure.pl
label: mirdeep2_permute_structure.pl
doc: "Permute the order of the ids in an RNAfold output file\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_struct
    type: File
    doc: RNAfold output file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: RNAfold-style output with permuted structures
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: permuted_structure.str
