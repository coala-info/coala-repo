cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.SbmlWizard
label: met4j_sbmlwizard
doc: "General SBML model processing including compound removal (such as side compounds or isolated compounds), reaction removal (ex. blocked or exchange reaction), and compartment merging\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 1
      prefix: -i
  - id: retain_c
    type: ['null', File]
    doc: file containing identifiers of compounds to keep from the metabolic network
    inputBinding:
      position: 2
      prefix: -kc
  - id: retain_r
    type: ['null', File]
    doc: file containing identifiers of reactions to keep from the metabolic network
    inputBinding:
      position: 3
      prefix: -kr
  - id: mergecomp
    type: ['null', string]
    doc: 'merge compartments using the provided strategy. No merge by default. "by_name" can be used if names are consistent and unambiguous across compartments, "by_id" can be used if compartment suffix is present in compounds identifiers (id in form "xxx_y" with xxx as base identifier and y as compartment label). (default: no) Choices: no, by_name, by_id'
    inputBinding:
      position: 4
      prefix: -mc
  - id: output
    type: string
    doc: output SBML file
    inputBinding:
      position: 5
      prefix: -o
  - id: no_flux
    type: ['null', boolean]
    doc: 'remove reactions with lower and upper flux bounds both set to 0.0 (default: false)'
    inputBinding:
      position: 6
      prefix: -r0
  - id: remove_exchange
    type: ['null', string]
    doc: remove exchange reactions and species from given exchange compartment identifier
    inputBinding:
      position: 7
      prefix: -rEX
  - id: remove_c
    type: ['null', File]
    doc: file containing identifiers of compounds to remove from the metabolic network
    inputBinding:
      position: 8
      prefix: -rc
  - id: no_duplicated
    type: ['null', boolean]
    doc: 'remove duplicated reactions (same reactants, same GPR) (default: false)'
    inputBinding:
      position: 9
      prefix: -rdr
  - id: no_isolated
    type: ['null', boolean]
    doc: 'remove isolated compounds (not involved in any reaction) (default: false)'
    inputBinding:
      position: 10
      prefix: -ric
  - id: remove_r
    type: ['null', File]
    doc: file containing identifiers of reactions to remove from the metabolic network
    inputBinding:
      position: 11
      prefix: -rr
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
