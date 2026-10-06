# assembly_uploader CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| assembly_uploader | Failed | not a usable tool: generated from a failed image pull, it names the wrong image (assemblycomparator2) and an invented command and flags; the package's real commands are study_xmls, submit_study, assembly_manifest, release_study and webin_cli_handler. |

## assembly_uploader

### Tool Description
Upload assembled sequences to a remote repository.

### Metadata
- **Docker Image**: quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2
- **Homepage**: https://github.com/EBI-Metagenomics/assembly_uploader
- **Package**: https://anaconda.org/channels/bioconda/packages/assembly_uploader/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/assembly_uploader/overview
- **Total Downloads**: 230
- **Last updated**: 2025-11-27
- **GitHub**: https://github.com/EBI-Metagenomics/assembly_uploader
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2' locally
2.7.1--hdfd78af_2: Pulling from biocontainers/assemblycomparator2
0cacab098358: Already exists
bd9ddc54bea9: Already exists
5d2b7f82559b: Pulling fs layer
5d2b7f82559b: Waiting
docker: write /var/lib/docker/tmp/GetImageBlob1583714188: no space left on device

Run 'docker run --help' for more information
```

