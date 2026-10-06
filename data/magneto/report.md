# magneto CWL Generation Report

## magneto_run

### Tool Description
Run the magneto workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/magneto:1.5.1--pyhdfd78af_0
- **Homepage**: https://gitlab.univ-nantes.fr/bird_pipeline_registry/magneto
- **Package**: https://anaconda.org/channels/bioconda/packages/magneto/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/magneto", line 10, in <module>
    sys.exit(cli())
             ^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1485, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1406, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1873, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1269, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 824, in invoke
    return callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/magneto/magneto.py", line 141, in run
    target = init_workflow(workflow, skip_qc, merge, wd)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/magneto/magneto.py", line 22, in init_workflow
    f_CONFIG = open(os.path.join(wd, "config", "config.yaml"), "r")
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: './config/config.yaml'
```

