cwlVersion: v1.2
class: CommandLineTool
baseCommand: [gen_scheme]
label: mrtrix3_gen_scheme
doc: |-
  Generate a diffusion gradient table (dw_scheme.txt) with optimally distributed directions for given shells.

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: gen_scheme_shell
        type: record
        fields:
          - name: bvalue
            type: int
            doc: the b-value of the shell
            inputBinding:
              position: 1
          - name: ndir
            type: int
            doc: the number of directions to include in the shell
            inputBinding:
              position: 2
inputs:
  - id: num_pe
    type: int
    doc: the number of phase-encoding directions to be included in the scheme (1, 2 or 4).
    inputBinding:
      position: 1
  - id: shells
    type:
      type: array
      items: gen_scheme_shell
    doc: b-value and number of directions for each shell.
    inputBinding:
      position: 2
outputs:
  - id: dw_scheme
    type: File
    doc: 'The generated gradient table: one line per volume with columns x y z b PE.'
    outputBinding:
      glob: dw_scheme.txt
  - id: stdout_out
    type: stdout
    doc: Text printed by the command.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: gen_scheme_stdout.txt
