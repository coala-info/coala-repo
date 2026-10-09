# isocor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| isocor_isocorcli | PASS |  |

## isocor_isocorcli

### Tool Description
Correction of mass spectrometry data for naturally occurring isotopes.

### Metadata
- **Docker Image**: quay.io/biocontainers/isocor:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/MetaSys-LISBP/IsoCor/
- **Package**: https://anaconda.org/channels/bioconda/packages/isocor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isocorcli [-h] [-M M] [-D D] [-I I] -t TRACER [-r RESOLUTION]
                 [-m MZ_OF_RESOLUTION]
                 [-f {orbitrap,ft-icr,constant,datafile}] [-p TRACER_PURITY]
                 [-n] [-v]
                 inputdata

correction of MS data for naturally occurring isotopes

positional arguments:
  inputdata             measurements file to process

options:
  -h, --help            show this help message and exit
  -M M                  path to metabolites database
  -D D                  path to derivatives database
  -I I                  path to isotopes database
  -t TRACER, --tracer TRACER
                        the isotopic tracer (e.g. "13C")
  -r RESOLUTION, --resolution RESOLUTION
                        HR only: resolution of the mass spectrometer (e.g.
                        "1e4")
  -m MZ_OF_RESOLUTION, --mz_of_resolution MZ_OF_RESOLUTION
                        HR only: mz at which resolution is given (e.g. "400")
  -f {orbitrap,ft-icr,constant,datafile}, --resolution_formula_code {orbitrap,ft-icr,constant,datafile}
                        HR only: spectrometer formula code
  -p TRACER_PURITY, --tracer_purity TRACER_PURITY
                        purity vector of the tracer
  -n, --correct_NA_tracer
                        flag to correct tracer natural abundance
  -v, --verbose         flag to enable verbose logs
```

## Metadata
- **Skill**: generated
