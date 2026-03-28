# auspice CWL Generation Report

## auspice_view

### Tool Description
Launch a local server to view locally available datasets & narratives. The handlers for (auspice) client requests can be overridden here (see documentation for more details). If you want to serve a customised auspice client then you must have run "auspice build" in the same directory as you run "auspice view" from.

### Metadata
- **Docker Image**: quay.io/biocontainers/auspice:2.66.0--h503566f_2
- **Homepage**: https://docs.nextstrain.org/projects/auspice/
- **Package**: https://anaconda.org/channels/bioconda/packages/auspice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/auspice/overview
- **Total Downloads**: 128.8K
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/nextstrain/auspice
- **Stars**: N/A
### Original Help Text
```text
usage: auspice view [-h] [--verbose] [--handlers JS] [--datasetDir PATH]
                    [--narrativeDir PATH] [--customBuildOnly]
                    

Launch a local server to view locally available datasets & narratives. The 
handlers for (auspice) client requests can be overridden here (see 
documentation for more details). If you want to serve a customised auspice 
client then you must have run "auspice build" in the same directory as you 
run "auspice view" from.

Optional arguments:
  -h, --help           Show this help message and exit.
  --verbose            Print more verbose logging messages.
  --handlers JS        Overwrite the provided server handlers for client 
                       requests. See documentation for more details.
  --datasetDir PATH    Directory where datasets (JSONs) are sourced. This is 
                       ignored if you define custom handlers.
  --narrativeDir PATH  Directory where narratives (Markdown files) are 
                       sourced. This is ignored if you define custom handlers.
  --customBuildOnly    Error if a custom build is not found.
```


## auspice_build

### Tool Description
Build the client source code bundle. For development, you may want to use "auspice develop" which recompiles code on the fly as changes are made. You may provide customisations (e.g. code, options) to this step to modify the functionality and appearance of auspice. To serve the bundle you will need a server such as "auspice view".

### Metadata
- **Docker Image**: quay.io/biocontainers/auspice:2.66.0--h503566f_2
- **Homepage**: https://docs.nextstrain.org/projects/auspice/
- **Package**: https://anaconda.org/channels/bioconda/packages/auspice/overview
- **Validation**: PASS

### Original Help Text
```text
usage: auspice build [-h] [--verbose] [--extend JSON] [--analyzeBundle]
                     [--includeTiming]
                     

Build the client source code bundle. For development, you may want to use 
"auspice develop" which recompiles code on the fly as changes are made. You 
may provide customisations (e.g. code, options) to this step to modify the 
functionality and appearance of auspice. To serve the bundle you will need a 
server such as "auspice view".

Optional arguments:
  -h, --help       Show this help message and exit.
  --verbose        Print more verbose progress messages.
  --extend JSON    Build-time customisations to be applied. See documentation 
                   for more details.

Testing options:
  --analyzeBundle  Load an interactive bundle analyzer tool to investigate 
                   the composition of produced bundles / chunks.
  --includeTiming  Do not strip timing functions. With these included the 
                   browser console will print timing measurements for a 
                   number of functions.
```


## auspice_develop

### Tool Description
Launch auspice in development mode. This runs a local server and uses 
hot-reloading to allow automatic updating as you edit the code. NOTE: there 
is a speed penalty for this ability and this should never be used for 
production.

### Metadata
- **Docker Image**: quay.io/biocontainers/auspice:2.66.0--h503566f_2
- **Homepage**: https://docs.nextstrain.org/projects/auspice/
- **Package**: https://anaconda.org/channels/bioconda/packages/auspice/overview
- **Validation**: PASS

### Original Help Text
```text
usage: auspice develop [-h] [--verbose] [--extend JSON] [--handlers JS]
                       [--datasetDir PATH] [--narrativeDir PATH]
                       [--includeTiming]
                       

Launch auspice in development mode. This runs a local server and uses 
hot-reloading to allow automatic updating as you edit the code. NOTE: there 
is a speed penalty for this ability and this should never be used for 
production.

Optional arguments:
  -h, --help           Show this help message and exit.
  --verbose            Print more verbose progress messages in the terminal.
  --extend JSON        Client customisations to be applied. See documentation 
                       for more details. Note that hot reloading does not 
                       currently work for these customisations.
  --handlers JS        Overwrite the provided server handlers for client 
                       requests. See documentation for more details.
  --datasetDir PATH    Directory where datasets (JSONs) are sourced. This is 
                       ignored if you define custom handlers.
  --narrativeDir PATH  Directory where narratives (Markdown files) are 
                       sourced. This is ignored if you define custom handlers.
  --includeTiming      Do not strip timing functions. With these included the 
                       browser console will print timing measurements for a 
                       number of functions.
```


## auspice_convert

### Tool Description
Convert auspice dataset JSON file(s) to the most up-to-date schema (currently v2). Note that in auspice v2.x, "auspice view" will convert v1 JSONs to v2 for you (using the same logic as this command).

### Metadata
- **Docker Image**: quay.io/biocontainers/auspice:2.66.0--h503566f_2
- **Homepage**: https://docs.nextstrain.org/projects/auspice/
- **Package**: https://anaconda.org/channels/bioconda/packages/auspice/overview
- **Validation**: PASS

### Original Help Text
```text
usage: auspice convert [-h] [--v1 META TREE] --output JSON [--minify-json]

Convert auspice dataset JSON file(s) to the most up-to-date schema (currently 
v2). Note that in auspice v2.x, "auspice view" will convert v1 JSONs to v2 
for you (using the same logic as this command).

Optional arguments:
  -h, --help      Show this help message and exit.
  --v1 META TREE  v1 dataset JSONs
  --output JSON   File to write output to
  --minify-json   export JSONs without indentation or line returns
```


## Metadata
- **Skill**: generated
