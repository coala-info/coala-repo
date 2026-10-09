cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - create-inittable
label: jass_create-inittable
doc: "Creates an initial table (HDF5) for JASS from GWAS summary statistics in ImpG
  format (one file per phenotype and chromosome, named with a pattern), a regions
  map and a GWAS description file.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: JASS_PROJECTS_DIR
        envValue: $(runtime.outdir)/jass_projects
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_data_files)
inputs:
  - id: input_data_files
    type: File[]
    doc: "The GWAS data files (ImpG format). They are staged in the working directory
      so that the pattern in input_data_path resolves to them."
  - id: input_data_path
    type: string
    doc: "Glob pattern, relative to the working directory, matching the names of the
      staged input_data_files (for example z_MAGIC_*.txt). Passed as one word; JASS
      expands it itself."
    inputBinding:
      position: 101
      prefix: --input-data-path
  - id: description_file_path
    type: File
    doc: path to the GWAS studies metadata file
    inputBinding:
      position: 101
      prefix: --description-file-path
  - id: regions_map_path
    type: File
    doc: path to the genome regions map (BED format) to import
    inputBinding:
      position: 101
      prefix: --regions-map-path
  - id: init_covariance_path
    type:
      - 'null'
      - File
    doc: path to the covariance file to import
    inputBinding:
      position: 101
      prefix: --init-covariance-path
  - id: init_genetic_covariance_path
    type:
      - 'null'
      - File
    doc: "path to the genetic covariance file to import. Used\nonly for display on Jass
      web application"
    inputBinding:
      position: 101
      prefix: --init-genetic-covariance-path
  - id: init_table_path
    type: string
    doc: "path of the initial data file to produce (HDF5). JASS defaults to
      JASS_DATA_DIR/initTable.hdf5, which is not writable in the container, so give
      a name in the working directory."
    inputBinding:
      position: 101
      prefix: --init-table-path
outputs:
  - id: init_table
    type: File
    doc: The initial table produced (HDF5)
    outputBinding:
      glob: $(inputs.init_table_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
