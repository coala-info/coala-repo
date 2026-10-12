cwlVersion: v1.2
class: CommandLineTool
baseCommand: pamp
label: paml_pamp
doc: "PAMP does maximum-parsimony reconstruction of ancestral states, counts changes on a tree and fits a gamma distribution of rates among sites by parsimony. It reads a control file (default pamp.ctl) that names the sequence
  file, tree file and result file with relative paths.\n\nTool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Path to the control file (defaults to pamp.ctl in the working directory if not specified).
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the control file with relative paths (sequence file, tree file, other data files). Staged in the working directory.
  - id: outfile_name
    type:
      - 'null'
      - string
    doc: Name of the main result file set by 'outfile' in the control file. It is collected as a result.
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
        - 'rub'
        - 'rates'
        - 'lnf'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_pamp.out
