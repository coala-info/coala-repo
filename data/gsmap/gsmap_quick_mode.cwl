cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_quick_mode
label: gsmap_quick_mode
doc: "Performs a quick mode analysis with gsMap.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: annotation
    type: string
    doc: Name of the annotation in adata.obs to use.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: data_layer
    type: string
    doc: Data layer for gene expression (e.g., "count", "counts", "log1p").
    default: counts
    inputBinding:
      position: 101
      prefix: --data_layer
  - id: gm_slices
    type:
      - 'null'
      - File
    doc: Path to the slice mean file (optional).
    inputBinding:
      position: 101
      prefix: --gM_slices
  - id: gsmap_resource_dir
    type: Directory
    doc: Directory containing gsMap resources (e.g., genome annotations, LD 
      reference panel, etc.).
    inputBinding:
      position: 101
      prefix: --gsMap_resource_dir
  - id: hdf5_path
    type: File
    doc: Path to the input spatial transcriptomics data (H5AD format).
    inputBinding:
      position: 101
      prefix: --hdf5_path
  - id: homolog_file
    type:
      - 'null'
      - File
    doc: Path to homologous gene for converting gene names from different 
      species to human (optional, used for cross- species analysis).
    inputBinding:
      position: 101
      prefix: --homolog_file
  - id: latent_representation
    type:
      - 'null'
      - string
    doc: Type of latent representation. This should exist in the h5ad obsm.
    inputBinding:
      position: 101
      prefix: --latent_representation
  - id: max_processes
    type:
      - 'null'
      - int
    doc: Maximum number of processes for parallel execution.
    default: 10
    inputBinding:
      position: 101
      prefix: --max_processes
  - id: num_neighbour
    type:
      - 'null'
      - int
    doc: Number of neighbors.
    default: 21
    inputBinding:
      position: 101
      prefix: --num_neighbour
  - id: num_neighbour_spatial
    type:
      - 'null'
      - int
    doc: Number of spatial neighbors.
    default: 101
    inputBinding:
      position: 101
      prefix: --num_neighbour_spatial
  - id: pearson_residuals
    type:
      - 'null'
      - boolean
    doc: Using the pearson residuals.
    default: false
    inputBinding:
      position: 101
      prefix: --pearson_residuals
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: sumstats_config_file
    type:
      - 'null'
      - File
    doc: Path to GWAS summary statistics config file. Either sumstats_file or 
      sumstats_config_file is required.
    inputBinding:
      position: 101
      prefix: --sumstats_config_file
  - id: sumstats_file
    type:
      - 'null'
      - File
    doc: Path to GWAS summary statistics file. Either sumstats_file or 
      sumstats_config_file is required.
    inputBinding:
      position: 101
      prefix: --sumstats_file
  - id: trait_name
    type:
      - 'null'
      - string
    doc: Name of the trait for GWAS analysis (required if sumstats_file is 
      provided).
    inputBinding:
      position: 101
      prefix: --trait_name
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
stdout: gsmap_quick_mode.out
