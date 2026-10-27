cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mpiexec
label: vinalc
doc: "MPI and multi-threading mix parallel AutoDock Vina (virtual screening of ligand lists against receptor lists). VinaLC needs at least 2 MPI processes, so it is started with mpiexec.\n\nTool homepage: https://github.com/XiaohuaZhangLLNL/VinaLC"
inputs:
  - id: mpi_processes
    type:
      - 'null'
      - int
    doc: Number of MPI processes (mpiexec -n); VinaLC needs at least 2
    default: 2
    inputBinding:
      position: 1
      prefix: -n
  - id: list_members
    type:
      type: array
      items: File
    doc: Receptor, flexible receptor and ligand files named inside the list files; they are staged in the working directory next to the list files so the names resolve. The tool writes its results next to the receptor and ligand list files.
  - id: energy_range
    type:
      - 'null'
      - float
    doc: maximum energy difference (default value 2.0) between the best binding 
      mode and the worst one displayed (kcal/mol)
    inputBinding:
      position: 101
      prefix: --energy_range
  - id: exhaustiveness
    type:
      - 'null'
      - int
    doc: 'exhaustiveness (default value 8) of the global search (roughly proportional
      to time): 1+'
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
      valueFrom: $(self.basename)
  - id: geo_list
    type: File
    doc: receptor geometry file
    inputBinding:
      position: 101
      prefix: --geoList
      valueFrom: $(self.basename)
  - id: granularity
    type:
      - 'null'
      - float
    doc: the granularity of grids (default value 0.375)
    inputBinding:
      position: 101
      prefix: --granularity
  - id: lig_list
    type: File
    doc: ligand list file
    inputBinding:
      position: 101
      prefix: --ligList
      valueFrom: $(self.basename)
  - id: num_modes
    type:
      - 'null'
      - int
    doc: maximum number (default value 9) of binding modes to generate
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
    type: File
    doc: receptor list file
    inputBinding:
      position: 101
      prefix: --recList
      valueFrom: $(self.basename)
  - id: score_cf
    type:
      - 'null'
      - float
    doc: Score cutoff to save ligand with top score higher than certain value 
      (default -8.0)
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
  - id: poses
    type:
      type: array
      items: File
    doc: Docked poses (gzip-compressed pdbqt)
    outputBinding:
      glob: '*.pdbqt.gz'
  - id: logs
    type:
      type: array
      items: File
    doc: Docking logs (gzip-compressed)
    outputBinding:
      glob: '*.log.gz'
arguments:
  - position: 2
    valueFrom: vinalc
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ var l = inputs.list_members.concat([inputs.rec_list, inputs.lig_list, inputs.geo_list]); if (inputs.fle_list) { l.push(inputs.fle_list); } return l; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vinalc:1.4.2--h01b65b2_0
stdout: vinalc.out
