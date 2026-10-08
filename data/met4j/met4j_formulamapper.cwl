cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - mapping.FormulaMapper
label: met4j_formulamapper
doc: "Retrieve metabolites in a SBML file from their chemical formula. The SBML file is expected to contain fbc:chemicalFormula attributes for species entries. The input formula file should contain one formula per line. The output is a tab delimited file with two columns: query formula, sbml metabolite id (one line per match)\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: formula_file
    type: File
    doc: input formula file (one per line)
    inputBinding:
      position: 1
      prefix: -f
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 2
      prefix: -i
  - id: output_na
    type: ['null', boolean]
    doc: 'Output formulas without match in model, with NA value (default: false)'
    inputBinding:
      position: 3
      prefix: -na
  - id: output
    type: string
    doc: output mapping file
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
