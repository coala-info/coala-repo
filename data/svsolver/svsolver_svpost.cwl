cwlVersion: v1.2
class: CommandLineTool
baseCommand: svpost
label: svsolver_svpost
doc: "SimVascular post-processor: reduces flow solver restart files to VTK, Vis or restart formats.\n\nTool homepage: https://simtk.org/projects/simvascular/"
inputs:
  - id: work_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Restart, geombc and other files from the flow solver run, staged in the working directory
  - id: single_step
    type:
      - 'null'
      - int
    doc: 'Specify single step number to reduce'
    inputBinding:
      position: 1
      prefix: '-sn'
  - id: start_step
    type:
      - 'null'
      - int
    doc: 'Specify starting step number'
    inputBinding:
      position: 1
      prefix: '-start'
  - id: stop_step
    type:
      - 'null'
      - int
    doc: 'Specify stopping step number'
    inputBinding:
      position: 1
      prefix: '-stop'
  - id: new_step
    type:
      - 'null'
      - int
    doc: 'Override step number in file'
    inputBinding:
      position: 1
      prefix: '-newsn'
  - id: increment
    type:
      - 'null'
      - int
    doc: 'Specify increment between steps'
    inputBinding:
      position: 1
      prefix: '-incr'
  - id: write_restart
    type:
      - 'null'
      - boolean
    doc: 'Write flowsolver-format file restart.<stepnumber>.0'
    inputBinding:
      position: 1
      prefix: '-ph'
  - id: last_step_only
    type:
      - 'null'
      - boolean
    doc: 'Only write last step to file restart.<stepnumber>.0'
    inputBinding:
      position: 1
      prefix: '-laststep'
  - id: vis_prefix
    type:
      - 'null'
      - string
    doc: 'Write Vis-format results file with this file prefix'
    inputBinding:
      position: 1
      prefix: '-vis'
  - id: vis_mesh
    type:
      - 'null'
      - string
    doc: 'Write Vis-format mesh file'
    inputBinding:
      position: 1
      prefix: '-vismesh'
  - id: vtu
    type:
      - 'null'
      - string
    doc: 'Write VTK XML UnstructuredGrid (prefix or file)'
    inputBinding:
      position: 1
      prefix: '-vtu'
  - id: vtp
    type:
      - 'null'
      - string
    doc: 'Write surface only VTK XML PolyData (prefix or file)'
    inputBinding:
      position: 1
      prefix: '-vtp'
  - id: vtk_combo
    type:
      - 'null'
      - boolean
    doc: 'Combine all VTK in single file'
    inputBinding:
      position: 1
      prefix: '-vtkcombo'
  - id: solution
    type:
      - 'null'
      - boolean
    doc: 'Reduce solution (pressure and velocity)'
    inputBinding:
      position: 1
      prefix: '-sol'
  - id: traction
    type:
      - 'null'
      - boolean
    doc: 'Reduce in-plane traction'
    inputBinding:
      position: 1
      prefix: '-traction'
  - id: displacement
    type:
      - 'null'
      - boolean
    doc: 'Reduce displacements'
    inputBinding:
      position: 1
      prefix: '-disp'
  - id: wall_properties
    type:
      - 'null'
      - boolean
    doc: 'Reduce wall properties'
    inputBinding:
      position: 1
      prefix: '-wallprop'
  - id: density
    type:
      - 'null'
      - double
    doc: 'Fluid density'
    inputBinding:
      position: 1
      prefix: '-rho'
  - id: viscosity
    type:
      - 'null'
      - double
    doc: 'Fluid viscosity'
    inputBinding:
      position: 1
      prefix: '-mu'
  - id: time_derivative
    type:
      - 'null'
      - boolean
    doc: 'Reduce time-derivative field'
    inputBinding:
      position: 1
      prefix: '-td'
  - id: wall_shear_stress
    type:
      - 'null'
      - boolean
    doc: 'Reduce wall shear stress'
    inputBinding:
      position: 1
      prefix: '-wss'
  - id: wall_filter
    type:
      - 'null'
      - string
    doc: 'Output wall data only on specified wall'
    inputBinding:
      position: 1
      prefix: '-wfilter'
  - id: calc_wall_stress
    type:
      - 'null'
      - boolean
    doc: 'Recalculate wall stress on specified wall'
    inputBinding:
      position: 1
      prefix: '-calcws'
  - id: apply_wall_deformation
    type:
      - 'null'
      - boolean
    doc: 'Apply wall deformation during wall stress calculation'
    inputBinding:
      position: 1
      prefix: '-applywd'
  - id: average_fields
    type:
      - 'null'
      - boolean
    doc: 'Reduce average speed and pressure'
    inputBinding:
      position: 1
      prefix: '-ybar'
  - id: error_fields
    type:
      - 'null'
      - boolean
    doc: 'Reduce speed and pressure errors'
    inputBinding:
      position: 1
      prefix: '-yerror'
  - id: nonbinary
    type:
      - 'null'
      - boolean
    doc: 'Read/write files in ASCII format'
    inputBinding:
      position: 1
      prefix: '-nonbinary'
  - id: reduce_all
    type:
      - 'null'
      - boolean
    doc: 'Reduce all available data'
    inputBinding:
      position: 1
      prefix: '-all'
  - id: units_mm
    type:
      - 'null'
      - boolean
    doc: 'Set sim units to mm'
    inputBinding:
      position: 1
      prefix: '-sim_units_mm'
  - id: units_cm
    type:
      - 'null'
      - boolean
    doc: 'Set sim units to cm (default)'
    inputBinding:
      position: 1
      prefix: '-sim_units_cm'
  - id: input_dir
    type:
      - 'null'
      - string
    doc: 'Directory containing restart files (default .)'
    inputBinding:
      position: 1
      prefix: '-indir'
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Directory containing output files (default .)'
    inputBinding:
      position: 1
      prefix: '-outdir'
  - id: compare_residuals
    type:
      - 'null'
      - boolean
    doc: 'Compare residual profiles on histor.dat files and write a report to residualDiff.out'
    inputBinding:
      position: 1
      prefix: '-res'
  - id: compare_vtu
    type:
      - 'null'
      - boolean
    doc: 'Compare pressures and velocities in result VTU files and write a report to vtuDiff.out'
    inputBinding:
      position: 1
      prefix: '-compare'
outputs:
  - id: vtk_files
    type:
      type: array
      items: File
    doc: VTK and Vis files written by svpost
    outputBinding:
      glob:
        - '*.vtu'
        - '*.vtp'
        - '*.vis*'
        - restart.*
        - residualDiff.out
        - vtuDiff.out
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.work_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
stdout: svsolver_svpost.out
