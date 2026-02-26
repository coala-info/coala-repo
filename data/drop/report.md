# drop CWL Generation Report

## drop_demo

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drop:1.5.0--pyhdfd78af_1
- **Homepage**: https://github.com/gagneurlab/drop
- **Package**: https://anaconda.org/channels/bioconda/packages/drop/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/drop/overview
- **Total Downloads**: 59.8K
- **Last updated**: 2025-11-01
- **GitHub**: https://github.com/gagneurlab/drop
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: drop demo [OPTIONS]
Try 'drop demo --help' for help.

Error: No such option: --h Did you mean --help?
```


## drop_init

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drop:1.5.0--pyhdfd78af_1
- **Homepage**: https://github.com/gagneurlab/drop
- **Package**: https://anaconda.org/channels/bioconda/packages/drop/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
create /Scripts
create /.drop
create /.drop/tmp
/Scripts/AberrantExpression/pipeline is not a directory, copy over from drop base
/Scripts/AberrantSplicing/pipeline is not a directory, copy over from drop base
/Scripts/MonoallelicExpression/pipeline is not a directory, copy over from drop base
/Scripts/rnaVariantCalling/pipeline is not a directory, copy over from drop base
init...done
warning: OUTRIDER and FRASER are now released under CC-BY-NC 4.0, meaning a license is required for any commercial use. If you intend to use the aberrant expression and aberrant splicing modules for commercial purposes, please contact the authors: Julien Gagneur (gagneur [at] in.tum.de), Christian Mertes (mertes [at] in.tum.de), and Vicente Yepez (yepez [at] in.tum.de).
```


## drop_update

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drop:1.5.0--pyhdfd78af_1
- **Homepage**: https://github.com/gagneurlab/drop
- **Package**: https://anaconda.org/channels/bioconda/packages/drop/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
updating local Scripts if necessary
Traceback (most recent call last):
  File "/usr/local/bin/drop", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1462, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1383, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1850, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1246, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 814, in invoke
    return callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/drop/cli.py", line 164, in update
    drop.checkDropVersion(Path().cwd().resolve(), force=True)
  File "/usr/local/lib/python3.11/site-packages/drop/setupDrop.py", line 59, in checkDropVersion
    version_file.touch()
  File "/usr/local/lib/python3.11/pathlib.py", line 1108, in touch
    fd = os.open(self, flags, mode)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: '/.drop/.version'
```

