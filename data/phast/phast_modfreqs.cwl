cwlVersion: v1.2
class: CommandLineTool
baseCommand: modFreqs
label: phast_modfreqs
doc: "Change background frequencies of reversible tree model in such a way that reversibility
  is maintained.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: tree_mod
    type: File
    doc: Reversible tree model (.mod format).
    inputBinding:
      position: 1
  - id: freqs
    type:
      type: array
      items: float
    doc: New background frequencies, either four values (A C G T) or one value (G+C
      frequency).
    inputBinding:
      position: 2
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the new model file (standard output).
    default: new.mod
outputs:
  - id: new_mod
    type: File
    doc: Tree model with the new background frequencies.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
