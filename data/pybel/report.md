# pybel CWL Generation Report

## pybel_compile

### Tool Description
Compile a BEL script to a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pybel/pybel
- **Stars**: N/A
### Original Help Text
```text
Usage: pybel compile [OPTIONS] PATH

  Compile a BEL script to a graph.

Options:
  --allow-naked-names             Enable lenient parsing for naked names
  --allow-nested                  Enable lenient parsing for nested statements
  --disallow-unqualified-translocations
                                  Disallow unqualified translocations
  --no-identifier-validation      Turn off identifier validation
  --no-citation-clearing          Turn off citation clearing
  -r, --required-annotations TEXT
                                  Specify multiple required annotations
  --skip-tqdm
  -v, --verbose
  --help                          Show this message and exit.
```


## pybel_insert

### Tool Description
Insert molecules into a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel insert [OPTIONS] path
Try "pybel insert --help" for help.

Error: no such option: --h  Did you mean --help?
```


## pybel_machine

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pybel", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1137, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 27, in new_func
    return f(get_current_context().obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/pybel/cli.py", line 267, in machine
    from indra.sources import indra_db_rest
ModuleNotFoundError: No module named 'indra'
```


## pybel_manage

### Tool Description
Manage the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage [OPTIONS] COMMAND [ARGS]...

  Manage the database.

Options:
  --help  Show this message and exit.

Commands:
  drop        Drop the database.
  edges       Manage edges.
  examples    Load examples to the database.
  namespaces  Manage namespaces.
  networks    Manage networks.
  nodes       Manage nodes.
  summarize   Summarize the contents of the database.
```


## pybel_neo

### Tool Description
Upload to neo4j.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel neo [OPTIONS] path

  Upload to neo4j.

Options:
  --connection TEXT  Connection string for neo4j upload.
  --password TEXT
  --help             Show this message and exit.
```


## pybel_post

### Tool Description
Upload a graph to BEL Commons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel post [OPTIONS] path

  Upload a graph to BEL Commons.

Options:
  --host TEXT  URL of BEL Commons. Defaults to https://bel-
               commons.scai.fraunhofer.de
  --help       Show this message and exit.
```


## pybel_serialize

### Tool Description
Serialize a graph to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel serialize [OPTIONS] path
Try "pybel serialize --help" for help.

Error: no such option: --h  Did you mean --help?
```


## pybel_summarize

### Tool Description
Summarize a chemical file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel summarize [OPTIONS] path
Try "pybel summarize --help" for help.

Error: no such option: --h  Did you mean --help?
```


## pybel_warnings

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: pybel warnings [OPTIONS] path
Try "pybel warnings --help" for help.

Error: no such option: --h  Did you mean --help?
```

