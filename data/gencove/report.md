# gencove CWL Generation Report

## gencove_basespace

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
- **Homepage**: https://docs.gencove.com
- **Package**: https://anaconda.org/channels/bioconda/packages/gencove/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/gencove/overview
- **Total Downloads**: 32.0K
- **Last updated**: 2025-12-27
- **GitHub**: https://github.com/gncv/gencove-cli
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



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


## gencove_autoimports

### Tool Description
List BaseSpace autoimports

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


## Metadata
- **Skill**: generated
