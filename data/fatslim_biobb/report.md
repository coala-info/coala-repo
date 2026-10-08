# fatslim_biobb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fatslim_biobb_aggregates | PASS | FATSLiM test bilayer: plot and aggregate index files written |
| fatslim_biobb_apl | PASS | FATSLiM test bilayer (model_bilayer.gro): raw area per lipid file matches the repository expected file |
| fatslim_biobb_membranes | PASS | FATSLiM test bilayer: plot and leaflet index files written |
| fatslim_biobb_thickness | PASS | FATSLiM test bilayer: raw thickness file matches the repository expected file |

## fatslim_biobb_aggregates

### Tool Description
Identifies and reports aggregates

### Metadata
- **Docker Image**: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
- **Homepage**: https://fatslim.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/fatslim_biobb/overview
- **Validation**: PASS

### Original Help Text
```text
FATSLiM - Fast Analysis Toolbox for Simulations of Lipid Membranes
version 0.2.2
Copyright (c) 2013-2016 Sébastien Buchoux

Running command: 'aggregates'... This may take some time, be patient!
command: fatslim aggregates
purpose: Identifies and reports aggregates
usage: fatslim aggregates [--help] [--debug] [--verbose] [--conf CONF]
                          [--trajectory TRAJECTORY] [--index INDEX]
                          [--hg-group HG_GROUP]
                          [--interacting-group INTERACTING_GROUP]
                          [--nthreads NTHREADS] [--begin BEGIN]
                          [--begin-frame BEGIN_FRAME] [--end END]
                          [--end-frame END_FRAME] [--output OUTPUT]
                          [--output-index-hg OUTPUT_INDEX_HG]
                          [--output-index OUTPUT_INDEX] [--cutoff CUTOFF]

General options:
  --help, -h            See help about aggregates command (default: False)
  --debug               Enable debug output (default: False)
  --verbose, -v         Be loud and noisy (default: False)

Options to specify input files:
  --conf CONF, -c CONF  Configuration file (default: conf.gro)
  --trajectory TRAJECTORY, -t TRAJECTORY
                        Trajectory file (default: traj.trr)
  --index INDEX, -n INDEX
                        Index file (default: index.ndx)

Options to specify output files:
  --output OUTPUT, -o OUTPUT
                        Plot number of aggregates over the selected trajectory
                        frames (default: None)
  --output-index-hg OUTPUT_INDEX_HG
                        Index group to store aggregates headgroups (default:
                        None)
  --output-index OUTPUT_INDEX
                        Index group to store aggregates (default: None)

Options related to analysis parameters:
  --hg-group HG_GROUP   Index group name used to define lipid headgroups
                        (default: headgroups)
  --interacting-group INTERACTING_GROUP
                        Index group name used to define interacting atoms
                        (e.g. protein). (default: protein)
  --nthreads NTHREADS   Number of threads to use (default: -1)
  --begin BEGIN, -b BEGIN
                        First timestep (ps) to use for analysis (default: -1)
  --begin-frame BEGIN_FRAME
                        First frame (index) to use for analysis (default: -1)
  --end END, -e END     Last timestep (ps) to use for analysis (default: -1)
  --end-frame END_FRAME
                        Last frame (index) to use for analysis (default: -1)
  --cutoff CUTOFF       Cutoff distance for aggregate identication (default:
                        2.0)
'aggregates' command executed in 1.869 ms (CPU)
Goodbye!
```

## fatslim_biobb_apl

### Tool Description
Retrieves area per lipid

### Metadata
- **Docker Image**: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
- **Homepage**: https://fatslim.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/fatslim_biobb/overview
- **Validation**: PASS

### Original Help Text
```text
FATSLiM - Fast Analysis Toolbox for Simulations of Lipid Membranes
version 0.2.2
Copyright (c) 2013-2016 Sébastien Buchoux

Running command: 'apl'... This may take some time, be patient!
command: fatslim apl
purpose: Retrieves area per lipid
usage: fatslim apl [--help] [--debug] [--verbose] [--conf CONF]
                   [--trajectory TRAJECTORY] [--index INDEX]
                   [--hg-group HG_GROUP]
                   [--interacting-group INTERACTING_GROUP]
                   [--nthreads NTHREADS] [--begin BEGIN]
                   [--begin-frame BEGIN_FRAME] [--end END]
                   [--end-frame END_FRAME] [--idfreq IDFREQ] [--cutoff CUTOFF]
                   [--plot-apl PLOT_APL] [--export-apl-raw EXPORT_APL_RAW]
                   [--apl-by-type] [--apl-cutoff APL_CUTOFF]
                   [--apl-limit APL_LIMIT] [--plot-area PLOT_AREA]

General options:
  --help, -h            See help about apl command (default: False)
  --debug               Enable debug output (default: False)
  --verbose, -v         Be loud and noisy (default: False)

Options to specify input files:
  --conf CONF, -c CONF  Configuration file (default: conf.gro)
  --trajectory TRAJECTORY, -t TRAJECTORY
                        Trajectory file (default: traj.trr)
  --index INDEX, -n INDEX
                        Index file (default: index.ndx)

Options to specify output files:
  --plot-apl PLOT_APL   Plot area per lipid over trajectory (.xvg file)
                        (default: None)
  --export-apl-raw EXPORT_APL_RAW
                        Save area per lipid raw values (one .csv file per
                        frame) (default: None)
  --plot-area PLOT_AREA
                        Plot area over trajectory (.xvg file) (default: None)

Options related to analysis parameters:
  --hg-group HG_GROUP   Index group name used to define lipid headgroups
                        (default: headgroups)
  --interacting-group INTERACTING_GROUP
                        Index group name used to define interacting atoms
                        (e.g. protein). (default: protein)
  --nthreads NTHREADS   Number of threads to use (default: -1)
  --begin BEGIN, -b BEGIN
                        First timestep (ps) to use for analysis (default: -1)
  --begin-frame BEGIN_FRAME
                        First frame (index) to use for analysis (default: -1)
  --end END, -e END     Last timestep (ps) to use for analysis (default: -1)
  --end-frame END_FRAME
                        Last frame (index) to use for analysis (default: -1)
  --idfreq IDFREQ       Frequency used to update membrane identification
                        (Note: membrane identification is always done for the
                        first frame) (default: 1)
  --cutoff CUTOFF       Cutoff distance for leaflets identification (default:
                        2)
  --apl-by-type         Group area per lipid values by lipid types (default:
                        False)
  --apl-cutoff APL_CUTOFF
                        Cutoff distance (in nm) used to approximate planar
                        region (default: 3.0)
  --apl-limit APL_LIMIT
                        Upper limit (in nm2) considered when calculating
                        individual APL values (default: 10.0)
'apl' command executed in 1.925 ms (CPU)
Goodbye!
```

## fatslim_biobb_membranes

### Tool Description
Identifies and reports membranes

### Metadata
- **Docker Image**: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
- **Homepage**: https://fatslim.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/fatslim_biobb/overview
- **Validation**: PASS

### Original Help Text
```text
FATSLiM - Fast Analysis Toolbox for Simulations of Lipid Membranes
version 0.2.2
Copyright (c) 2013-2016 Sébastien Buchoux

Running command: 'membranes'... This may take some time, be patient!
command: fatslim membranes
purpose: Identifies and report membranes
usage: fatslim membranes [--help] [--debug] [--verbose] [--conf CONF]
                         [--trajectory TRAJECTORY] [--index INDEX]
                         [--hg-group HG_GROUP]
                         [--interacting-group INTERACTING_GROUP]
                         [--nthreads NTHREADS] [--begin BEGIN]
                         [--begin-frame BEGIN_FRAME] [--end END]
                         [--end-frame END_FRAME] [-o OUTPUT]
                         [--output-index-hg OUTPUT_INDEX_HG]
                         [--output-index OUTPUT_INDEX] [--cutoff CUTOFF]

General options:
  --help, -h            See help about membranes command (default: False)
  --debug               Enable debug output (default: False)
  --verbose, -v         Be loud and noisy (default: False)

Options to specify input files:
  --conf CONF, -c CONF  Configuration file (default: conf.gro)
  --trajectory TRAJECTORY, -t TRAJECTORY
                        Trajectory file (default: traj.trr)
  --index INDEX, -n INDEX
                        Index file (default: index.ndx)

Options to specify output files:
  -o OUTPUT, --output OUTPUT
                        Plot number of membranes over the selected trajectory
                        frames (default: None)
  --output-index-hg OUTPUT_INDEX_HG
                        Index group to store leaflet headgroups (default:
                        None)
  --output-index OUTPUT_INDEX
                        Index group to store leaflets (default: None)

Options related to analysis parameters:
  --hg-group HG_GROUP   Index group name used to define lipid headgroups
                        (default: headgroups)
  --interacting-group INTERACTING_GROUP
                        Index group name used to define interacting atoms
                        (e.g. protein). (default: protein)
  --nthreads NTHREADS   Number of threads to use (default: -1)
  --begin BEGIN, -b BEGIN
                        First timestep (ps) to use for analysis (default: -1)
  --begin-frame BEGIN_FRAME
                        First frame (index) to use for analysis (default: -1)
  --end END, -e END     Last timestep (ps) to use for analysis (default: -1)
  --end-frame END_FRAME
                        Last frame (index) to use for analysis (default: -1)
  --cutoff CUTOFF       Cutoff distance (in nm) for leaflet identification
                        (default: 2.0)
'membranes' command executed in 1.829 ms (CPU)
Goodbye!
```

## fatslim_biobb_thickness

### Tool Description
Retrieves bilayer thickness

### Metadata
- **Docker Image**: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
- **Homepage**: https://fatslim.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/fatslim_biobb/overview
- **Validation**: PASS

### Original Help Text
```text
FATSLiM - Fast Analysis Toolbox for Simulations of Lipid Membranes
version 0.2.2
Copyright (c) 2013-2016 Sébastien Buchoux

Running command: 'thickness'... This may take some time, be patient!
command: fatslim thickness
purpose: Retrieves bilayer thickness
usage: fatslim thickness [--help] [--debug] [--verbose] [--conf CONF]
                         [--trajectory TRAJECTORY] [--index INDEX]
                         [--hg-group HG_GROUP]
                         [--interacting-group INTERACTING_GROUP]
                         [--nthreads NTHREADS] [--begin BEGIN]
                         [--begin-frame BEGIN_FRAME] [--end END]
                         [--end-frame END_FRAME] [--idfreq IDFREQ]
                         [--cutoff CUTOFF] [--plot-thickness PLOT_THICKNESS]
                         [--export-thickness-raw EXPORT_THICKNESS_RAW]
                         [--thickness-cutoff THICKNESS_CUTOFF]

General options:
  --help, -h            See help about thickness command (default: False)
  --debug               Enable debug output (default: False)
  --verbose, -v         Be loud and noisy (default: False)

Options to specify input files:
  --conf CONF, -c CONF  Configuration file (default: conf.gro)
  --trajectory TRAJECTORY, -t TRAJECTORY
                        Trajectory file (default: traj.trr)
  --index INDEX, -n INDEX
                        Index file (default: index.ndx)

Options to specify output files:
  --plot-thickness PLOT_THICKNESS
                        Plot thickness over trajectory (.xvg file) (default:
                        None)
  --export-thickness-raw EXPORT_THICKNESS_RAW
                        Save thickness raw values (one .csv file per frame)
                        (default: None)

Options related to analysis parameters:
  --hg-group HG_GROUP   Index group name used to define lipid headgroups
                        (default: headgroups)
  --interacting-group INTERACTING_GROUP
                        Index group name used to define interacting atoms
                        (e.g. protein). (default: protein)
  --nthreads NTHREADS   Number of threads to use (default: -1)
  --begin BEGIN, -b BEGIN
                        First timestep (ps) to use for analysis (default: -1)
  --begin-frame BEGIN_FRAME
                        First frame (index) to use for analysis (default: -1)
  --end END, -e END     Last timestep (ps) to use for analysis (default: -1)
  --end-frame END_FRAME
                        Last frame (index) to use for analysis (default: -1)
  --idfreq IDFREQ       Frequency used to update membrane identification
                        (Note: membrane identification is always done for the
                        first frame) (default: 1)
  --cutoff CUTOFF       Cutoff distance for leaflets identification (default:
                        2)
  --thickness-cutoff THICKNESS_CUTOFF
                        Cutoff distance (in nm) used to identify inter-leaflet
                        neighbors (default: 6.0)
'thickness' command executed in 1.025 ms (CPU)
Goodbye!
```

