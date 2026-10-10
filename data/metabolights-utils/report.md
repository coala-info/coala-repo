# metabolights-utils CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metabolights-utils_mtbls_local-validate | Failed | image problem: the opa executable that validation needs is not in the image |
| metabolights-utils_mtbls_model_create | PASS | model JSON of the repo test study MTBLS398 has the right title; studies with parser messages crash the tool on its own message printing |
| metabolights-utils_mtbls_model_explain | PASS |  |
| metabolights-utils_mtbls_public_describe | PASS | local-only mode on repo test study MTBLS398; jsonpath title is correct |
| metabolights-utils_mtbls_public_download | PASS | downloaded the ISA files of MTBLS2075 from the MetaboLights FTP |
| metabolights-utils_mtbls_public_list | PASS |  |
| metabolights-utils_mtbls_public_remove | PASS |  |
| metabolights-utils_mtbls_public_search | Not completed | the MetaboLights search endpoint (ws3/public/search/studies/_search) now returns 404 Not Found |

## metabolights-utils_mtbls_local-validate

### Tool Description
Validate local ISA metadata files.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls local-validate [OPTIONS] MTBLS_PROVISIONAL_STUDY_ID
                            METADATA_FILES_PATH

  Validate local ISA metadata files.

Options:
  --data_files_path PATH          The data files root path.
  --output_directory TEXT         Output file directory.
  --overridden_rules_file_path PATH
                                  A txt file that contains a validation rule
                                  identifier in each row. e.g. one row:
                                  rule_i_100_350_003_01. All validation errors
                                  listed in this file  will be filtered from
                                  the result.
  --mtbls_validation_bundle_path TEXT
                                  Location of MetaboLights validation bundle
                                  path. You can download the latest one on
                                  https://raw.githubusercontent.com/EBI-
                                  Metabolights/mtbls-validation/refs/heads/tes
                                  t/docs/bundle.tar.gz
  --refetch_mtbls_validation_bundle
                                  A flag to enable remote validation of the
                                  study. You can download the latest one on
                                  https://raw.githubusercontent.com/EBI-
                                  Metabolights/mtbls-validation/refs/heads/tes
                                  t/docs/bundle.tar.gz
  --mtbls_validation_bundle_url TEXT
                                  URL to download validation bundle.
  --opa_executable_path TEXT      OPA executable path.
  -h, --help                      Show this message and exit.
```

## metabolights-utils_mtbls_model_create

### Tool Description
Create the MetaboLights study model of a local study folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls model create [OPTIONS] STUDY_PATH

  Validate submitted study and save validation report on local storage. NOTE:
  Data files should be on FILES subfolder.

  study_path: MetaboLights study folder. Folder should contain ISAtab files.

  output: Output JSON file path. If it is not defined, file is created on
  working directory.

Options:
  -o, --output_path TEXT  output file path. e.g. /path/to/output.json
  -h, --help              Show this message and exit.
```

## metabolights-utils_mtbls_model_explain

### Tool Description
Explain properties of the MetaboLights study model.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls model explain [OPTIONS] [MODEL_PATTERN]

  Explain properties and sub-properties of MetaboLights study model.    It
  lists root properties of the model, If it is not specified

  Examples: investigation -> explains properties of Investigation property of
  MetaboLights study model. investigation.studies -> explains properties of
  Study model investigation.studies.study_assays.assays -> explains properties
  of Assay model investigation.studies.study_assays.comments -> explains
  properties of Comment model of assay

  assays.assay_technique -> explains Assay Technique model

Options:
  -h, --help  Show this message and exit.
```

## metabolights-utils_mtbls_public_describe

### Tool Description
View summary of public study content.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls public describe [OPTIONS] STUDY_ID [JSONPATH]

  View summary of any public study content. Run jsonpath expression to filter
  MetaboLights study model.

  study_id: MetaboLights study accession number (MTBLSxxxx).

  jsonpath (optional): jsonpath expression to filter study model.

  Print summary of study model if not specified.

      Example jsonpath expressions: "$.investigation.studies[0].title",
      "$.investigation.studies[0].study_protocols.protocols[*].name",
      "$.assays[*].*.table.columns[*]" - print column names

      Note: jsonpath expressions should be quoted with double quotes.

Options:
  -p, --local_path TEXT          Local storage root path. Folder will be
                                 created if it does not exist.
  -f, --ftp_server_url TEXT      FTP server URL where MetaboLights repository
                                 is hosted.
  -d, --ftp_root_directory TEXT  MetaboLights study directory on FTP server
                                 URL.
  -l, --use_only_local           Use only current local directory without
                                 connecting FTP server.
  -o, --override_local_files     Downloads files and override current local
                                 copies. It is valid if there is no
                                 use_only_local option
  -i, --load_folder_index        Create a folder index to store file
                                 descriptors on FTP seerver. It is valid if
                                 there is no use_only_local option.
  --use_study_model_cache        Use only current local directory without
                                 connecting FTP server.
  -c, --local_cache_path TEXT    Path to store cache files of FTP file
                                 indices, study models, etc.
  -h, --help                     Show this message and exit.
```

## metabolights-utils_mtbls_public_download

### Tool Description
Download study data and metadata files from MetaboLights.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls public download [OPTIONS] STUDY_ID [FILE]

  Download study data and metadata files from MetaboLights FTP server.

  study_id: MetaboLights study accession number (MTBLSxxxx).

  file (optional): Relative file path in study folder. All ISA metadata files
  will be downloaded if not specified.

Options:
  -p, --local_path TEXT          Local storage root path. Folder will be
                                 created if it does not exist.
  -f, --ftp_server_url TEXT      FTP server URL where MetaboLights repository
                                 is hosted.
  -d, --ftp_root_directory TEXT  MetaboLights study directory on FTP server
                                 URL.
  -c, --local_cache_path TEXT    Path to store cache files of FTP file
                                 indices, study models, etc.
  -o, --override_local_files     Downloads files and override current local
                                 copies.
  -h, --help                     Show this message and exit.
```

## metabolights-utils_mtbls_public_list

### Tool Description
List studies and study folder content.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls public list [OPTIONS] [STUDY_ID] [SUBDIRECTORY]

  List studies and study folder content. It works for both local and remote
  FTP repository.

  study_id (optional): MetaboLights study accession number (MTBLSxxxx). List
  all studies if not specified.

  subdirectory (optional): Subdirectory of study to list its content. List the
  study root folder if not specified..

Options:
  -p, --local_path TEXT          Local storage root path. Folder will be
                                 created if it does not exist.
  -f, --ftp_server_url TEXT      FTP server URL where MetaboLights repository
                                 is hosted.
  -d, --ftp_root_directory TEXT  MetaboLights study directory on FTP server
                                 URL.
  -c, --local_cache_path TEXT    Path to store cache files of FTP file
                                 indices, study models, etc.
  -l, --use_only_local           Use only current local directory without
                                 connecting FTP server.
  -h, --help                     Show this message and exit.
```

## metabolights-utils_mtbls_public_remove

### Tool Description
Delete local study data and metadata files.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls public remove [OPTIONS] STUDY_ID

  Delete local study data and metadata files.

  study_id: MetaboLights study accession number (MTBLSxxxx).

Options:
  -p, --local_path TEXT        Local storage root path. Folder will be created
                               if it does not exist.
  -c, --local_cache_path TEXT  Path to store cache files of FTP file indices,
                               study models, etc.
  -h, --help                   Show this message and exit.
```

## metabolights-utils_mtbls_public_search

### Tool Description
Search public studies with query keywords.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metabolights/metabolights-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/metabolights-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mtbls public search [OPTIONS] [QUERY]

  Search public studies with query keywords. If there are multiple search
  keywords and no join operator (+, |) defined, results are merged with the
  selected query join operator (and, or)

  query: query terms that will be in search. e.g. cancer, (mus musculus)

Options:
  -u, --search_rest_api_url TEXT  MetaboLights search API URL.
  -s, --skip INTEGER              Skip n items from the matched items.
  -l, --limit INTEGER             Maximum number items in response. Maximum
                                  return size is 100 items.
  -j, --query_join_operator TEXT  If multiple keywords are defined and there
                                  is no join operator (+, |) in query, One of
                                  the 'and' (default) or 'or' operator will be
                                  used.
  -b, --body TEXT                 Advanced filter options in json format.
                                  Please read the API documentation.
  --study_ids, --id               Shows only MetaboLights accession numbers.
  --raw                           Shows raw result in json format.
  -h, --help                      Show this message and exit.
```

