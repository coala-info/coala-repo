# gencove CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gencove_autoimport_list | Not completed | needs a Gencove account and API key; the image also crashes at import (pydantic field_validator missing) |
| gencove_basespace_autoimports_create | Not completed | needs a Gencove account and API key; the image also crashes at import (pydantic field_validator missing) |

## gencove_autoimport_list

### Tool Description
List BaseSpace autoimports.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
- **Homepage**: https://docs.gencove.com
- **Package**: https://anaconda.org/channels/bioconda/packages/gencove/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/gencove", line 6, in <module>
    from gencove.cli import cli
  File "/usr/local/lib/python3.12/site-packages/gencove/cli.py", line 5, in <module>
    from gencove.command.basespace import basespace
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/__init__.py", line 2, in <module>
    from .cli import basespace  # noqa: F401
    ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/cli.py", line 5, in <module>
    from .autoimports.cli import autoimports
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/autoimports/__init__.py", line 2, in <module>
    from .cli import autoimports  # noqa: F401
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/autoimports/cli.py", line 5, in <module>
    from .autoimport_list.cli import autoimport_list
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/autoimports/autoimport_list/cli.py", line 9, in <module>
    from .main import BaseSpaceAutoImportList
  File "/usr/local/lib/python3.12/site-packages/gencove/command/basespace/autoimports/autoimport_list/main.py", line 5, in <module>
    from ....base import Command
  File "/usr/local/lib/python3.12/site-packages/gencove/command/base.py", line 13, in <module>
    from gencove.client import APIClient, APIClientError
  File "/usr/local/lib/python3.12/site-packages/gencove/client.py", line 34, in <module>
    from gencove.models import BaseSpaceBiosample, ExplorerDataCredentials  # noqa: I101
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/gencove/models.py", line 6, in <module>
    from pydantic import BaseModel, HttpUrl, field_validator
ImportError: cannot import name 'field_validator' from 'pydantic' (/usr/local/lib/python3.12/site-packages/pydantic/__init__.cpython-312-x86_64-linux-gnu.so). Did you mean: 'root_validator'?
```

## gencove_basespace_autoimports_create

### Tool Description
Sets up periodic import of BaseSpace projects to a Gencove project (help rebuilt from the package source because the image crashes at import).

### Metadata
- **Docker Image**: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
- **Homepage**: https://docs.gencove.com
- **Package**: https://anaconda.org/channels/bioconda/packages/gencove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gencove basespace autoimports create [OPTIONS] PROJECT_ID IDENTIFIER

  Sets up periodic import of BaseSpace projects (their Biosamples) whose name
  contain the identifer to a project in Gencove. Optionally assign metadata to
  the samples to be added when the automatic import job runs.

  `PROJECT_ID`: Gencove project ID

  `IDENTIFIER`: string used for identifying projects on BaseSpace

Options:
  --metadata-json TEXT  Add metadata to all samples that are to be imported
                        from BaseSpace to a project.
  --host TEXT           Optional Gencove API host, including http/s protocol.
  --email TEXT          Gencove user email to be used in login.
  --password TEXT       Gencove user password to be used in login.
  --api-key TEXT        Gencove api key.
  --help                Show this message and exit.
```

## Metadata
- **Skill**: generated
