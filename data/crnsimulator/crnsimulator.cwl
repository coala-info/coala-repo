cwlVersion: v1.2
class: CommandLineTool
baseCommand: crnsimulator
label: crnsimulator
doc: "crnsimulator\n\nTool homepage: https://github.com/bad-ants-fleet/crnsimulator"
inputs:
  - id: atol
    type:
      - 'null'
      - float
    doc: Specify absolute tolerance for the solver.
    inputBinding:
      position: 101
      prefix: --atol
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not run the simulation, only write the files.
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 101
      prefix: --force
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print header for trajectories.
    inputBinding:
      position: 101
      prefix: --header
  - id: jacobian
    type:
      - 'null'
      - boolean
    doc: Symbolic calculation of Jacobi-Matrix. This may generate a very large 
      simulation file.
    inputBinding:
      position: 101
      prefix: --jacobian
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the (order of) species which should appear in the pyplot 
      legend, as well as the order of species for nxy output format.
    inputBinding:
      position: 101
      prefix: --labels
  - id: labels_strict
    type:
      - 'null'
      - boolean
    doc: When using pyplot, only plot tracjectories corresponding to labels, 
      when using nxy, only print the trajectories corresponding to labels.
    inputBinding:
      position: 101
      prefix: --labels-strict
  - id: list_labels
    type:
      - 'null'
      - boolean
    doc: Print all species and exit.
    inputBinding:
      position: 101
      prefix: --list-labels
  - id: logfile
    type:
      - 'null'
      - string
    doc: Redirect logging information to a file.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: mxstep
    type:
      - 'null'
      - int
    doc: Maximum number of steps allowed for each integration point in t.
    inputBinding:
      position: 101
      prefix: --mxstep
  - id: nxy
    type:
      - 'null'
      - boolean
    doc: Print time course to STDOUT in nxy format.
    inputBinding:
      position: 101
      prefix: --nxy
  - id: output
    type:
      - 'null'
      - string
    doc: Name of ODE library files.
    inputBinding:
      position: 101
      prefix: --output
  - id: p0
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Vector of initial species concentrations. E.g. "--p0 1=0.5 3=0.7" stands
      for 1st species at a concentration of 0.5 and 3rd species at a concentration
      of 0.7. You may chose to address species directly by name, e.g.: --p0 C=0.5.'
    inputBinding:
      position: 101
      prefix: --p0
  - id: pyplot
    type:
      - 'null'
      - string
    doc: Specify a filename to plot the ODE simulation.
    inputBinding:
      position: 101
      prefix: --pyplot
  - id: pyplot_xlim
    type:
      - 'null'
      - type: array
        items: float
    doc: Specify the limits of the x-axis.
    inputBinding:
      position: 101
      prefix: --pyplot-xlim
  - id: pyplot_ylim
    type:
      - 'null'
      - type: array
        items: float
    doc: Specify the limits of the y-axis.
    inputBinding:
      position: 101
      prefix: --pyplot-ylim
  - id: rtol
    type:
      - 'null'
      - float
    doc: Specify relative tolerance for the solver.
    inputBinding:
      position: 101
      prefix: --rtol
  - id: t0
    type:
      - 'null'
      - float
    doc: First time point of the time-course.
    inputBinding:
      position: 101
      prefix: --t0
  - id: t8
    type:
      - 'null'
      - float
    doc: End point of simulation time.
    inputBinding:
      position: 101
      prefix: --t8
  - id: t_lin
    type:
      - 'null'
      - int
    doc: Returns --t-lin evenly spaced numbers on a linear scale from --t0 to 
      --t8.
    inputBinding:
      position: 101
      prefix: --t-lin
  - id: t_log
    type:
      - 'null'
      - int
    doc: Returns --t-log evenly spaced numbers on a logarithmic scale from --t0 
      to --t8.
    inputBinding:
      position: 101
      prefix: --t-log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print logging output. (-vv increases verbosity.)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crnsimulator:0.9--pyh5bfb8f1_0
stdout: crnsimulator.out
