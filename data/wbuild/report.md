# wbuild CWL Generation Report

## wbuild_demo

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gagneurlab/wBuild
- **Package**: https://anaconda.org/channels/bioconda/packages/wbuild/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/wbuild/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gagneurlab/wBuild
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: wbuild demo [OPTIONS]

  Setup a demo wBuild demo project

Options:
  --help  Show this message and exit.
```


## wbuild_init

### Tool Description
Initialize the repository with wbuild.

### Metadata
- **Docker Image**: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gagneurlab/wBuild
- **Package**: https://anaconda.org/channels/bioconda/packages/wbuild/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wbuild init [OPTIONS]

  Initialize the repository with wbuild.

  This will prepare wBuild in the current project

Options:
  --help  Show this message and exit.
```


## wbuild_update

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gagneurlab/wBuild
- **Package**: https://anaconda.org/channels/bioconda/packages/wbuild/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/wbuild", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1161, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1082, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1697, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1443, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 788, in invoke
    return __callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/wbuild/cli.py", line 86, in update
    raise ValueError(".wBuild doesn't exists. Please run wBuild init first or move to the right directory")
ValueError: .wBuild doesn't exists. Please run wBuild init first or move to the right directory
```

