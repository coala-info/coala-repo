cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispritz_crispritz.py
label: crispritz_crispritz.py
doc: "ALL FASTA FILEs USED BY THE SOFTWARE MUST BE UNZIPPED AND CHROMOSOME SEPARATED,
  ALL VCFs USED BY THE SOFTWARE MUST BE ZIPPED AND CHROMOSOME SEPARATED\n\nTool homepage:
  https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: command
    type: string
    doc: Command to execute (add-variants, index-genome, search, scores, 
      annotate-results, generate-report)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
stdout: crispritz_crispritz.py.out
