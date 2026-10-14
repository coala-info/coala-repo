cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyIntegrator
label: plant_tribes_gene_family_integrator_GeneFamilyIntegrator
doc: "Integrate scaffold and classified gene families: combine the orthogroup fasta files from GeneFamilyClassifier with the scaffold orthogroup sequences. Results are written to the integratedGeneFamilies_dir folder in the working directory.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: orthogroup_fasta
    type: Directory
    doc: 'Directory containing gene family classification orthogroups fasta files'
    inputBinding:
      position: 101
      prefix: --orthogroup_fasta
      valueFrom: $(self.path)
  - id: scaffold
    type: Directory
    doc: 'Orthogroups or gene families proteins scaffold directory (for example 22Gv1.1)'
    inputBinding:
      position: 101
      prefix: --scaffold
      valueFrom: $(self.path)
  - id: method
    type: string
    doc: 'Protein clustering method for the classification scaffold: gfam, orthofinder, orthomcl or another method name'
    inputBinding:
      position: 101
      prefix: --method
outputs:
  - id: integrated_dir
    type: Directory
    doc: 'Integrated gene family fasta files'
    outputBinding:
      glob: 'integratedGeneFamilies_dir'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_integrator:1.0.4--0
stdout: GeneFamilyIntegrator.log
