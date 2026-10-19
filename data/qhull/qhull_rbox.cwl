cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbox
label: qhull_rbox
doc: "rbox generates various point distributions (default random points in a cube) as input for the Qhull programs.\n\nTool homepage: https://github.com/qhull/qhull"
inputs:
  - id: num_points
    type:
      - 'null'
      - int
    doc: number of random points in cube, lens, spiral, sphere or grid
    inputBinding:
      position: 1
  - id: opt_c
    type:
      - 'null'
      - boolean
    doc: 'add a unit cube to the output (''c G2.0'' sets size)'
    inputBinding:
      position: 2
      prefix: c
  - id: opt_d
    type:
      - 'null'
      - boolean
    doc: 'add a unit diamond to the output (''d G2.0'' sets size)'
    inputBinding:
      position: 2
      prefix: d
  - id: opt_l
    type:
      - 'null'
      - boolean
    doc: generate a regular 3-d spiral
    inputBinding:
      position: 2
      prefix: l
  - id: opt_r
    type:
      - 'null'
      - boolean
    doc: 'generate a regular polygon, (''r s Z1 G0.1'' makes a cone)'
    inputBinding:
      position: 2
      prefix: r
  - id: opt_s
    type:
      - 'null'
      - boolean
    doc: generate cospherical points
    inputBinding:
      position: 2
      prefix: s
  - id: opt_x
    type:
      - 'null'
      - boolean
    doc: 'generate random points in simplex, may use ''r'' or ''Wn'''
    inputBinding:
      position: 2
      prefix: x
  - id: opt_y
    type:
      - 'null'
      - boolean
    doc: 'same as ''x'', plus simplex'
    inputBinding:
      position: 2
      prefix: y
  - id: opt_h
    type:
      - 'null'
      - boolean
    doc: output as homogeneous coordinates for cdd
    inputBinding:
      position: 2
      prefix: h
  - id: opt_n
    type:
      - 'null'
      - boolean
    doc: remove command line from the first line of output
    inputBinding:
      position: 2
      prefix: n
  - id: opt_t
    type:
      - 'null'
      - boolean
    doc: use time as the random number seed (default is command line)
    inputBinding:
      position: 2
      prefix: t
  - id: opt_z
    type:
      - 'null'
      - boolean
    doc: 'print integer coordinates, default ''Bn'' is 1e+06'
    inputBinding:
      position: 2
      prefix: z
  - id: opt_D_value
    type:
      - 'null'
      - int
    doc: 'dimension, for example 3 for 3-d'
    inputBinding:
      position: 2
      prefix: D
      separate: false
  - id: opt_C_value
    type:
      - 'null'
      - string
    doc: 'add n nearly coincident points within radius r of m points, given as n,r,m'
    inputBinding:
      position: 2
      prefix: C
      separate: false
  - id: opt_P_value
    type:
      - 'null'
      - string
    doc: 'add point [n,m,r] first, pads with 0, maybe repeated, given as n,m,r'
    inputBinding:
      position: 2
      prefix: P
      separate: false
  - id: opt_L_value
    type:
      - 'null'
      - string
    doc: 'lens distribution of radius n. Also ''s'', ''r'', ''G'', ''W'''
    inputBinding:
      position: 2
      prefix: L
      separate: false
  - id: opt_M_value
    type:
      - 'null'
      - string
    doc: 'lattice (Mesh) rotated by [n,-m,0], [m,n,0], [0,0,r], ..., given as n,m,r'
    inputBinding:
      position: 2
      prefix: M
      separate: false
  - id: opt_W_value
    type:
      - 'null'
      - string
    doc: 'random distribution within n of the cube''s or sphere''s surface'
    inputBinding:
      position: 2
      prefix: W
      separate: false
  - id: opt_Z_value
    type:
      - 'null'
      - string
    doc: random points in a disk of radius n projected to a sphere (with s)
    inputBinding:
      position: 2
      prefix: Z
      separate: false
  - id: opt_G_value
    type:
      - 'null'
      - string
    doc: 'gap or size value n (for example ''c G2.0'' sets the cube size, ''Z0.5 s G0.6'' adds a gap)'
    inputBinding:
      position: 2
      prefix: G
      separate: false
  - id: opt_B_value
    type:
      - 'null'
      - string
    doc: 'bounding box coordinates, default 0.5'
    inputBinding:
      position: 2
      prefix: B
      separate: false
  - id: opt_O_value
    type:
      - 'null'
      - string
    doc: offset coordinates by n
    inputBinding:
      position: 2
      prefix: O
      separate: false
  - id: opt_seed_value
    type:
      - 'null'
      - string
    doc: use n as the random number seed
    inputBinding:
      position: 2
      prefix: t
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the generated points)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull_rbox.out
