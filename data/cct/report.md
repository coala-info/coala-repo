# cct CWL Generation Report

## cct

### Tool Description
Convert input data to Universal Transverse Mercator, zone 32 coordinates, based on the GRS80 ellipsoid.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/Eanya-Tonic/CCTV_Viewer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/Eanya-Tonic/CCTV_Viewer
- **Stars**: N/A
### Original Help Text
```text
--------------------------------------------------------------------------------
Usage: cct [-options]... [+operator_specs]... infile...
--------------------------------------------------------------------------------
Options:
--------------------------------------------------------------------------------
    -c x,y,z,t        Specify input columns for (up to) 4 input parameters.
                      Defaults to 1,2,3,4
    -d n              Specify number of decimals in output.
    -I                Do the inverse transformation
    -o /path/to/file  Specify output file name
    -t value          Provide a fixed t value for all input data (e.g. -t 0)
    -z value          Provide a fixed z value for all input data (e.g. -z 0)
    -s n              Skip n first lines of a infile
    -v                Verbose: Provide non-essential informational output.
                      Repeat -v for more verbosity (e.g. -vv)
--------------------------------------------------------------------------------
Long Options:
--------------------------------------------------------------------------------
    --output          Alias for -o
    --columns         Alias for -c
    --decimals        Alias for -d
    --height          Alias for -z
    --time            Alias for -t
    --verbose         Alias for -v
    --inverse         Alias for -I
    --skip-lines      Alias for -s
    --help            Alias for -h
    --version         Print version number
--------------------------------------------------------------------------------
Operator Specs:
--------------------------------------------------------------------------------
The operator specs describe the action to be performed by cct, e.g:

        +proj=utm  +ellps=GRS80  +zone=32

instructs cct to convert input data to Universal Transverse Mercator, zone 32
coordinates, based on the GRS80 ellipsoid.

Hence, the command

        echo 12 55 | cct -z0 -t0 +proj=utm +zone=32 +ellps=GRS80

Should give results comparable to the classic proj command

        echo 12 55 | proj +proj=utm +zone=32 +ellps=GRS80
--------------------------------------------------------------------------------
Examples:
--------------------------------------------------------------------------------
1. convert geographical input to UTM zone 32 on the GRS80 ellipsoid:
    cct +proj=utm +ellps=GRS80 +zone=32
2. roundtrip accuracy check for the case above:
    cct +proj=pipeline +proj=utm +ellps=GRS80 +zone=32 +step +step +inv
3. as (1) but specify input columns for longitude, latitude, height and time:
    cct -c 5,2,1,4  +proj=utm +ellps=GRS80 +zone=32
4. as (1) but specify fixed height and time, hence needing only 2 cols in input:
    cct -t 0 -z 0  +proj=utm  +ellps=GRS80  +zone=32
--------------------------------------------------------------------------------
```


## Metadata
- **Skill**: generated
