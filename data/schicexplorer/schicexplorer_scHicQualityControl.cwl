cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicQualityControl
label: schicexplorer_scHicQualityControl
doc: "Quality control of single-cell Hi-C matrices: removes cells with a low read coverage or density and plots the distributions.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The single cell Hi-C interaction matrices to investigate for QC. Needs to be in scool format"
    inputBinding:
      position: 101
      prefix: --matrix
  - id: minimum_read_coverage
    type:
      - 'null'
      - int
    doc: "Remove all samples with a lower read coverage as this value. (default: 1000000)"
    inputBinding:
      position: 101
      prefix: --minimumReadCoverage
  - id: minimum_density
    type:
      - 'null'
      - float
    doc: "Remove all samples with a lower density as this value. The density is given by: number of non-zero interactions / all possible interactions. (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --minimumDensity
  - id: maximum_region_to_consider
    type:
      - 'null'
      - int
    doc: "To compute the density, consider only this genomic distance around the diagonal. (default: 30000000)"
    inputBinding:
      position: 101
      prefix: --maximumRegionToConsider
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of chromosomes that a cell needs to have to be not deleted."
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: plot_only
    type:
      - 'null'
      - boolean
    doc: "Do not create a new matrix, create only the plots."
    inputBinding:
      position: 101
      prefix: --plotOnly
  - id: run_chromosome_check
    type:
      - 'null'
      - boolean
    doc: "Skip the data integrity check for the chromosomes."
    inputBinding:
      position: 101
      prefix: --runChromosomeCheck
  - id: dpi
    type:
      - 'null'
      - int
    doc: "The dpi of the plot. (default: 300)"
    inputBinding:
      position: 101
      prefix: --dpi
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_scool_path
    type:
      - 'null'
      - string
    doc: "scool matrix which contains only the filtered matrices (default: filtered_matrices.scool)"
    inputBinding:
      position: 102
      prefix: --outputScool
  - id: out_file_name_density_path
    type:
      - 'null'
      - string
    doc: "File name of the density histogram (default: density.png)"
    inputBinding:
      position: 102
      prefix: --outFileNameDensity
  - id: out_file_name_read_coverage_path
    type:
      - 'null'
      - string
    doc: "File name of the read coverage (default: readCoverage.png)"
    inputBinding:
      position: 102
      prefix: --outFileNameReadCoverage
  - id: out_file_name_qc_report_path
    type:
      - 'null'
      - string
    doc: "File name of the quality report (default: qc_report.txt)"
    inputBinding:
      position: 102
      prefix: --outFileNameQCReport
outputs:
  - id: output_scool
    type:
      - 'null'
      - File
    doc: "Filtered scool matrix"
    outputBinding:
      glob: "$(inputs.output_scool_path)"
  - id: out_file_name_density
    type:
      - 'null'
      - File
    doc: "Density histogram"
    outputBinding:
      glob: "$(inputs.out_file_name_density_path)"
  - id: out_file_name_read_coverage
    type:
      - 'null'
      - File
    doc: "Read coverage plot"
    outputBinding:
      glob: "$(inputs.out_file_name_read_coverage_path)"
  - id: out_file_name_qc_report
    type:
      - 'null'
      - File
    doc: "Quality report"
    outputBinding:
      glob: "$(inputs.out_file_name_qc_report_path)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.matrix)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
