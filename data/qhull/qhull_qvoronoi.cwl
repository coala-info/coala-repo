cwlVersion: v1.2
class: CommandLineTool
baseCommand: qvoronoi
label: qhull_qvoronoi
doc: "qvoronoi computes the Voronoi diagram of points.\n\nTool homepage: https://github.com/qhull/qhull"
inputs:
  - id: points
    type: File
    doc: 'Input points: dimension, number of points, then one point per line'
  - id: opt_Qu
    type:
      - 'null'
      - boolean
    doc: compute furthest-site Voronoi diagram
    inputBinding:
      position: 1
      prefix: Qu
  - id: opt_Qz
    type:
      - 'null'
      - boolean
    doc: add point-at-infinity to Voronoi diagram
    inputBinding:
      position: 1
      prefix: Qz
  - id: opt_Qs
    type:
      - 'null'
      - boolean
    doc: search all points for the initial simplex
    inputBinding:
      position: 1
      prefix: Qs
  - id: opt_QG_value
    type:
      - 'null'
      - string
    doc: 'Voronoi vertices if visible from point n, -n if not (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: QG
      separate: false
  - id: opt_QV_value
    type:
      - 'null'
      - string
    doc: 'Voronoi vertices for input point n, -n if not (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: QV
      separate: false
  - id: opt_T4_value
    type:
      - 'null'
      - string
    doc: 'trace at level n, 4=all, 5=mem/gauss, -1= events (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: T
      separate: false
  - id: opt_Tc
    type:
      - 'null'
      - boolean
    doc: check frequently during execution
    inputBinding:
      position: 1
      prefix: Tc
  - id: opt_Ts
    type:
      - 'null'
      - boolean
    doc: statistics
    inputBinding:
      position: 1
      prefix: Ts
  - id: opt_Tv
    type:
      - 'null'
      - boolean
    doc: 'verify result: structure, convexity, and in-circle test'
    inputBinding:
      position: 1
      prefix: Tv
  - id: opt_Tz
    type:
      - 'null'
      - boolean
    doc: send all output to stdout
    inputBinding:
      position: 1
      prefix: Tz
  - id: opt_TF_value
    type:
      - 'null'
      - string
    doc: report summary when n or more facets created (value n after the option letters)
    inputBinding:
      position: 1
      prefix: TF
      separate: false
  - id: opt_TP_value
    type:
      - 'null'
      - string
    doc: turn on tracing when point n added to hull (value n after the option letters)
    inputBinding:
      position: 1
      prefix: TP
      separate: false
  - id: opt_TM_value
    type:
      - 'null'
      - string
    doc: turn on tracing at merge n (value n after the option letters)
    inputBinding:
      position: 1
      prefix: TM
      separate: false
  - id: opt_TW_value
    type:
      - 'null'
      - string
    doc: 'trace merge facets when width > n (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: TW
      separate: false
  - id: opt_TV_value
    type:
      - 'null'
      - string
    doc: 'stop qhull after adding point n, -n for before (see TCn) (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: TV
      separate: false
  - id: opt_TC_value
    type:
      - 'null'
      - string
    doc: stop qhull after building cone for point n (see TVn) (value n after the option letters)
    inputBinding:
      position: 1
      prefix: TC
      separate: false
  - id: opt_C_value
    type:
      - 'null'
      - string
    doc: radius of centrum (roundoff added). Merge facets if non-convex (value n after the option letters)
    inputBinding:
      position: 1
      prefix: C
      separate: false
  - id: opt_A_value
    type:
      - 'null'
      - string
    doc: 'cosine of maximum angle. Merge facets if cosine > n or non-convex (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: A
      separate: false
  - id: opt_R_value
    type:
      - 'null'
      - string
    doc: 'randomly perturb computations by a factor of [1-n,1+n] (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: R
      separate: false
  - id: opt_W_value
    type:
      - 'null'
      - string
    doc: min facet width for non-coincident point (before roundoff) (value n after the option letters)
    inputBinding:
      position: 1
      prefix: W
      separate: false
  - id: opt_s
    type:
      - 'null'
      - boolean
    doc: summary to stderr
    inputBinding:
      position: 1
      prefix: s
  - id: opt_p
    type:
      - 'null'
      - boolean
    doc: Voronoi vertices
    inputBinding:
      position: 1
      prefix: p
  - id: opt_o
    type:
      - 'null'
      - boolean
    doc: 'OFF format (dim, Voronoi vertices, and Voronoi regions)'
    inputBinding:
      position: 1
      prefix: o
  - id: opt_i
    type:
      - 'null'
      - boolean
    doc: 'Delaunay regions (use ''Pp'' to avoid warning)'
    inputBinding:
      position: 1
      prefix: i
  - id: opt_f
    type:
      - 'null'
      - boolean
    doc: facet dump
    inputBinding:
      position: 1
      prefix: f
  - id: opt_Fc
    type:
      - 'null'
      - boolean
    doc: count plus coincident points (by Voronoi vertex)
    inputBinding:
      position: 1
      prefix: Fc
  - id: opt_Fd
    type:
      - 'null'
      - boolean
    doc: use cdd format for input (homogeneous with offset first)
    inputBinding:
      position: 1
      prefix: Fd
  - id: opt_FD
    type:
      - 'null'
      - boolean
    doc: use cdd format for output (offset first)
    inputBinding:
      position: 1
      prefix: FD
  - id: opt_FF
    type:
      - 'null'
      - boolean
    doc: facet dump without ridges
    inputBinding:
      position: 1
      prefix: FF
  - id: opt_Fi
    type:
      - 'null'
      - boolean
    doc: separating hyperplanes for bounded Voronoi regions
    inputBinding:
      position: 1
      prefix: Fi
  - id: opt_FI
    type:
      - 'null'
      - boolean
    doc: ID for each Voronoi vertex
    inputBinding:
      position: 1
      prefix: FI
  - id: opt_Fm
    type:
      - 'null'
      - boolean
    doc: merge count for each Voronoi vertex (511 max)
    inputBinding:
      position: 1
      prefix: Fm
  - id: opt_Fn
    type:
      - 'null'
      - boolean
    doc: count plus neighboring Voronoi vertices for each Voronoi vertex
    inputBinding:
      position: 1
      prefix: Fn
  - id: opt_FN
    type:
      - 'null'
      - boolean
    doc: count and Voronoi vertices for each Voronoi region
    inputBinding:
      position: 1
      prefix: FN
  - id: opt_Fo
    type:
      - 'null'
      - boolean
    doc: separating hyperplanes for unbounded Voronoi regions
    inputBinding:
      position: 1
      prefix: Fo
  - id: opt_FO
    type:
      - 'null'
      - boolean
    doc: options and precision constants
    inputBinding:
      position: 1
      prefix: FO
  - id: opt_FP
    type:
      - 'null'
      - boolean
    doc: nearest point and distance for each coincident point
    inputBinding:
      position: 1
      prefix: FP
  - id: opt_FQ
    type:
      - 'null'
      - boolean
    doc: command used for qvoronoi
    inputBinding:
      position: 1
      prefix: FQ
  - id: opt_Fs
    type:
      - 'null'
      - boolean
    doc: 'summary: #int (8), dimension, #points, tot vertices, tot facets,'
    inputBinding:
      position: 1
      prefix: Fs
  - id: opt_Fv
    type:
      - 'null'
      - boolean
    doc: Voronoi diagram as Voronoi vertices between adjacent input sites
    inputBinding:
      position: 1
      prefix: Fv
  - id: opt_Fx
    type:
      - 'null'
      - boolean
    doc: extreme points of Delaunay triangulation (on convex hull)
    inputBinding:
      position: 1
      prefix: Fx
  - id: opt_Ga
    type:
      - 'null'
      - boolean
    doc: all points as dots
    inputBinding:
      position: 1
      prefix: Ga
  - id: opt_Gp
    type:
      - 'null'
      - boolean
    doc: coplanar points and vertices as radii
    inputBinding:
      position: 1
      prefix: Gp
  - id: opt_Gv
    type:
      - 'null'
      - boolean
    doc: vertices as spheres
    inputBinding:
      position: 1
      prefix: Gv
  - id: opt_Gi
    type:
      - 'null'
      - boolean
    doc: inner planes only
    inputBinding:
      position: 1
      prefix: Gi
  - id: opt_Gn
    type:
      - 'null'
      - boolean
    doc: no planes
    inputBinding:
      position: 1
      prefix: Gn
  - id: opt_Go
    type:
      - 'null'
      - boolean
    doc: outer planes only
    inputBinding:
      position: 1
      prefix: Go
  - id: opt_Gc
    type:
      - 'null'
      - boolean
    doc: centrums
    inputBinding:
      position: 1
      prefix: Gc
  - id: opt_Gh
    type:
      - 'null'
      - boolean
    doc: hyperplane intersections
    inputBinding:
      position: 1
      prefix: Gh
  - id: opt_Gr
    type:
      - 'null'
      - boolean
    doc: ridges
    inputBinding:
      position: 1
      prefix: Gr
  - id: opt_GD_value
    type:
      - 'null'
      - string
    doc: drop dimension n in 3-d and 4-d output (value n after the option letters)
    inputBinding:
      position: 1
      prefix: GD
      separate: false
  - id: opt_PA_value
    type:
      - 'null'
      - string
    doc: 'keep n largest Voronoi vertices by ''area'' (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: PA
      separate: false
  - id: opt_Pg
    type:
      - 'null'
      - boolean
    doc: 'print good Voronoi vertices (needs ''QGn'' or ''QVn'')'
    inputBinding:
      position: 1
      prefix: Pg
  - id: opt_PF_value
    type:
      - 'null'
      - string
    doc: 'keep Voronoi vertices whose ''area'' is at least n (value n after the option letters)'
    inputBinding:
      position: 1
      prefix: PF
      separate: false
  - id: opt_PG
    type:
      - 'null'
      - boolean
    doc: print neighbors of good Voronoi vertices
    inputBinding:
      position: 1
      prefix: PG
  - id: opt_PM_value
    type:
      - 'null'
      - string
    doc: keep n Voronoi vertices with most merges (value n after the option letters)
    inputBinding:
      position: 1
      prefix: PM
      separate: false
  - id: opt_Po
    type:
      - 'null'
      - boolean
    doc: 'force output. If error, output neighborhood of facet'
    inputBinding:
      position: 1
      prefix: Po
  - id: opt_Pp
    type:
      - 'null'
      - boolean
    doc: do not report precision problems
    inputBinding:
      position: 1
      prefix: Pp
  - id: opt_TI
    type:
      - 'null'
      - File
    doc: input data from file, no spaces or single quotes
    inputBinding:
      position: 1
      prefix: TI
  - id: opt_TO
    type:
      - 'null'
      - string
    doc: output results to file, no spaces or single quotes
    inputBinding:
      position: 1
      prefix: TO
  - id: extra_options
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Further options given as complete tokens, for example Qb0:-1 : Pdk:n (drop facet if normal[k] <= n (default 0.0)); PDk:n (drop facet if normal[k] >= n)'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (summary with option s)
  - id: output_file
    type:
      - 'null'
      - File
    doc: file written with the TO option
    outputBinding:
      glob: $(inputs.opt_TO)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdin: $(inputs.points.path)
stdout: qhull_qvoronoi.out
stderr: qhull_qvoronoi.err
