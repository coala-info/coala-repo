cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_run_latent_to_gene
label: gsmap_run_latent_to_gene
doc: "Converts latent representations to gene expression.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: annotation
    type:
      - 'null'
      - string
    doc: Name of the annotation in adata.obs to use (optional).
    inputBinding:
      position: 101
      prefix: --annotation
  - id: gM_slices
    type:
      - 'null'
      - File
    doc: Path to the slice mean file (optional).
    inputBinding:
      position: 101
      prefix: --gM_slices
  - id: homolog_file
    type:
      - 'null'
      - File
    doc: Path to homologous gene conversion file (optional).
    inputBinding:
      position: 101
      prefix: --homolog_file
  - id: input_hdf5_path
    type:
      - 'null'
      - File
    doc: Path to the input HDF5 file with latent representations, if 
      --latent_representation is specified.
    inputBinding:
      position: 101
      prefix: --input_hdf5_path
  - id: latent_representation
    type:
      - 'null'
      - string
    doc: Type of latent representation. This should exist in the h5ad obsm.
    inputBinding:
      position: 101
      prefix: --latent_representation
  - id: no_expression_fraction
    type:
      - 'null'
      - boolean
    doc: Skip expression fraction filtering.
    inputBinding:
      position: 101
      prefix: --no_expression_fraction
  - id: num_neighbour
    type:
      - 'null'
      - int
    doc: Number of neighbors.
    inputBinding:
      position: 101
      prefix: --num_neighbour
  - id: num_neighbour_spatial
    type:
      - 'null'
      - int
    doc: Number of spatial neighbors.
    inputBinding:
      position: 101
      prefix: --num_neighbour_spatial
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_run_latent_to_gene.out
