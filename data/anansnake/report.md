# anansnake CWL Generation Report

## anansnake

### Tool Description
A tool for the analysis of ANANSE (Gene Regulatory Network) workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/anansnake:0.1.0--pyh7cba7a3_0
- **Homepage**: https://github.com/vanheeringen-lab/anansnake
- **Package**: https://anaconda.org/channels/bioconda/packages/anansnake/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/anansnake/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/anansnake
- **Stars**: 2
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Traceback (most recent call last):
  File "/usr/local/bin/anansnake", line 7, in <module>
    from anansnake.scripts.cli import cli
  File "/usr/local/lib/python3.10/site-packages/anansnake/scripts/cli.py", line 7, in <module>
    from seq2science import __version__ as version_s2s  # noqa
  File "/usr/local/lib/python3.10/site-packages/seq2science/__init__.py", line 1, in <module>
    from . import util
  File "/usr/local/lib/python3.10/site-packages/seq2science/util.py", line 24, in <module>
    import genomepy
  File "/usr/local/lib/python3.10/site-packages/genomepy/__init__.py", line 10, in <module>
    from genomepy.annotation import Annotation, query_mygene
  File "/usr/local/lib/python3.10/site-packages/genomepy/annotation/__init__.py", line 11, in <module>
    from genomepy.annotation.mygene import _map_genes, query_mygene
  File "/usr/local/lib/python3.10/site-packages/genomepy/annotation/mygene.py", line 10, in <module>
    from genomepy.caching import cache_exp_other, disk_cache, lock
  File "/usr/local/lib/python3.10/site-packages/genomepy/caching.py", line 29, in <module>
    os.makedirs(genomepy_cache_dir, exist_ok=True)
  File "/usr/local/lib/python3.10/os.py", line 215, in makedirs
    makedirs(head, exist_ok=exist_ok)
  File "/usr/local/lib/python3.10/os.py", line 225, in makedirs
    mkdir(name, mode)
FileNotFoundError: [Errno 2] No such file or directory: '/user/qianghu/.cache/genomepy'
```


## Metadata
- **Skill**: generated
