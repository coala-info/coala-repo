# coconet-binning CWL Generation Report

## coconet-binning_coconet

### Tool Description
CoCoNet: a tool for binning metagenomic contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/coconet-binning:1.1.0--py_0
- **Homepage**: https://github.com/Puumanamana/CoCoNet
- **Package**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Puumanamana/CoCoNet
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/coconet", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/coconet/coconet.py", line 41, in main
    cfg.init_config(mkdir=True, **params)
  File "/usr/local/lib/python3.7/site-packages/coconet/core/config.py", line 64, in init_config
    self.set_input(name, value)
  File "/usr/local/lib/python3.7/site-packages/coconet/core/config.py", line 79, in set_input
    filepath = Path(val)
  File "/usr/local/lib/python3.7/pathlib.py", line 1027, in __new__
    self = cls._from_parts(args, init=False)
  File "/usr/local/lib/python3.7/pathlib.py", line 674, in _from_parts
    drv, root, parts = self._parse_args(args)
  File "/usr/local/lib/python3.7/pathlib.py", line 658, in _parse_args
    a = os.fspath(a)
TypeError: expected str, bytes or os.PathLike object, not NoneType
```

