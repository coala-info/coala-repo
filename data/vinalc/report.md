# vinalc CWL Generation Report

## vinalc

### Tool Description
Command line parse error: unrecognised option '-help'

Correct usage:

### Metadata
- **Docker Image**: quay.io/biocontainers/vinalc:1.4.2--h01b65b2_0
- **Homepage**: https://github.com/XiaohuaZhangLLNL/VinaLC
- **Package**: https://anaconda.org/channels/bioconda/packages/vinalc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vinalc/overview
- **Total Downloads**: 701
- **Last updated**: 2025-10-01
- **GitHub**: https://github.com/XiaohuaZhangLLNL/VinaLC
- **Stars**: N/A
### Original Help Text
```text
Command line parse error: unrecognised option '-help'

Correct usage:

Input:
  --recList arg               receptor list file
  --fleList arg               flex part receptor list file
  --ligList arg               ligand list file
  --geoList arg               receptor geometry file
  --exhaustiveness arg (=8)   exhaustiveness (default value 8) of the global 
                              search (roughly proportional to time): 1+
  --granularity arg (=0.375)  the granularity of grids (default value 0.375)
  --num_modes arg (=9)        maximum number (default value 9) of binding modes
                              to generate
  --seed arg                  explicit random seed
  --randomize                 Use different random seeds for complex
  --energy_range arg (=2)     maximum energy difference (default value 2.0) 
                              between the best binding mode and the worst one 
                              displayed (kcal/mol)
  --useScoreCF                Use score cutoff to save ligand with top score 
                              higher than certain critical value
  --scoreCF arg (=-8)         Score cutoff to save ligand with top score higher
                              than certain value (default -8.0)

Information (optional):
  --help                      display usage summary

Error: Total process less than 2
```

