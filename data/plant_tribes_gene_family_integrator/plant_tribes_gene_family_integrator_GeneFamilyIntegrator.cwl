cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyIntegrator
label: plant_tribes_gene_family_integrator_GeneFamilyIntegrator
doc: "INTEGRATE SCAFFOLD AND CLASSIFIED GENE FAMILIES\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs:
  - id: method
    type: string
    doc: "Protein clustering method for the classification scaffold\n            \
      \                        If GFam: gfam\n                                   \
      \ If OrthoFinder: orthofinder\n                                    If OrthoMCL:
      orthomcl\n                                    If Other non PlantTribes method:
      methodname, where \"methodname\" a nonempty string of\n                    \
      \                word characters (alphanumeric or \"_\"). No embedded special
      charaters or white spaces."
    inputBinding:
      position: 101
      prefix: --method
  - id: orthogroup_fasta
    type: Directory
    doc: Directory containing gene family classification orthogroups fasta files
    inputBinding:
      position: 101
      prefix: --orthogroup_fasta
  - id: scaffold
    type: string
    doc: "Orthogroups or gene families proteins scaffold.  This can either be an absolute\n\
      \                                    path to the directory containing the scaffolds
      (e.g., /home/scaffolds/22Gv1.1)\n                                    or just
      the scaffold (e.g., 22Gv1.1).  If the latter, ~home/data is prepended to\n \
      \                                   the scaffold to create the absolute path.\n\
      \                                    If Monocots clusters (version 1.0): 12Gv1.0\n\
      \                                    If Angiosperms clusters (version 1.0):
      22Gv1.0\n                                    If Angiosperms clusters (version
      1.1): 22Gv1.1\n                                    If Green plants clusters
      (version 1.0): 30Gv1.0\n                                    If Other non PlantTribes
      clusters: XGvY.Z, where \"X\" is the number species in the scaffold,\n     \
      \                               and \"Y.Z\" version number such as 12Gv1.0.
      Please look at one of the PlantTribes scaffold\n                           \
      \         data on how data files and directories are named, formated, and organized."
    inputBinding:
      position: 101
      prefix: --scaffold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/plant_tribes_gene_family_integrator:1.0.4--0
stdout: plant_tribes_gene_family_integrator_GeneFamilyIntegrator.out
