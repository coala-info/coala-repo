# sodar-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sodar-cli_landingzone_create | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_landingzone_list | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_landingzone_move | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_landingzone_retrieve | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_landingzone_validate | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_project_create | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_project_list | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_project_retrieve | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_project_update | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_samplesheet_export | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_samplesheet_import | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |
| sodar-cli_samplesheet_retrieve | Not completed | new CWL replacing junk; needs a SODAR server and API token (command line is accepted and the tool tries to connect) |

## sodar-cli_landingzone_list

### Tool Description
List landing zones.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli landingzone list [-h] project_uuid

positional arguments:
  project_uuid  UUID of the project to list landing zones for.

optional arguments:
  -h, --help    show this help message and exit
```

## sodar-cli_landingzone_retrieve

### Tool Description
Retrieve landing zone.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli landingzone retrieve [-h] landingzone_uuid

positional arguments:
  landingzone_uuid  UUID of the landing zone to retrieve.

optional arguments:
  -h, --help        show this help message and exit
```

## sodar-cli_landingzone_create

### Tool Description
Create landing zone.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli landingzone create [-h] project_uuid

positional arguments:
  project_uuid  UUID of the project to create landing zone within.

optional arguments:
  -h, --help    show this help message and exit
```

## sodar-cli_landingzone_validate

### Tool Description
Validate landing zone (async).

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli landingzone validate [-h] landingzone_uuid

positional arguments:
  landingzone_uuid  UUID of the landing zone to validate.

optional arguments:
  -h, --help        show this help message and exit
```

## sodar-cli_landingzone_move

### Tool Description
Move landing zone (async).

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli landingzone move [-h] landingzone_uuid

positional arguments:
  landingzone_uuid  UUID of the landing zone to move.

optional arguments:
  -h, --help        show this help message and exit
```

## sodar-cli_project_list

### Tool Description
List Projects.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli project list [-h]

optional arguments:
  -h, --help  show this help message and exit
```

## sodar-cli_project_retrieve

### Tool Description
Retrieve project.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli project retrieve [-h] project_uuid

positional arguments:
  project_uuid  UUID of the project to retrieve.

optional arguments:
  -h, --help    show this help message and exit
```

## sodar-cli_project_create

### Tool Description
Create project (there is no delete!).

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli project create [-h] --title TITLE --parent-uuid PARENT_UUID
                                --owner-uuid OWNER_UUID [--type TYPE]
                                [--description DESCRIPTION] [--readme README]

optional arguments:
  -h, --help            show this help message and exit
  --title TITLE         Title of the project
  --parent-uuid PARENT_UUID
                        UUID of the parent project
  --owner-uuid OWNER_UUID
                        UUID of the owner
  --type TYPE           Type of the project [PROJECT, CATEGORY]
  --description DESCRIPTION
                        Description text, optional
  --readme README       README text, markdown allowed, optional
```

## sodar-cli_project_update

### Tool Description
Update project.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli project update [-h] [--title TITLE]
                                [--parent-uuid PARENT_UUID]
                                [--owner-uuid OWNER_UUID] [--type TYPE]
                                [--description DESCRIPTION] [--readme README]
                                project_uuid

positional arguments:
  project_uuid          UUID of the project to update.

optional arguments:
  -h, --help            show this help message and exit
  --title TITLE         Title of the project
  --parent-uuid PARENT_UUID
                        UUID of the parent project
  --owner-uuid OWNER_UUID
                        UUID of the owner
  --type TYPE           Type of the project [PROJECT, CATEGORY], default
                        PROJECT
  --description DESCRIPTION
                        Description text, optional
  --readme README       README text, markdown allowed, optional
```

## sodar-cli_samplesheet_retrieve

### Tool Description
Retrieve sample sheet for project.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli samplesheet retrieve [-h] project_uuid

positional arguments:
  project_uuid  UUID of project to retrieve sample sheet for

optional arguments:
  -h, --help    show this help message and exit
```

## sodar-cli_samplesheet_import

### Tool Description
Import ISA-tab into project.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli samplesheet import [-h] project_uuid files [files ...]

positional arguments:
  project_uuid  UUID of project to import ISA tab for
  files         paths to files to import

optional arguments:
  -h, --help    show this help message and exit
```

## sodar-cli_samplesheet_export

### Tool Description
Export ISA-tab from project.

### Metadata
- **Docker Image**: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/sodar-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/sodar-cli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sodar-cli samplesheet export [-h] [--print-output]
                                    [--write-output WRITE_OUTPUT]
                                    [--overwrite]
                                    project_uuid

positional arguments:
  project_uuid          UUID of project to retrieve the sample sheet for

optional arguments:
  -h, --help            show this help message and exit
  --print-output        Print output to stdout
  --write-output WRITE_OUTPUT
                        Write output to given path
  --overwrite           Overwrite existing files
```

## Metadata
- **Skill**: not generated
