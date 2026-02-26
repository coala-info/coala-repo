# artex CWL Generation Report

## artex

### Tool Description
A tool for variant calling from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/artex:0.2.0--py39h9ee0642_0
- **Homepage**: https://github.com/JMencius/Artex
- **Package**: https://anaconda.org/channels/bioconda/packages/artex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/artex/overview
- **Total Downloads**: 355
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/JMencius/Artex
- **Stars**: N/A
### Original Help Text
```text
2026-02-24 23:24:17,293 - ERROR - -i / --input parameter is not set
Traceback (most recent call last):
  File "/usr/local/bin/artex", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/bin/artex.py", line 39, in main
    input, output, prefix, config, work, ref, model, threads, chunk_size, min_coverage = check_parameter(input, output, prefix, config, work, ref, model, threads, chunk_size, min_coverage, test)
  File "/usr/local/bin/module/check_parameter.py", line 20, in check_parameter
    raise click.UsageError(r"Error: -i / --input parameter is required")
NameError: name 'click' is not defined
```

