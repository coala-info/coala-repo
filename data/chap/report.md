# chap CWL Generation Report

## chap

### Tool Description
CHAP finds pores in biological macromolecules like ion channels and determines the hydration state of these permeation pathways. It can operate on both individual structures and on molecular dynamics trajectories. Visit www.channotation.org for the full documentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/chap:0.9.1--h2df963e_2
- **Homepage**: https://github.com/channotation/chap
- **Package**: https://anaconda.org/channels/bioconda/packages/chap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chap/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/channotation/chap
- **Stars**: N/A
### Original Help Text
```text
CCCCCC  HH     HH    AAA    PPPPPPPP  
		CC    CC HH     HH   AA AA   PP     PP 
		CC       HH     HH  AA   AA  PP     PP 
		CC       HHHHHHHHH AA     AA PPPPPPPP  
		CC       HH     HH AAAAAAAAA PP        
		CC    CC HH     HH AA     AA PP        
 		 CCCCCC  HH     HH AA     AA PP        

             The Channel Annotation Package, version 0.9.1

SYNOPSIS

chap [-f [<.xtc/.trr/...>]] [-s [<.tpr/.gro/...>]] [-n [<.ndx>]] [-b <time>]
     [-e <time>] [-dt <time>] [-tu <enum>] [-fgroup <selection>]
     [-xvg <enum>] [-sf <file>] [-selrpos <enum>] [-seltype <enum>]
     [-sel-pathway <selection>] [-sel-solvent <selection>]
     [-out-filename <string>] [-out-num-points <int>]
     [-out-extrap-dist <real>] [-out-grid-dist <real>]
     [-out-vis-tweak <real>] [-[no]out-detailed] [-pf-method <enum>]
     [-pf-vdwr-database <enum>] [-pf-vdwr-fallback <real>]
     [-pf-vdwr-json <string>] [-pf-align-method <enum>]
     [-pf-probe-step <real>] [-pf-max-free-dist <real>]
     [-pf-max-probe-steps <int>] [-pf-sel-ipp <selection>]
     [-pf-init-probe-pos <real>] [-pf-chan-dir-vec <real>]
     [-pf-cutoff <real>] [-sa-seed <int>] [-sa-max-iter <int>]
     [-sa-init-temp <real>] [-sa-cooling-fac <real>] [-sa-step <real>]
     [-nm-max-iter <int>] [-nm-init-shift <real>] [-pm-pl-margin <real>]
     [-pm-pf-sel <string>] [-de-method <enum>] [-de-res <real>]
     [-de-bandwidth <real>] [-de-bw-scale <real>] [-de-eval-cutoff <real>]
     [-hydrophob-database <enum>] [-hydrophob-fallback <real>]
     [-hydrophob-json <string>] [-hydrophob-bandwidth <real>]

DESCRIPTION

CHAP finds pores in biological macromolecules like ion channels and determines
the hydration state of these permeation pathways. It can operate on both
individual structures and on molecular dynamics trajectories. Visit
www.channotation.org for the full documentation.

OPTIONS

Options to specify input files:

 -f      [<.xtc/.trr/...>]  (traj.xtc)       (Opt.)
           Input trajectory or single configuration: xtc trr cpt gro g96 pdb
           tng
 -s      [<.tpr/.gro/...>]  (topol.tpr)      (Opt.)
           Input structure: tpr gro g96 pdb brk ent
 -n      [<.ndx>]           (index.ndx)      (Opt.)
           Extra index groups

Other options:

 -b      <time>             (0)
           First frame (ps) to read from trajectory
 -e      <time>             (0)
           Last frame (ps) to read from trajectory
 -dt     <time>             (0)
           Only use frame if t MOD dt == first time (ps)
 -tu     <enum>             (ps)
           Unit for time values: fs, ps, ns, us, ms, s
 -fgroup <selection>
           Atoms stored in the trajectory file (if not set, assume first N
           atoms)
 -xvg    <enum>             (xmgrace)
           Plot formatting: none, xmgrace, xmgr
 -sf     <file>
           Provide selections from files
 -selrpos <enum>            (atom)
           Selection reference positions: atom, res_com, res_cog, mol_com,
           mol_cog, whole_res_com, whole_res_cog, whole_mol_com,
           whole_mol_cog, part_res_com, part_res_cog, part_mol_com,
           part_mol_cog, dyn_res_com, dyn_res_cog, dyn_mol_com, dyn_mol_cog
 -seltype <enum>            (atom)
           Default selection output positions: atom, res_com, res_cog,
           mol_com, mol_cog, whole_res_com, whole_res_cog, whole_mol_com,
           whole_mol_cog, part_res_com, part_res_cog, part_mol_com,
           part_mol_cog, dyn_res_com, dyn_res_cog, dyn_mol_com, dyn_mol_cog
 -sel-pathway <selection>
           Reference group that defines the permeation pathway (usually
           'Protein')
 -sel-solvent <selection>
           Group of small particles to calculate density of (usually 'Water')
 -out-filename <string>     (output)
           File name for output files without file extension.
 -out-num-points <int>      (1000)
           Number of spatial sample points that are written to the JSON output
           file.
 -out-extrap-dist <real>    (0)
           Extrapolation distance beyond the pathway endpoints for both JSON
           and OBJ output.
 -out-grid-dist <real>      (0.15)
           Controls the sampling distance of vertices on the pathway surface
           which are subsequently interpolated to yield a smooth surface. Very
           small values may yield visual artifacts.
 -out-vis-tweak <real>      (0.1)
           Visual tweaking factor that controls the smoothness of the pathway
           surface in the OBJ output. Varies between -1 and 1 (exculisvely),
           where larger values result in a smoother surface. Negative values
           may result in visualisation artifacts.
 -[no]out-detailed          (no)
           If true, CHAP will write detailed per-frame information to a
           newline delimited JSON file including original probe positions and
           spline parameters. This is mostly useful for debugging.
 -pf-method <enum>          (inplane_optim)
           Path finding method. The default inplane_optim implements the
           algorithm used in the HOLE programme, where the position of a probe
           sphere is optimised in subsequent parallel planes so as to maximise
           its radius. The alternative naive_cylindrical simply uses a
           cylindrical volume as permeation pathway.: cylindrical,
           inplane_optim
 -pf-vdwr-database <enum>   (hole_simple)
           Database of van-der-Waals radii to be used in pore finding:
           hole_amberuni, hole_bondi, hole_hardcore, hole_simple, hole_xplor,
           user
 -pf-vdwr-fallback <real>   (nan)
           Fallback van-der-Waals radius for atoms that are not listed in
           van-der-Waals radius database. Unless this is set to a positive
           value, an error will be thrown if a pathway-forming atom has no
           associated van-der-Waals radius in the database.
 -pf-vdwr-json <string>
           JSON file with user defined van-der-Waals radii. Will be ignored
           unless -pf-vdwr-database is set to 'user'.
 -pf-align-method <enum>    (ipp)
           Method for aligning pathway coordinates across time steps: none,
           ipp
 -pf-probe-step <real>      (0.1)
           Step length for probe movement.
 -pf-max-free-dist <real>   (1)
           Maximum radius of pore.
 -pf-max-probe-steps <int>  (10000)
           Maximum number of steps the probe is moved in either direction.
 -pf-sel-ipp <selection>
           Selection of atoms whose COM will be used as initial probe
           position. If not set, the selection specified with 'sel-pathway'
           will be used.
 -pf-init-probe-pos <real>  (nan nan nan)
           Initial position of probe in probe-based pore finding algorithms.
           If set explicitly, it will overwrite the COM-based initial position
           set with the ippSelflag.
 -pf-chan-dir-vec <real>    (0 0 1)
           Channel direction vector. Will be normalised to unit vector
           internally.
 -pf-cutoff <real>          (nan)
           Cutoff for distance searches in path finding algorithm. A value of
           zero or less means no cutoff is applied. If unset, an appropriate
           cutoff is determined automatically.
 -sa-seed <int>             (0)
           Seed used in pseudo random number generation for simulated
           annealing. If not set explicitly, a random seed is used.
 -sa-max-iter <int>         (0)
           Number of cooling iterations in one simulated annealing run.
 -sa-init-temp <real>       (0.1)
           Simulated annealing initial temperature.
 -sa-cooling-fac <real>     (0.98)
           Simulated annealing cooling factor.
 -sa-step <real>            (0.001)
           Step length factor used in candidate generation.
 -nm-max-iter <int>         (100)
           Number of Nelder-Mead simplex iterations in path finding algorithm.
 -nm-init-shift <real>      (0.1)
           Distance of vertices in initial Nelder-Mead simplex.
 -pm-pl-margin <real>       (0.75)
           Margin for determining pathway lining residues. A residue is
           considered to be pathway lining if it is no further than the local
           path radius plus this margin from the pathway's centre line.
 -pm-pf-sel <string>        (name CA)
           Selection string that determines the group of atoms in each residue
           whose centre of geometry's distance from the centre line is used to
           determine if a residue is pore-facing.
 -de-method <enum>          (kernel)
           Method used for estimating the probability density of the solvent
           particles along the permeation pathway: histogram, kernel
 -de-res <real>             (0.01)
           Spatial resolution of the density estimator. In case of a
           histogram, this is the bin width, in case of a kernel density
           estimator, this is the spacing of the evaluation points.
 -de-bandwidth <real>       (-1)
           Bandwidth for the kernel density estimator. Ignored for other
           methods. If negative or zero, bandwidth will be determined
           automatically to minimise the asymptotic mean integrated squared
           error (AMISE).
 -de-bw-scale <real>        (1)
           Scaling factor for the band width. Useful to set a bandwidth
           relative to the AMISE-optimal value.
 -de-eval-cutoff <real>     (5)
           Evaluation range cutoff for kernel density estimator in multiples
           of bandwidth. Ignored for other methods. Ensures that the density
           falls off smoothly to zero outside the data range.
 -hydrophob-database <enum> (wimley_white_1996)
           Database of hydrophobicity scale for pore forming residues:
           hessa_2005, kyte_doolittle_1982, monera_1995, moon_2011,
           wimley_white_1996, zhu_2016, memprotmd, user
 -hydrophob-fallback <real> (nan)
           Fallback hydrophobicity for residues in the pathway defining group.
           If unset (nan), residues missing in the database will cause an
           error.
 -hydrophob-json <string>
           JSON file with user defined hydrophobicity scale. Will be ignored
           unless -hydrophobicity-database is set to 'user'.
 -hydrophob-bandwidth <real> (0.35)
           Bandwidth for hydrophobicity kernel.


Thank you for using CHAP - The Channel Annotation Package!
```


## Metadata
- **Skill**: generated
