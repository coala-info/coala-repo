# bioprov CWL Generation Report

## bioprov

### Tool Description
BioProv is a library for managing bioinformatics provenance. (Note: The provided help text contains a system error/traceback and does not list available command-line arguments.)

### Metadata
- **Docker Image**: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
- **Homepage**: https://github.com/vinisalazar/BioProv
- **Package**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vinisalazar/BioProv
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
Traceback (most recent call last):
  File "/usr/local/bin/bioprov", line 12, in <module>
    from bioprov.bioprov import main
  File "/usr/local/lib/python3.9/site-packages/bioprov/__init__.py", line 14, in <module>
    from .src.config import config, Environment, BioProvDB, Config
  File "/usr/local/lib/python3.9/site-packages/bioprov/src/config.py", line 315, in <module>
    config = Config()
  File "/usr/local/lib/python3.9/site-packages/bioprov/src/config.py", line 50, in __init__
    self._db = BioProvDB(self.db_path)
  File "/usr/local/lib/python3.9/site-packages/bioprov/src/config.py", line 221, in __init__
    super().__init__(path)
  File "/usr/local/lib/python3.9/site-packages/tinydb/database.py", line 89, in __init__
    self._storage = storage(*args, **kwargs)  # type: Storage
  File "/usr/local/lib/python3.9/site-packages/tinydb/storages.py", line 102, in __init__
    touch(path, create_dirs=create_dirs)
  File "/usr/local/lib/python3.9/site-packages/tinydb/storages.py", line 31, in touch
    with open(path, 'a'):
OSError: [Errno 30] Read-only file system: '/usr/local/lib/python3.9/site-packages/bioprov/db.json'
```


## Metadata
- **Skill**: generated
