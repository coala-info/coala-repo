# sbml2metexplorejsongraph CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sbml2metexplorejsongraph | Failed | image problem: the image has no sbml2metexplorejsongraph command; its entrypoint is 'java -jar SBML2MetexploreJsonGraph.jar' with a relative jar path, so it cannot find the jar outside the root folder |

## sbml2metexplorejsongraph

### Tool Description
Convert Flux data contained in the SBML as mapping data

### Metadata
- **Docker Image**: biocontainers/sbml2metexplorejsongraph:phenomenal-v1.2_cv1.1.7
- **Homepage**: https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sbml2metexplorejsongraph/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph
- **Stars**: N/A
### Original Help Text
```text
Application Usage:
 -flux2Mapp   : Convert Flux data contained in the SBML as mapping data
                (default: false)
 -h           : Prints this help. (default: false)
 -inFile VAL  : [Required] Input SBML file.
 -outFile VAL : [Required] Output json file name.
 -validate    : Validate input SBML file. Default to false (default: false)
```


## Metadata
- **Skill**: generated
