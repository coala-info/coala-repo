# qhull CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| qhull | PASS | synthetic data: points made with rbox (unit cube or 60 points on a sphere); hull counts and area match the known values |
| qhull_qconvex | PASS | synthetic data: points made with rbox (unit cube or 60 points on a sphere); hull counts and area match the known values |
| qhull_qdelaunay | PASS | synthetic data: points made with rbox (unit cube or 60 points on a sphere); hull counts and area match the known values |
| qhull_qhalf | PASS | synthetic data: halfspaces of a unit cube; gives its 8 corners |
| qhull_qvoronoi | PASS | synthetic data: points made with rbox (unit cube or 60 points on a sphere); hull counts and area match the known values |
| qhull_rbox | PASS | synthetic data: generates the unit cube and random sphere points as expected |

## qhull

### Tool Description
Qhull computes the convex hull, Delaunay triangulation, Voronoi diagram, half-space intersection and the medial axis of points, line segments and triangles.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/qhull/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qhull/qhull
- **Stars**: N/A
### Original Help Text
```text
qhull- compute convex hulls and related structures.
    http://www.qhull.org  2015.2.r 2016/01/18

input (stdin):
    first lines: dimension and number of points (or vice-versa).
    other lines: point coordinates, best if one point per line
    comments:    start with a non-numeric character
    halfspaces:  use dim plus one and put offset after coefficients.
                 May be preceded by a single interior point ('H').

options:
    d    - Delaunay triangulation by lifting points to a paraboloid
    d Qu - furthest-site Delaunay triangulation (upper convex hull)
    v    - Voronoi diagram (dual of the Delaunay triangulation)
    v Qu - furthest-site Voronoi diagram
    Hn,n,... - halfspace intersection about point [n,n,0,...]
    Qt   - triangulated output
    QJ   - joggled input instead of merged facets
    Qc   - keep coplanar points with nearest facet
    Qi   - keep interior points with nearest facet

Qhull control options:
    Qbk:n   - scale coord k so that low bound is n
      QBk:n - scale coord k so that upper bound is n (QBk is 0.5)
    QbB  - scale input to unit cube centered at the origin
    Qbb  - scale last coordinate to [0,m] for Delaunay triangulations
    Qbk:0Bk:0 - remove k-th coordinate from input
    QJn  - randomly joggle input in range [-n,n]
    QRn  - random rotation (n=seed, n=0 time, n=-1 time/no rotate)
    Qf   - partition point to furthest outside facet
    Qg   - only build good facets (needs 'QGn', 'QVn', or 'PdD')
    Qm   - only process points that would increase max_outside
    Qr   - process random outside points instead of furthest ones
    Qs   - search all points for the initial simplex
    Qu   - for 'd' or 'v', compute upper hull without point at-infinity
              returns furthest-site Delaunay triangulation
    Qv   - test vertex neighbors for convexity
    Qx   - exact pre-merges (skips coplanar and angle-coplanar facets)
    Qz   - add point-at-infinity to Delaunay triangulation
    QGn  - good facet if visible from point n, -n for not visible
    QVn  - good facet if it includes point n, -n if not
    Q0   - turn off default premerge with 'C-0'/'Qx'
    Q1     - sort merges by type instead of angle
    Q2   - merge all non-convex at once instead of independent sets
    Q3   - do not merge redundant vertices
    Q4   - avoid old->new merges
    Q5   - do not correct outer planes at end of qhull
    Q6   - do not pre-merge concave or coplanar facets
    Q7   - depth-first processing instead of breadth-first
    Q8   - do not process near-inside points
    Q9   - process furthest of furthest points
    Q10  - no special processing for narrow distributions
    Q11  - copy normals and recompute centrums for tricoplanar facets
    Q12  - no error on wide merge due to duplicate ridge

Topts- Trace options:
    T4   - trace at level n, 4=all, 5=mem/gauss, -1= events
    Ta   - annotate output with message codes
    Tc   - check frequently during execution
    Ts   - print statistics
    Tv   - verify result: structure, convexity, and point inclusion
    Tz   - send all output to stdout
    TFn  - report summary when n or more facets created
    TI file - input data from file, no spaces or single quotes
    TO file - output results to file, may be enclosed in single quotes
    TPn  - turn on tracing when point n added to hull
     TMn - turn on tracing at merge n
     TWn - trace merge facets when width > n
    TRn  - rerun qhull n times.  Use with 'QJn'
    TVn  - stop qhull after adding point n, -n for before (see TCn)
     TCn - stop qhull after building cone for point n (see TVn)

Precision options:
    Cn   - radius of centrum (roundoff added).  Merge facets if non-convex
     An  - cosine of maximum angle.  Merge facets if cosine > n or non-convex
           C-0 roundoff, A-0.99/C-0.01 pre-merge, A0.99/C0.01 post-merge
    En   - max roundoff error for distance computation
    Rn   - randomly perturb computations by a factor of [1-n,1+n]
    Vn   - min distance above plane for a visible facet (default 3C-n or En)
    Un   - max distance below plane for a new, coplanar point (default Vn)
    Wn   - min facet width for outside point (before roundoff, default 2Vn)

Output formats (may be combined; if none, produces a summary to stdout):
    f    - facet dump
    G    - Geomview output (see below)
    i    - vertices incident to each facet
    m    - Mathematica output (2-d and 3-d)
    o    - OFF format (dim, points and facets; Voronoi regions)
    n    - normals with offsets
    p    - vertex coordinates or Voronoi vertices (coplanar points if 'Qc')
    s    - summary (stderr)

More formats:
    Fa   - area for each facet
    FA   - compute total area and volume for option 's'
    Fc   - count plus coplanar points for each facet
           use 'Qc' (default) for coplanar and 'Qi' for interior
    FC   - centrum or Voronoi center for each facet
    Fd   - use cdd format for input (homogeneous with offset first)
    FD   - use cdd format for numeric output (offset first)
    FF   - facet dump without ridges
    Fi   - inner plane for each facet
           for 'v', separating hyperplanes for bounded Voronoi regions
    FI   - ID of each facet
    Fm   - merge count for each facet (511 max)
    FM   - Maple output (2-d and 3-d)
    Fn   - count plus neighboring facets for each facet
    FN   - count plus neighboring facets for each point
    Fo   - outer plane (or max_outside) for each facet
           for 'v', separating hyperplanes for unbounded Voronoi regions
    FO   - options and precision constants
    Fp   - dim, count, and intersection coordinates (halfspace only)
    FP   - nearest vertex and distance for each coplanar point
    FQ   - command used for qhull
    Fs   - summary: #int (8), dimension, #points, tot vertices, tot facets,
                      output: #vertices, #facets, #coplanars, #nonsimplicial
                    #real (2), max outer plane, min vertex
    FS   - sizes:   #int (0)
                    #real (2) tot area, tot volume
    Ft   - triangulation with centrums for non-simplicial facets (OFF format)
    Fv   - count plus vertices for each facet
           for 'v', Voronoi diagram as Voronoi vertices for pairs of sites
    FV   - average of vertices (a feasible point for 'H')
    Fx   - extreme points (in order for 2-d)

Geomview options (2-d, 3-d, and 4-d; 2-d Voronoi)
    Ga   - all points as dots
     Gp  -  coplanar points and vertices as radii
     Gv  -  vertices as spheres
    Gi   - inner planes only
     Gn  -  no planes
     Go  -  outer planes only
    Gc   - centrums
    Gh   - hyperplane intersections
    Gr   - ridges
    GDn  - drop dimension n in 3-d and 4-d output
    Gt   - for 3-d 'd', transparent outer ridges

Print options:
    PAn  - keep n largest facets by area
    Pdk:n - drop facet if normal[k] <= n (default 0.0)
    PDk:n - drop facet if normal[k] >= n
    Pg   - print good facets (needs 'QGn' or 'QVn')
    PFn  - keep facets whose area is at least n
    PG   - print neighbors of good facets
    PMn  - keep n facets with most merges
    Po   - force output.  If error, output neighborhood of facet
    Pp   - do not report precision problems

    .    - list of all options
    -    - one line descriptions of all options
    -V   - version
```

## qhull_qconvex

### Tool Description
qconvex computes the convex hull of points.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: https://anaconda.org/channels/bioconda/packages/qhull/overview
- **Validation**: PASS

### Original Help Text
```text
qconvex- compute the convex hull
    http://www.qhull.org  2015.2 2016/01/18

input (stdin):
    first lines: dimension and number of points (or vice-versa).
    other lines: point coordinates, best if one point per line
    comments:    start with a non-numeric character

options:
    Qt   - triangulated output
    QJ   - joggled input instead of merged facets
    Qc   - keep coplanar points with nearest facet
    Qi   - keep interior points with nearest facet

Qhull control options:
    Qbk:n   - scale coord k so that low bound is n
      QBk:n - scale coord k so that upper bound is n (QBk is 0.5)
    QbB  - scale input to unit cube centered at the origin
    Qbk:0Bk:0 - remove k-th coordinate from input
    QJn  - randomly joggle input in range [-n,n]
    QRn  - random rotation (n=seed, n=0 time, n=-1 time/no rotate)
    Qs   - search all points for the initial simplex
    QGn  - good facet if visible from point n, -n for not visible
    QVn  - good facet if it includes point n, -n if not

Trace options:
    T4   - trace at level n, 4=all, 5=mem/gauss, -1= events
    Tc   - check frequently during execution
    Ts   - print statistics
    Tv   - verify result: structure, convexity, and point inclusion
    Tz   - send all output to stdout
    TFn  - report summary when n or more facets created
    TI file - input data from file, no spaces or single quotes
    TO file - output results to file, may be enclosed in single quotes
    TPn  - turn on tracing when point n added to hull
     TMn - turn on tracing at merge n
     TWn - trace merge facets when width > n
    TVn  - stop qhull after adding point n, -n for before (see TCn)
     TCn - stop qhull after building cone for point n (see TVn)

Precision options:
    Cn   - radius of centrum (roundoff added).  Merge facets if non-convex
     An  - cosine of maximum angle.  Merge facets if cosine > n or non-convex
           C-0 roundoff, A-0.99/C-0.01 pre-merge, A0.99/C0.01 post-merge
    Rn   - randomly perturb computations by a factor of [1-n,1+n]
    Un   - max distance below plane for a new, coplanar point
    Wn   - min facet width for outside point (before roundoff)

Output formats (may be combined; if none, produces a summary to stdout):
    f    - facet dump
    G    - Geomview output (see below)
    i    - vertices incident to each facet
    m    - Mathematica output (2-d and 3-d)
    n    - normals with offsets
    o    - OFF file format (dim, points and facets; Voronoi regions)
    p    - point coordinates 
    s    - summary (stderr)

More formats:
    Fa   - area for each facet
    FA   - compute total area and volume for option 's'
    Fc   - count plus coplanar points for each facet
           use 'Qc' (default) for coplanar and 'Qi' for interior
    FC   - centrum for each facet
    Fd   - use cdd format for input (homogeneous with offset first)
    FD   - use cdd format for numeric output (offset first)
    FF   - facet dump without ridges
    Fi   - inner plane for each facet
    FI   - ID for each facet
    Fm   - merge count for each facet (511 max)
    Fn   - count plus neighboring facets for each facet
    FN   - count plus neighboring facets for each point
    Fo   - outer plane (or max_outside) for each facet
    FO   - options and precision constants
    FP   - nearest vertex for each coplanar point
    FQ   - command used for qconvex
    Fs   - summary: #int (8), dimension, #points, tot vertices, tot facets,
                      for output: #vertices, #facets,
                                  #coplanar points, #non-simplicial facets
                    #real (2), max outer plane, min vertex
    FS   - sizes:   #int (0) 
                    #real (2) tot area, tot volume
    Ft   - triangulation with centrums for non-simplicial facets (OFF format)
    Fv   - count plus vertices for each facet
    FV   - average of vertices (a feasible point for 'H')
    Fx   - extreme points (in order for 2-d)

Geomview output (2-d, 3-d, and 4-d)
    Ga   - all points as dots
     Gp  -  coplanar points and vertices as radii
     Gv  -  vertices as spheres
    Gi   - inner planes only
     Gn  -  no planes
     Go  -  outer planes only
    Gc   - centrums
    Gh   - hyperplane intersections
    Gr   - ridges
    GDn  - drop dimension n in 3-d and 4-d output

Print options:
    PAn  - keep n largest facets by area
    Pdk:n - drop facet if normal[k] <= n (default 0.0)
    PDk:n - drop facet if normal[k] >= n
    Pg   - print good facets (needs 'QGn' or 'QVn')
    PFn  - keep facets whose area is at least n
    PG   - print neighbors of good facets
    PMn  - keep n facets with most merges
    Po   - force output.  If error, output neighborhood of facet
    Pp   - do not report precision problems

    .    - list of all options
    -    - one line descriptions of all options
    -V   - version
```

## qhull_qdelaunay

### Tool Description
qdelaunay computes the Delaunay triangulation of points.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: https://anaconda.org/channels/bioconda/packages/qhull/overview
- **Validation**: PASS

### Original Help Text
```text
qdelaunay- compute the Delaunay triangulation
    http://www.qhull.org  2015.2 2016/01/18

input (stdin):
    first lines: dimension and number of points (or vice-versa).
    other lines: point coordinates, best if one point per line
    comments:    start with a non-numeric character

options:
    Qu   - compute furthest-site Delaunay triangulation
    Qt   - triangulated output
    QJ   - joggled input instead of merged facets

Qhull control options:
    QJn  - randomly joggle input in range [-n,n]
    Qs   - search all points for the initial simplex
    Qz   - add point-at-infinity to Delaunay triangulation
    QGn  - print Delaunay region if visible from point n, -n if not
    QVn  - print Delaunay regions that include point n, -n if not

Trace options:
    T4   - trace at level n, 4=all, 5=mem/gauss, -1= events
    Tc   - check frequently during execution
    Ts   - print statistics
    Tv   - verify result: structure, convexity, and in-circle test
    Tz   - send all output to stdout
    TFn  - report summary when n or more facets created
    TI file - input data from file, no spaces or single quotes
    TO file - output results to file, may be enclosed in single quotes
    TPn  - turn on tracing when point n added to hull
     TMn - turn on tracing at merge n
     TWn - trace merge facets when width > n
    TVn  - stop qhull after adding point n, -n for before (see TCn)
     TCn - stop qhull after building cone for point n (see TVn)

Precision options:
    Cn   - radius of centrum (roundoff added).  Merge facets if non-convex
     An  - cosine of maximum angle.  Merge facets if cosine > n or non-convex
           C-0 roundoff, A-0.99/C-0.01 pre-merge, A0.99/C0.01 post-merge
    Rn   - randomly perturb computations by a factor of [1-n,1+n]
    Wn   - min facet width for outside point (before roundoff)

Output formats (may be combined; if none, produces a summary to stdout):
    f    - facet dump
    G    - Geomview output (see below)
    i    - vertices incident to each Delaunay region
    m    - Mathematica output (2-d only, lifted to a paraboloid)
    o    - OFF format (dim, points, and facets as a paraboloid)
    p    - point coordinates (lifted to a paraboloid)
    s    - summary (stderr)

More formats:
    Fa   - area for each Delaunay region
    FA   - compute total area for option 's'
    Fc   - count plus coincident points for each Delaunay region
    Fd   - use cdd format for input (homogeneous with offset first)
    FD   - use cdd format for numeric output (offset first)
    FF   - facet dump without ridges
    FI   - ID of each Delaunay region
    Fm   - merge count for each Delaunay region (511 max)
    FM   - Maple output (2-d only, lifted to a paraboloid)
    Fn   - count plus neighboring region for each Delaunay region
    FN   - count plus neighboring region for each point
    FO   - options and precision constants
    FP   - nearest point and distance for each coincident point
    FQ   - command used for qdelaunay
    Fs   - summary: #int (8), dimension, #points, tot vertices, tot facets,
                    for output: #vertices, #Delaunay regions,
                                #coincident points, #non-simplicial regions
                    #real (2), max outer plane, min vertex
    FS   - sizes:   #int (0)
                    #real (2), tot area, 0
    Fv   - count plus vertices for each Delaunay region
    Fx   - extreme points of Delaunay triangulation (on convex hull)

Geomview options (2-d and 3-d)
    Ga   - all points as dots
     Gp  -  coplanar points and vertices as radii
     Gv  -  vertices as spheres
    Gi   - inner planes only
     Gn  -  no planes
     Go  -  outer planes only
    Gc     - centrums
    Gh   - hyperplane intersections
    Gr   - ridges
    GDn  - drop dimension n in 3-d and 4-d output
    Gt   - transparent outer ridges to view 3-d Delaunay

Print options:
    PAn  - keep n largest Delaunay regions by area
    Pdk:n - drop facet if normal[k] <= n (default 0.0)
    PDk:n - drop facet if normal[k] >= n
    Pg   - print good Delaunay regions (needs 'QGn' or 'QVn')
    PFn  - keep Delaunay regions whose area is at least n
    PG   - print neighbors of good regions (needs 'QGn' or 'QVn')
    PMn  - keep n Delaunay regions with most merges
    Po   - force output.  If error, output neighborhood of facet
    Pp   - do not report precision problems

    .    - list of all options
    -    - one line descriptions of all options
    -V   - version
```

## qhull_qvoronoi

### Tool Description
qvoronoi computes the Voronoi diagram of points.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: https://anaconda.org/channels/bioconda/packages/qhull/overview
- **Validation**: PASS

### Original Help Text
```text
qvoronoi- compute the Voronoi diagram
    http://www.qhull.org  2015.2 2016/01/18

input (stdin):
    first lines: dimension and number of points (or vice-versa).
    other lines: point coordinates, best if one point per line
    comments:    start with a non-numeric character

options:
    Qu   - compute furthest-site Voronoi diagram

Qhull control options:
    Qz   - add point-at-infinity to Voronoi diagram
    Qs   - search all points for the initial simplex
    QGn  - Voronoi vertices if visible from point n, -n if not
    QVn  - Voronoi vertices for input point n, -n if not

Trace options:
    T4   - trace at level n, 4=all, 5=mem/gauss, -1= events
    Tc   - check frequently during execution
    Ts   - statistics
    Tv   - verify result: structure, convexity, and in-circle test
    Tz   - send all output to stdout
    TFn  - report summary when n or more facets created
    TI file - input data from file, no spaces or single quotes
    TO file - output results to file, may be enclosed in single quotes
    TPn  - turn on tracing when point n added to hull
     TMn - turn on tracing at merge n
     TWn - trace merge facets when width > n
    TVn  - stop qhull after adding point n, -n for before (see TCn)
     TCn - stop qhull after building cone for point n (see TVn)

Precision options:
    Cn   - radius of centrum (roundoff added).  Merge facets if non-convex
     An  - cosine of maximum angle.  Merge facets if cosine > n or non-convex
           C-0 roundoff, A-0.99/C-0.01 pre-merge, A0.99/C0.01 post-merge
    Rn   - randomly perturb computations by a factor of [1-n,1+n]
    Wn   - min facet width for non-coincident point (before roundoff)

Output formats (may be combined; if none, produces a summary to stdout):
    s    - summary to stderr
    p    - Voronoi vertices
    o    - OFF format (dim, Voronoi vertices, and Voronoi regions)
    i    - Delaunay regions (use 'Pp' to avoid warning)
    f    - facet dump

More formats:
    Fc   - count plus coincident points (by Voronoi vertex)
    Fd   - use cdd format for input (homogeneous with offset first)
    FD   - use cdd format for output (offset first)
    FF   - facet dump without ridges
    Fi   - separating hyperplanes for bounded Voronoi regions
    FI   - ID for each Voronoi vertex
    Fm   - merge count for each Voronoi vertex (511 max)
    Fn   - count plus neighboring Voronoi vertices for each Voronoi vertex
    FN   - count and Voronoi vertices for each Voronoi region
    Fo   - separating hyperplanes for unbounded Voronoi regions
    FO   - options and precision constants
    FP   - nearest point and distance for each coincident point
    FQ   - command used for qvoronoi
    Fs   - summary: #int (8), dimension, #points, tot vertices, tot facets,
                    for output: #Voronoi regions, #Voronoi vertices,
                                #coincident points, #non-simplicial regions
                    #real (2), max outer plane and min vertex
    Fv   - Voronoi diagram as Voronoi vertices between adjacent input sites
    Fx   - extreme points of Delaunay triangulation (on convex hull)

Geomview options (2-d only)
    Ga   - all points as dots
     Gp  -  coplanar points and vertices as radii
     Gv  -  vertices as spheres
    Gi   - inner planes only
     Gn  -  no planes
     Go  -  outer planes only
    Gc   - centrums
    Gh   - hyperplane intersections
    Gr   - ridges
    GDn  - drop dimension n in 3-d and 4-d output

Print options:
    PAn  - keep n largest Voronoi vertices by 'area'
    Pdk:n - drop facet if normal[k] <= n (default 0.0)
    PDk:n - drop facet if normal[k] >= n
    Pg   - print good Voronoi vertices (needs 'QGn' or 'QVn')
    PFn  - keep Voronoi vertices whose 'area' is at least n
    PG   - print neighbors of good Voronoi vertices
    PMn  - keep n Voronoi vertices with most merges
    Po   - force output.  If error, output neighborhood of facet
    Pp   - do not report precision problems

    .    - list of all options
    -    - one line descriptions of all options
    -V   - version
```

## qhull_qhalf

### Tool Description
qhalf computes the intersection of halfspaces about a point.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: https://anaconda.org/channels/bioconda/packages/qhull/overview
- **Validation**: PASS

### Original Help Text
```text
qhalf- compute the intersection of halfspaces about a point
    http://www.qhull.org  2015.2 2016/01/18

input (stdin):
    optional interior point: dimension, 1, coordinates
    first lines: dimension+1 and number of halfspaces
    other lines: halfspace coefficients followed by offset
    comments:    start with a non-numeric character

options:
    Hn,n - specify coordinates of interior point
    Qt   - triangulated output
    QJ   - joggled input instead of merged facets
    Qc   - keep coplanar halfspaces
    Qi   - keep other redundant halfspaces

Qhull control options:
    QJn  - randomly joggle input in range [-n,n]
    Qbk:0Bk:0 - remove k-th coordinate from input
    Qs   - search all halfspaces for the initial simplex
    QGn  - print intersection if visible to halfspace n, -n for not
    QVn  - print intersections for halfspace n, -n if not

Trace options:
    T4   - trace at level n, 4=all, 5=mem/gauss, -1= events
    Tc   - check frequently during execution
    Ts   - print statistics
    Tv   - verify result: structure, convexity, and redundancy
    Tz   - send all output to stdout
    TFn  - report summary when n or more facets created
    TI file - input data from file, no spaces or single quotes
    TO file - output results to file, may be enclosed in single quotes
    TPn  - turn on tracing when halfspace n added to intersection
    TMn  - turn on tracing at merge n
    TWn  - trace merge facets when width > n
    TVn  - stop qhull after adding halfspace n, -n for before (see TCn)
    TCn  - stop qhull after building cone for halfspace n (see TVn)

Precision options:
    Cn   - radius of centrum (roundoff added).  Merge facets if non-convex
     An  - cosine of maximum angle.  Merge facets if cosine > n or non-convex
           C-0 roundoff, A-0.99/C-0.01 pre-merge, A0.99/C0.01 post-merge
    Rn   - randomly perturb computations by a factor of [1-n,1+n]
    Un   - max distance below plane for a new, coplanar halfspace
    Wn   - min facet width for outside halfspace (before roundoff)

Output formats (may be combined; if none, produces a summary to stdout):
    f    - facet dump
    G    - Geomview output (dual convex hull)
    i    - non-redundant halfspaces incident to each intersection
    m    - Mathematica output (dual convex hull)
    o    - OFF format (dual convex hull: dimension, points, and facets)
    p    - vertex coordinates of dual convex hull (coplanars if 'Qc' or 'Qi')
    s    - summary (stderr)

More formats:
    Fc   - count plus redundant halfspaces for each intersection
         -   Qc (default) for coplanar and Qi for other redundant
    Fd   - use cdd format for input (homogeneous with offset first)
    FF   - facet dump without ridges
    FI   - ID of each intersection
    Fm   - merge count for each intersection (511 max)
    FM   - Maple output (dual convex hull)
    Fn   - count plus neighboring intersections for each intersection
    FN   - count plus intersections for each non-redundant halfspace
    FO   - options and precision constants
    Fp   - dim, count, and intersection coordinates
    FP   - nearest halfspace and distance for each redundant halfspace
    FQ   - command used for qhalf
    Fs   - summary: #int (8), dim, #halfspaces, #non-redundant, #intersections
                      for output: #non-redundant, #intersections, #coplanar
                                  halfspaces, #non-simplicial intersections
                    #real (2), max outer plane, min vertex
    Fv   - count plus non-redundant halfspaces for each intersection
    Fx   - non-redundant halfspaces

Geomview output (2-d, 3-d and 4-d; dual convex hull)
    Ga   - all points (i.e., transformed halfspaces) as dots
     Gp  -  coplanar points and vertices as radii
     Gv  -  vertices (i.e., non-redundant halfspaces) as spheres
    Gi   - inner planes (i.e., halfspace intersections) only
     Gn  -  no planes
     Go  -  outer planes only
    Gc   - centrums
    Gh   - hyperplane intersections
    Gr   - ridges
    GDn  - drop dimension n in 3-d and 4-d output

Print options:
    PAn  - keep n largest facets (i.e., intersections) by area
    Pdk:n- drop facet if normal[k] <= n (default 0.0)
    PDk:n- drop facet if normal[k] >= n
    Pg   - print good facets (needs 'QGn' or 'QVn')
    PFn  - keep facets whose area is at least n
    PG   - print neighbors of good facets
    PMn  - keep n facets with most merges
    Po   - force output.  If error, output neighborhood of facet
    Pp   - do not report precision problems

    .    - list of all options
    -    - one line descriptions of all options
    -V   - version
```

## qhull_rbox

### Tool Description
rbox generates various point distributions as input for the Qhull programs.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhull:2015.2--h2d50403_0
- **Homepage**: https://github.com/qhull/qhull
- **Package**: https://anaconda.org/channels/bioconda/packages/qhull/overview
- **Validation**: PASS

### Original Help Text
```text
-rbox- generate various point distributions.  Default is random in cube.

args (any order, space separated):                    Version: 2016/01/18
  3000    number of random points in cube, lens, spiral, sphere or grid
  D3      dimension 3-d
  c       add a unit cube to the output ('c G2.0' sets size)
  d       add a unit diamond to the output ('d G2.0' sets size)
  l       generate a regular 3-d spiral
  r       generate a regular polygon, ('r s Z1 G0.1' makes a cone)
  s       generate cospherical points
  x       generate random points in simplex, may use 'r' or 'Wn'
  y       same as 'x', plus simplex
  Cn,r,m  add n nearly coincident points within radius r of m points
  Pn,m,r  add point [n,m,r] first, pads with 0, maybe repeated

  Ln      lens distribution of radius n.  Also 's', 'r', 'G', 'W'.
  Mn,m,r  lattice(Mesh) rotated by [n,-m,0], [m,n,0], [0,0,r], ...
          '27 M1,0,1' is {0,1,2} x {0,1,2} x {0,1,2}.  Try 'M3,4 z'.
  W0.1    random distribution within 0.1 of the cube's or sphere's surface
  Z0.5 s  random points in a 0.5 disk projected to a sphere
  Z0.5 s G0.6 same as Z0.5 within a 0.6 gap

  Bn      bounding box coordinates, default 0.5
  h       output as homogeneous coordinates for cdd
  n       remove command line from the first line of output
  On      offset coordinates by n
  t       use time as the random number seed(default is command line)
  tn      use n as the random number seed
  z       print integer coordinates, default 'Bn' is 1e+06
```
