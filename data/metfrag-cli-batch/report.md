# metfrag-cli-batch CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metfrag-cli-batch_MetFragCLI | PASS |  |
| metfrag-cli-batch_metfrag | PASS |  |
| metfrag-cli-batch_run_metfrag | PASS |  |

## metfrag-cli-batch_MetFragCLI

### Tool Description
MetFrag command line tool: in silico fragmentation of candidate structures for MS/MS annotation.

### Metadata
- **Docker Image**: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
- **Homepage**: http://c-ruttkies.github.io/MetFrag/
- **Package**: https://anaconda.org/channels/bioconda/packages/metfrag-cli-batch/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR de.ipbhalle.metfrag.commandline.CommandLineTool - Parameter file is missing!
ERROR de.ipbhalle.metfrag.commandline.CommandLineTool - ParameterFile='path_to_parameterfile'
```

## metfrag-cli-batch_metfrag

### Tool Description
Run MetFrag on every parameter file inside a zip archive and collect the results in a zip archive.

### Metadata
- **Docker Image**: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
- **Homepage**: http://c-ruttkies.github.io/MetFrag/
- **Package**: https://anaconda.org/channels/bioconda/packages/metfrag-cli-batch/overview
- **Validation**: PASS

### Original Help Text
```text
metfrag.sh -z|--zip ZIPFILE -p|--parameters PARAM -d|--database DB -o|--output OUTPUT
```

## metfrag-cli-batch_run_metfrag

### Tool Description
Run MetFrag in parallel over the lines of parameter files and write the results to a file or folder.

### Metadata
- **Docker Image**: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
- **Homepage**: http://c-ruttkies.github.io/MetFrag/
- **Package**: https://anaconda.org/channels/bioconda/packages/metfrag-cli-batch/overview
- **Validation**: PASS

### Original Help Text
```text
run_metfrag.sh -p|--parameterfile F -pp|--parameterfiles F1,F2 -a|--additionalparameters P -l|--localdatabasepath DB -r|--resultspath DIR -f|--resultsfile FILE -z|--zipfile ZIP -o|--output FILE -rn|--rename true|false -s|--additionalscores S1,S2
```

## Metadata
- **Skill**: not generated
