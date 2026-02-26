cwlVersion: v1.2
class: CommandLineTool
baseCommand: vinalc
label: vinalc
doc: "Command line parse error: unrecognised option '-help'\n\nCorrect usage:\n\n\
  Tool homepage: https://github.com/XiaohuaZhangLLNL/VinaLC"
inputs:
  - id: energy_range
    type:
      - 'null'
      - float
    doc: maximum energy difference (default value 2.0) between the best binding 
      mode and the worst one displayed (kcal/mol)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --energy_range
  - id: exhaustiveness
    type:
      - 'null'
      - int
    doc: 'exhaustiveness (default value 8) of the global search (roughly proportional
      to time): 1+'
    default: 8
    inputBinding:
      position: 101
      prefix: --exhaustiveness
  - id: fle_list
    type:
      - 'null'
      - File
    doc: flex part receptor list file
    inputBinding:
      position: 101
      prefix: --fleList
  - id: geo_list
    type:
      - 'null'
      - File
    doc: receptor geometry file
    inputBinding:
      position: 101
      prefix: --geoList
  - id: granularity
    type:
      - 'null'
      - float
    doc: the granularity of grids (default value 0.375)
    default: 0.375
    inputBinding:
      position: 101
      prefix: --granularity
  - id: lig_list
    type:
      - 'null'
      - File
    doc: ligand list file
    inputBinding:
      position: 101
      prefix: --ligList
  - id: num_modes
    type:
      - 'null'
      - int
    doc: maximum number (default value 9) of binding modes to generate
    default: 9
    inputBinding:
      position: 101
      prefix: --num_modes
  - id: randomize
    type:
      - 'null'
      - boolean
    doc: Use different random seeds for complex
    inputBinding:
      position: 101
      prefix: --randomize
  - id: rec_list
    type:
      - 'null'
      - File
    doc: receptor list file
    inputBinding:
      position: 101
      prefix: --recList
  - id: score_cf
    type:
      - 'null'
      - float
    doc: Score cutoff to save ligand with top score higher than certain value 
      (default -8.0)
    default: -8.0
    inputBinding:
      position: 101
      prefix: --scoreCF
  - id: seed
    type:
      - 'null'
      - int
    doc: explicit random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_score_cf
    type:
      - 'null'
      - boolean
    doc: Use score cutoff to save ligand with top score higher than certain 
      critical value
    inputBinding:
      position: 101
      prefix: --useScoreCF
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vinalc:1.4.2--h01b65b2_0
stdout: vinalc.out
