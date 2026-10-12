cwlVersion: v1.2
class: CommandLineTool
baseCommand: packmol
arguments:
  - position: 1
    shellQuote: false
    valueFrom: "< $(inputs.input_file.path)"
label: packmol
doc: "Packing optimization for the automated generation of starting configurations
  for molecular dynamics simulations. Packmol 18 reads the packing instructions from
  standard input; the structure files named in the input must be given in
  structure_files and referenced by file name only.\n\nTool homepage: https://github.com/m3g/packmol"
inputs:
  - id: input_file
    type: File
    doc: Input file containing the packing instructions (read from standard input)
  - id: structure_files
    type:
      type: array
      items: File
    doc: Molecule structure files (pdb, xyz, tinker, moldy) named in the input file
  - id: output_name
    type: string
    doc: Name of the packed output file, as set by the `output` keyword of the input file
outputs:
  - id: stdout
    type: stdout
    doc: Packmol log
  - id: packed_structure
    type: File
    doc: Packed structure written by Packmol
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.structure_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/packmol:18.169
stdout: packmol.out
