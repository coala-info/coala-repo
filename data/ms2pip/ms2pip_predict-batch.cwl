cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2pip
  - predict-batch
label: ms2pip_predict-batch
doc: "Predict fragmentation spectra for a batch of peptides.\n\nTool homepage: http://compomics.github.io/projects/ms2pip_c"
inputs:
  - id: psms
    type: string
    doc: PSMs
    inputBinding:
      position: 1
  - id: add_ion_mobility
    type:
      - 'null'
      - boolean
    doc: Add ion mobility to the output
    inputBinding:
      position: 102
      prefix: --add-ion-mobility
  - id: add_retention_time
    type:
      - 'null'
      - boolean
    doc: Add retention time to the output
    inputBinding:
      position: 102
      prefix: --add-retention-time
  - id: model
    type:
      - 'null'
      - string
    doc: 'Pre-trained model to use for prediction. Supported models: CID, HCD2019,
      TTOF5600, TMT, iTRAQ, iTRAQphospho, HCDch2, CIDch2, HCD2021, Immuno-HCD, CID-TMT,
      timsTOF2023, timsTOF2024, HCD, timsTOF'
    inputBinding:
      position: 102
      prefix: --model
  - id: model_dir
    type:
      - 'null'
      - string
    doc: Directory containing pre-trained models
    inputBinding:
      position: 102
      prefix: --model-dir
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Format of the output spectra. Supported formats: tsv, msp, mgf, spectronaut,
      bibliospec, dlib'
    inputBinding:
      position: 102
      prefix: --output-format
  - id: output_name
    type:
      - 'null'
      - string
    doc: Base name for the output files
    inputBinding:
      position: 102
      prefix: --output-name
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use
    inputBinding:
      position: 102
      prefix: --processes
  - id: psm_filetype
    type:
      - 'null'
      - string
    doc: 'Type of the PSM file. Supported types: flashlfq, ionbot, idxml, msms, mzid,
      peprec, pepxml, percolator, proteome_discoverer, proteoscape, xtandem, msamanda,
      sage_tsv, sage_parquet, fragpipe, alphadia, diann, parquet, tsv, sage'
    inputBinding:
      position: 102
      prefix: --psm-filetype
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
stdout: ms2pip_predict-batch.out
