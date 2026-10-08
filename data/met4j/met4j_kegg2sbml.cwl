cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Kegg2Sbml
label: met4j_kegg2sbml
doc: "Build a SBML file from KEGG organism-specific pathways. Uses Kegg API. Errors returned by this program could be due to Kegg API dysfunctions or limitations. Try later if this problem occurs.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: output
    type: string
    default: out.sbml
    doc: '[out.sbml] Out sbml file (default: out.sbml)'
    inputBinding:
      position: 1
      prefix: -o
  - id: kegg_org
    type: string
    doc: '[] Kegg org id. Must be 3 letters ( (default: )'
    inputBinding:
      position: 2
      prefix: -org
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
