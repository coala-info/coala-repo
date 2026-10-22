cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skmer
  - correct
label: skmer_correct
doc: "Performs correction of subsampled distance matrices obtained for reference genome-skims or assemblies\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: main
    type: File
    doc: Distance matrix of main estimate
    inputBinding:
      position: 1
      prefix: -main
      valueFrom: $(self.basename)
  - id: subsample_dir
    type: Directory
    doc: Directory of output for subsample replicates (written to by the tool)
    inputBinding:
      position: 1
      prefix: -sub
      valueFrom: $(self.basename)
  - id: max_processors
    type: ['null', int]
    doc: Max number of processors to use [1-20]
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: corrected_main_matrix
    type: ['null', File]
    doc: Corrected main distance matrix (<main>_cor_.txt)
    outputBinding:
      glob: '*_cor_.txt'
  - id: subsample_results
    type: Directory
    doc: Subsample directory with the corrected replicate matrices and _summary.csv
    outputBinding:
      glob: $(inputs.subsample_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.main)
        writable: true
      - entry: $(inputs.subsample_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
