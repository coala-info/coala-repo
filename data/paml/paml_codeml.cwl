cwlVersion: v1.2
class: CommandLineTool
baseCommand: codeml
label: paml_codeml
doc: "codeml is a program in the PAML (Phylogenetic Analysis by Maximum Likelihood)
  package that analyzes DNA or protein sequences using maximum likelihood.\n\nTool
  homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Path to the control file (typically codeml.ctl). If not provided, the program
      looks for 'codeml.ctl' in the current directory.
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the control file with relative paths (sequence file, tree file,
      substitution rate file such as jones.dat). Staged in the working directory.
  - id: outfile_name
    type:
      - 'null'
      - string
    doc: Name of the main result file set by 'outfile' in the control file. It is
      collected as a result.
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
        - '$(inputs.outfile_name)'
        - 'rst'
        - 'rst1'
        - 'rub'
        - 'rates'
        - 'lnf'
        - '2NG.*'
        - '2ML.*'
        - '4fold.nuc'
        - 'mlc'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_codeml.out
