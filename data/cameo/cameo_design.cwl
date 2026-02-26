cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cameo
  - design
label: cameo_design
doc: "Compute strain designs for desired product.\n\nTool homepage: http://cameo.bio"
inputs:
  - id: product
    type: string
    doc: Desired product
    inputBinding:
      position: 1
  - id: aerobic
    type:
      - 'null'
      - boolean
    doc: Make oxygen available to the host organism
    default: true
    inputBinding:
      position: 102
      prefix: --aerobic
  - id: anaerobic
    type:
      - 'null'
      - boolean
    doc: Make oxygen available to the host organism
    default: false
    inputBinding:
      position: 102
      prefix: --anaerobic
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use
    default: 1
    inputBinding:
      position: 102
      prefix: --cores
  - id: differential_fva
    type:
      - 'null'
      - boolean
    doc: Perform differential flux variability analysis to determine flux 
      modulation targets
    default: true
    inputBinding:
      position: 102
      prefix: --differential-fva
  - id: differential_fva_points
    type:
      - 'null'
      - int
    doc: Grid points for differential FVA
    default: 10
    inputBinding:
      position: 102
      prefix: --differential-fva-points
  - id: heuristic_optimization
    type:
      - 'null'
      - boolean
    doc: Find gene knockout targets through heuristic optimization
    default: true
    inputBinding:
      position: 102
      prefix: --heuristic-optimization
  - id: heuristic_optimization_timeout
    type:
      - 'null'
      - int
    doc: Time limit (min) on individual heuristic optimizations
    default: 45
    inputBinding:
      position: 102
      prefix: --heuristic-optimization-timeout
  - id: host
    type:
      - 'null'
      - type: array
        items: string
    doc: The host organisms to consider
    default: all
    inputBinding:
      position: 102
      prefix: --host
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: WARNING
    inputBinding:
      position: 102
      prefix: --logging
  - id: max_pathway_predictions
    type:
      - 'null'
      - int
    doc: Maximum number of heterologous pathways to predict
    default: 1
    inputBinding:
      position: 102
      prefix: --max-pathway-predictions
  - id: no_differential_fva
    type:
      - 'null'
      - boolean
    doc: Perform differential flux variability analysis to determine flux 
      modulation targets
    default: false
    inputBinding:
      position: 102
      prefix: --no-differential-fva
  - id: no_heuristic_optimization
    type:
      - 'null'
      - boolean
    doc: Find gene knockout targets through heuristic optimization
    default: false
    inputBinding:
      position: 102
      prefix: --no-heuristic-optimization
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output file format
    default: csv
    inputBinding:
      position: 102
      prefix: --format
  - id: pathway_prediction_timeout
    type:
      - 'null'
      - int
    doc: Time limit (min) for individual pathway predictions
    default: 10
    inputBinding:
      position: 102
      prefix: --pathway-prediction-timeout
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename. Multiple output files can be provided (pair with 
      respective format options).
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0
