# assembly_uploader CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| assembly_uploader_assembly_manifest | PASS |  |
| assembly_uploader_release_study | Not completed | release_study releases a study on ENA and needs ENA Webin credentials, which are not available. |
| assembly_uploader_study_xmls | PASS |  |
| assembly_uploader_submit_study | Not completed | submit_study registers a study on ENA and needs ENA Webin credentials, which are not available. |
| assembly_uploader_webin_cli_handler | Not completed | webin_cli_handler runs ENA Webin-CLI, which needs ENA Webin credentials for both validate and submit modes; none are available. |

## assembly_uploader_study_xmls

### Tool Description
Study XML generation

### Metadata
- **Docker Image**: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
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
Usage: study_xmls [OPTIONS]

  Study XML generation

Options:
  --version                       Show the version and exit.
  --study TEXT                    Raw reads study ID  [required]
  --library [metagenome|metatranscriptome]
                                  Library type  [required]
  --center TEXT                   Center for upload e.g. EMG  [required]
  --hold TEXT                     Hold date (private) in format dd-mm-yyyy.
                                  Will inherit the release date of the raw
                                  read study if not provided.
  --tpa                           Use this flag if the study is a third-party
                                  assembly. Default: False
  --publication INTEGER           PubMed ID for connected publication if
                                  available
  --output-dir DIRECTORY          Path to output directory
  --private                       Use flag if private
  --test                          Use flag when submitting to the ENA TEST
                                  server (adds a timestamp to the study alias)
  --help                          Show this message and exit.
```

## assembly_uploader_submit_study

### Tool Description
Study submission

### Metadata
- **Docker Image**: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
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
Usage: submit_study [OPTIONS]

  Study submission

Options:
  --version         Show the version and exit.
  --study TEXT      raw reads study ID  [required]
  --directory TEXT  directory containing study XML  [required]
  --test            run test submission only
  --help            Show this message and exit.
```

## assembly_uploader_assembly_manifest

### Tool Description
Generate manifests for assembly uploads

### Metadata
- **Docker Image**: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
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
Usage: assembly_manifest [OPTIONS]

  Generate manifests for assembly uploads

Options:
  --version               Show the version and exit.
  --study TEXT            Raw reads study ID (used as a label for the upload
                          directory)  [required]
  --data FILE             Metadata CSV - runs, coverage, assembler, version,
                          filepath, and optionally sample
  --assembly_study TEXT   Pre-existing study ID to submit to if available.
                          Must exist in the webin account.
  --force                 Overwrite all existing manifests
  --output-dir DIRECTORY  Path to output directory
  --private               Use flag if private
  --tpa                   Use this flag if the study is a third-party
                          assembly. Default: False
  --test                  Use flag when submitting to the ENA TEST server
                          (adds a timestamp to the assembly alias)
  --help                  Show this message and exit.
```

## assembly_uploader_release_study

### Tool Description
Release a private/held study on ENA, e.g. an uploaded assembly study

### Metadata
- **Docker Image**: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
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
Usage: release_study [OPTIONS]

  Release a private/held study on ENA, e.g. an uploaded assembly study

Options:
  --version        Show the version and exit.
  --study TEXT     Study ID  [required]
  --xml_path TEXT  Path to use for the release XML submission
  --test           Use Webin Dev dropbox instead of prod
  --help           Show this message and exit.
```

## assembly_uploader_webin_cli_handler

### Tool Description
Validate or submit an ENA manifest with ENA Webin-CLI (script from mgnify-pipelines-toolkit that the assembly_uploader README recommends for the upload step).

### Metadata
- **Docker Image**: quay.io/biocontainers/assembly_uploader:1.3.5--pyhdfd78af_1
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
usage: webin_cli_handler [-h] -m MANIFEST -c
                         {genome,transcriptome,sequence,polysample,reads,taxrefset}
                         --mode {submit,validate} [--test] [--workdir WORKDIR]
                         [--download-webin-cli]
                         [--download-webin-cli-directory DOWNLOAD_WEBIN_CLI_DIRECTORY]
                         [--download-webin-cli-version DOWNLOAD_WEBIN_CLI_VERSION]
                         [--webin-cli-jar WEBIN_CLI_JAR] [--retries RETRIES]
                         [--retry-delay RETRY_DELAY]
                         [--java-heap-size-initial JAVA_HEAP_SIZE_INITIAL]
                         [--java-heap-size-max JAVA_HEAP_SIZE_MAX]

options:
  -h, --help            show this help message and exit
  -m MANIFEST, --manifest MANIFEST
                        Manifest text file containing file and metadata fields
  -c {genome,transcriptome,sequence,polysample,reads,taxrefset}, --context {genome,transcriptome,sequence,polysample,reads,taxrefset}
                        Submission type: genome, transcriptome, sequence,
                        polysample, reads, taxrefset
  --mode {submit,validate}
                        submit or validate
  --test                Specify to use test server instead of live
  --workdir WORKDIR     Path to working directory
  --download-webin-cli  Specify if you do not have ena-webin-cli installed
  --download-webin-cli-directory DOWNLOAD_WEBIN_CLI_DIRECTORY
                        Path to save webin-cli into
  --download-webin-cli-version DOWNLOAD_WEBIN_CLI_VERSION
                        Version of ena-webin-cli to download, default: latest
  --webin-cli-jar WEBIN_CLI_JAR
                        Path to pre-downloaded webin-cli.jar file to execute
  --retries RETRIES     Number of retry attempts (default: 3)
  --retry-delay RETRY_DELAY
                        Initial retry delay in seconds (default: 5)
  --java-heap-size-initial JAVA_HEAP_SIZE_INITIAL
                        Java initial heap size in GB (default: 10)
  --java-heap-size-max JAVA_HEAP_SIZE_MAX
                        Java maximum heap size in GB (default: 10)
```

