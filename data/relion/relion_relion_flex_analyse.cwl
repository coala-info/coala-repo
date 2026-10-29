cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_flex_analyse
label: relion_relion_flex_analyse
doc: "Analyse multi-body refinement results: 3D models, principal components along eigenvectors.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: data
    type:
      - 'null'
      - File
    doc: The _data.star file with the orientations to be analysed
    inputBinding:
      position: 101
      prefix: --data
  - id: model
    type:
      - 'null'
      - File
    doc: The corresponding _model.star file with the refined model
    inputBinding:
      position: 101
      prefix: --model
  - id: bodies
    type:
      - 'null'
      - File
    doc: The corresponding star file with the definition of the bodies
    inputBinding:
      position: 101
      prefix: --bodies
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output rootname (RELION default: analyse)'
    inputBinding:
      position: 101
      prefix: --o
    default: analyse
  - id: models_3d
    type:
      - 'null'
      - boolean
    doc: Generate a 3D model for each experimental particles
    inputBinding:
      position: 101
      prefix: --3dmodels
  - id: size_3dmodels
    type:
      - 'null'
      - int
    doc: 'Output size of the 3D models (default is same as input particles) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --size_3dmodels
  - id: PCA_orient
    type:
      - 'null'
      - boolean
    doc: Perform a principal components analysis on the multibody orientations
    inputBinding:
      position: 101
      prefix: --PCA_orient
  - id: do_maps
    type:
      - 'null'
      - boolean
    doc: Generate maps along the principal components
    inputBinding:
      position: 101
      prefix: --do_maps
  - id: k
    type:
      - 'null'
      - int
    doc: 'Number of principal components to generate maps for (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --k
  - id: v
    type:
      - 'null'
      - float
    doc: 'Or use as many principal components to explain this fraction of variance (<0,1]) (RELION default:
      0.75)'
    inputBinding:
      position: 101
      prefix: --v
  - id: maps_per_movie
    type:
      - 'null'
      - int
    doc: 'Number of maps to use for the movie of each principal component (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --maps_per_movie
  - id: bins
    type:
      - 'null'
      - int
    doc: 'Number of bins in histograms of the eigenvalues for each principal component (RELION default:
      100)'
    inputBinding:
      position: 101
      prefix: --bins
  - id: select_eigenvalue
    type:
      - 'null'
      - int
    doc: 'Output a selection particle.star file based on eigenvalues along this eigenvector (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --select_eigenvalue
  - id: select_eigenvalue_min
    type:
      - 'null'
      - float
    doc: 'Minimum for eigenvalue to include particles in selection output star file (RELION default: -99999.)'
    inputBinding:
      position: 101
      prefix: --select_eigenvalue_min
  - id: select_eigenvalue_max
    type:
      - 'null'
      - float
    doc: 'Maximum for eigenvalue to include particles in selection output star file (RELION default: 99999.)'
    inputBinding:
      position: 101
      prefix: --select_eigenvalue_max
  - id: write_pca_projections
    type:
      - 'null'
      - boolean
    doc: Write out a text file with all PCA projections for all particles
    inputBinding:
      position: 101
      prefix: --write_pca_projections
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files and directories
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_flex_analyse.out
