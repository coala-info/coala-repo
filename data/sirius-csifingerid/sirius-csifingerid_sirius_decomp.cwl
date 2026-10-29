cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
- decomp
label: sirius-csifingerid_sirius_decomp
doc: 'Small tool to decompose masses with given deviation, ionization, chemical alphabet
  and chemical filter.


  Tool homepage: https://bio.informatik.uni-jena.de/software/sirius/'
inputs:
- id: abs
  type:
  - 'null'
  - double
  doc: Absolute mass error in Dalton.
  inputBinding:
    position: 1
    prefix: --abs
- id: max_decomps
  type:
  - 'null'
  - int
  doc: Maximum number of decompositions to be computed. The output might contain less
    than [--max-decomps] decompositions if there are not more available.
  inputBinding:
    position: 2
    prefix: --max-decomps
- id: elements
  type:
  - 'null'
  - string
  doc: 'Elements which should be used in decomposition. Example: ''CH[min-max]N[min-]O[-max]P[num]''.'
  inputBinding:
    position: 3
    prefix: --elements
- id: filter
  type:
  - 'null'
  - string
  doc: 'Set the strictness of the chemical filter. Example: levels are STRICT < COMMON
    < PERMISSIVE < RDBE < NONE.'
  inputBinding:
    position: 4
    prefix: --filter
- id: ion
  type:
  - 'null'
  - string
  doc: 'Ionization mode. Example: ''[M+H]+''.'
  inputBinding:
    position: 5
    prefix: --ion
- id: mass
  type:
  - 'null'
  - type: array
    items: double
  doc: Masses that will be decomposed.
  inputBinding:
    position: 6
    prefix: --mass
    itemSeparator: ','
- id: nofilter
  type:
  - 'null'
  - boolean
  doc: If set, the molecular formulas are not filtered by their chemical properties.
  inputBinding:
    position: 7
    prefix: --nofilter
- id: output
  type: string
  doc: File to with output to.
  inputBinding:
    position: 8
    prefix: --output
  default: decomp.tsv
- id: ppm
  type:
  - 'null'
  - double
  doc: Relative mass error in ppm.
  inputBinding:
    position: 9
    prefix: --ppm
- id: parent
  type:
  - 'null'
  - string
  doc: If set, the decompositions have to be subformulas of the given parent formula.
  inputBinding:
    position: 10
    prefix: --parent
- id: errors
  type:
  - 'null'
  - boolean
  doc: print mass errors
  inputBinding:
    position: 11
    prefix: --errors
outputs:
- id: decompositions
  type: File
  doc: Table of mass decompositions
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: ResourceRequirement
  coresMin: 1
  ramMin: 4000
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
