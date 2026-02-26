# wes-service-client CWL Generation Report

## wes-service-client_wes-client

### Tool Description
Workflow Execution Service

### Metadata
- **Docker Image**: quay.io/biocontainers/wes-service-client:2.7--py_1
- **Homepage**: https://github.com/common-workflow-language/workflow-service
- **Package**: https://anaconda.org/channels/bioconda/packages/wes-service-client/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wes-service-client/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/common-workflow-language/workflow-service
- **Stars**: N/A
### Original Help Text
```text
usage: wes-client [-h] [--host HOST] [--auth AUTH] [--proto PROTO] [--quiet]
                  [--outdir OUTDIR] [--attachments ATTACHMENTS] [--page PAGE]
                  [--page-size PAGE_SIZE]
                  [--run | --get GET | --log LOG | --list | --info | --version]
                  [--wait | --no-wait]
                  [workflow_url] [job_order]

Workflow Execution Service

positional arguments:
  workflow_url
  job_order

optional arguments:
  -h, --help            show this help message and exit
  --host HOST           Example: '--host=localhost:8080'. Defaults to
                        WES_API_HOST.
  --auth AUTH           Defaults to WES_API_AUTH.
  --proto PROTO         Options: [http, https]. Defaults to WES_API_PROTO
                        (https).
  --quiet
  --outdir OUTDIR
  --attachments ATTACHMENTS
                        A comma separated list of attachments to include.
                        Example: --attachments="testdata/dockstore-tool-
                        md5sum.cwl,testdata/md5sum.input"
  --page PAGE
  --page-size PAGE_SIZE
  --run
  --get GET             Specify a <workflow-id>. Example: '--get=<workflow-
                        id>'
  --log LOG             Specify a <workflow-id>. Example: '--log=<workflow-
                        id>'
  --list
  --info
  --version
  --wait
  --no-wait
```

