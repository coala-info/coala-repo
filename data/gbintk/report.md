# gbintk CWL Generation Report

## gbintk_prepare

### Tool Description
Format the initial binning result from an existing binning tool

### Metadata
- **Docker Image**: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
- **Homepage**: https://github.com/metagentools/gbintk
- **Package**: https://anaconda.org/channels/bioconda/packages/gbintk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gbintk/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/metagentools/gbintk
- **Stars**: N/A
### Original Help Text
```text
Usage: gbintk prepare [OPTIONS]

  Format the initial binning result from an existing binning tool

Options:
  --assembler [spades|megahit|flye]
                                  name of the assembler used (SPAdes, MEGAHIT
                                  or Flye)  [required]
  --resfolder PATH                path to the folder containing FASTA files
                                  for individual bins  [required]
  --delimiter [comma|tab]         delimiter for input/output results. Supports
                                  a comma and a tab.  [default: comma]
  --prefix TEXT                   prefix for the output file  [default: ""]
  --output PATH                   path to the output folder  [required]
  -h, --help                      Show this message and exit.
```


## gbintk_visualise

### Tool Description
Visualise binning and refinement results

### Metadata
- **Docker Image**: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
- **Homepage**: https://github.com/metagentools/gbintk
- **Package**: https://anaconda.org/channels/bioconda/packages/gbintk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gbintk visualise [OPTIONS]

  Visualise binning and refinement results

Options:
  --assembler [spades|megahit|flye]
                                  name of the assembler used (SPAdes, MEGAHIT
                                  or Flye)  [required]
  --initial PATH                  path to the initial binning result
                                  [required]
  --final PATH                    path to the final binning result  [required]
  --graph PATH                    path to the assembly graph file  [required]
  --contigs PATH                  path to the contigs file  [required]
  --paths PATH                    path to the contigs.paths (metaSPAdes) or
                                  assembly.info (metaFlye) file
  --output PATH                   path to the output folder  [required]
  --prefix TEXT                   prefix for the output file  [default: ""]
  --dpi INTEGER                   dpi value  [default: 300]
  --width INTEGER                 width of the image in pixels  [default:
                                  2000]
  --height INTEGER                height of the image in pixels  [default:
                                  2000]
  --vsize INTEGER                 size of the vertices  [default: 50]
  --lsize INTEGER                 size of the vertex labels  [default: 8]
  --margin INTEGER                margin of the figure  [default: 50]
  --imgtype [png|eps|pdf|svg]     type of the image (png, eps, pdf, svg)
                                  [default: png]
  --delimiter [comma|tab]         delimiter for input/output results. Supports
                                  a comma and a tab.  [default: comma]
  -h, --help                      Show this message and exit.
```


## gbintk_evaluate

### Tool Description
Evaluate the binning results given a ground truth

### Metadata
- **Docker Image**: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
- **Homepage**: https://github.com/metagentools/gbintk
- **Package**: https://anaconda.org/channels/bioconda/packages/gbintk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gbintk evaluate [OPTIONS]

  Evaluate the binning results given a ground truth

Options:
  --binned PATH            path to the .csv file with the initial binning
                           output from an existing tool  [required]
  --groundtruth PATH       path to the .csv file with the ground truth
                           [required]
  --delimiter [comma|tab]  delimiter for input/output results. Supports a
                           comma and a tab.  [default: comma]
  --prefix TEXT            prefix for the output file  [default: ""]
  --output PATH            path to the output folder  [required]
  -h, --help               Show this message and exit.
```


## Metadata
- **Skill**: generated
