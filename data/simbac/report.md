# simbac CWL Generation Report

## simbac_SimBac

### Tool Description
Simulates bacterial recombination events.

### Metadata
- **Docker Image**: quay.io/biocontainers/simbac:0.1a--h3053a90_6
- **Homepage**: https://github.com/tbrown91/SimBac
- **Package**: https://anaconda.org/channels/bioconda/packages/simbac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/simbac/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tbrown91/SimBac
- **Stars**: N/A
### Original Help Text
```text
Usage: SimBac [OPTIONS]
    
    Options:
    -N NUM   Sets the number of isolates (default is 100)
    -T NUM   Sets the value of theta, between 0 and 1 (default is 0.01))
    -m NUM   Sets the minimum probability of mutation in an interval of external recombination between 0 & 1 (default is 0)
    -M NUM   Sets the maximum probability of mutation in an interval of external recombination between 0 & 1 (default is 0)
    -R NUM   Sets the value of R, the site-specific internal recombination rate (default is 0.01)
    -r NUM   Sets the rate of R external, the site-specific rate of external recombination (default is 0)
    -D NUM   Sets the value of delta (default is 500)
    -e NUM   Sets the average length of external recombinant interval (default is 500)
    -B NUM,...,NUM Sets the number and length of the fragments
             (default is 10000)
    -G NUM   Sets the gap between each fragment(default is 0)
    -s NUM   Use given seed to initiate random number generator
    -o FILE  Export data to given file
    -c FILE  Export clonal genealogy to given file
    -l FILE  Export local trees to given file
    -b FILE  Write log file of internal recombinant break interval locations
    -f FILE  Write log file of external recombinant break interval locations
    -g FILE  Write log file of recombinant break interval locations and relevant taxa (Use only recommended for small ARGs)
    -d FILE  Export DOT graph to given file
    -a       Include ancestral material in the DOT graph
```

