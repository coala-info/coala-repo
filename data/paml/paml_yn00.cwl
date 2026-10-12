cwlVersion: v1.2
class: CommandLineTool
baseCommand: yn00
label: paml_yn00
doc: "YN00 in paml version 4.10.10, 29 Jan 2026. Estimating synonymous and nonsynonymous
  substitution rates between two sequences.\n\nTool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Control file (usually yn00.ctl). If not provided, the program looks for yn00.ctl
      in the current directory.
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
        - '2YN.*'
        - '2YN.dN'
        - '2YN.dS'
        - '2YN.t'
        - 'yn'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_yn00.out
