cwlVersion: v1.2
class: CommandLineTool
baseCommand: segzoo
label: segzoo
doc: "Segzoo is a tool that allows to run various genomic analysis on a segmentation
  obtained by segway. The results of each analysis are made available as well as a
  summarizing visualization of the results. The tool will download all necessary data
  into a common directory and run all the analysis, storing the results in an output
  directory. All this information is then transformed into a set of tables that can
  be found in this same directory under the \"data\" folder, that are used to generate
  a final visualization.\n\nTool homepage: https://github.com/hoffmangroup/segzoo"
inputs:
  - id: segmentation
    type: File
    doc: .bed.gz file, the segmentation/annotation output from Segway
    inputBinding:
      position: 1
  - id: build
    type:
      - 'null'
      - string
    doc: Build of the genome assembly used for the segmentation
    default: hg38
    inputBinding:
      position: 102
      prefix: --build
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    default: 1
    inputBinding:
      position: 102
      prefix: -j
  - id: dendrogram
    type:
      - 'null'
      - boolean
    doc: If set, perform hierarchical clustering of GMTK parameters table 
      row-wise
    default: false
    inputBinding:
      position: 102
      prefix: --dendrogram
  - id: download_only
    type:
      - 'null'
      - boolean
    doc: Execute only the rules that need internet connection, which store data 
      in a shared directory
    default: false
    inputBinding:
      position: 102
      prefix: --download-only
  - id: mne
    type:
      - 'null'
      - string
    doc: Allows specify an mne file to translate segment labels and track names 
      on the shown on the figure
    default: None
    inputBinding:
      position: 102
      prefix: --mne
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory to store all the results
    default: outdir
    inputBinding:
      position: 102
      prefix: --outdir
  - id: parameters
    type:
      - 'null'
      - File
    doc: The params.params file used to obtain the gmtk-parameters
    default: 'False'
    inputBinding:
      position: 102
      prefix: --parameters
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix where all the external data is going to be downloaded, followed 
      by /share/ggd/SPECIES/BUILD
    default: /usr/local
    inputBinding:
      position: 102
      prefix: --prefix
  - id: species
    type:
      - 'null'
      - string
    doc: Species of the genome used for the segmentation
    default: Homo_sapiens
    inputBinding:
      position: 102
      prefix: --species
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: unlock directory (see snakemake doc)
    default: false
    inputBinding:
      position: 102
      prefix: --unlock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segzoo:1.0.13--pyhdfd78af_0
stdout: segzoo.out
