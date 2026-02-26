cwlVersion: v1.2
class: CommandLineTool
baseCommand: CurveCurator
label: curve-curator_CurveCurator
doc: "Complete analysis pipeline for dose-response curves including fitting, filtering,
  and visualization. FPB-2024\n\nTool homepage: https://github.com/kusterlab/curve_curator"
inputs:
  - id: path
    type: string
    doc: Relative path to the config.toml or batch.txt file to run the pipeline.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Run a batch process with a file containing all the parameter file 
      paths.
    inputBinding:
      position: 102
      prefix: --batch
  - id: fdr
    type:
      - 'null'
      - boolean
    doc: Estimate FDR based on target decoy approach. Estimating the FDR will 
      double the run time.
    inputBinding:
      position: 102
      prefix: --fdr
  - id: mad
    type:
      - 'null'
      - boolean
    doc: Perform the medium absolute deviation (MAD) analysis to detect outliers
    inputBinding:
      position: 102
      prefix: --mad
  - id: random
    type:
      - 'null'
      - type: array
        items: int
    doc: Run the pipeline with <N> random values for H0 simulation.
    inputBinding:
      position: 102
      prefix: --random
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curve-curator:0.6.0--pyhdfd78af_0
stdout: curve-curator_CurveCurator.out
