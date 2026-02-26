# proksee CWL Generation Report

## proksee_assemble

### Tool Description
Assemble reads into a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/proksee-project/proksee-cmd
- **Package**: https://anaconda.org/channels/bioconda/packages/proksee/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proksee/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/proksee-project/proksee-cmd
- **Stars**: N/A
### Original Help Text
```text
Usage: proksee assemble [OPTIONS] FORWARD [REVERSE]

Options:
  -o, --output DIRECTORY  [required]
  --force                 This will force the assembler to proceed when the
                          assembly appears to be poor.
  -s, --species TEXT      The species to assemble. This will override species
                          estimation. Must be spelled correctly.
  -p, --platform TEXT     The sequencing platform used to generate the reads.
                          'Illumina', 'Ion Torrent', or 'Pac Bio'.
  --help                  Show this message and exit.
```


## proksee_evaluate

### Tool Description
Evaluate assembly quality

### Metadata
- **Docker Image**: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/proksee-project/proksee-cmd
- **Package**: https://anaconda.org/channels/bioconda/packages/proksee/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: proksee evaluate [OPTIONS] CONTIGS

Options:
  -s, --species TEXT      The species to assemble. This will override species
                          estimation. Must be spelled correctly.
  -o, --output DIRECTORY  [required]
  --help                  Show this message and exit.
```


## proksee_updatedb

### Tool Description
Update the proksee database

### Metadata
- **Docker Image**: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/proksee-project/proksee-cmd
- **Package**: https://anaconda.org/channels/bioconda/packages/proksee/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/proksee", line 10, in <module>
    sys.exit(cli())
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1128, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1053, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1659, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1395, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 754, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 26, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/proksee/commands/cmd_updatedb.py", line 44, in cli
    update(directory)
  File "/usr/local/lib/python3.7/site-packages/proksee/commands/cmd_updatedb.py", line 78, in update
    config.update(config.MASH_PATH, mash_database_path)
  File "/usr/local/lib/python3.7/site-packages/proksee/config.py", line 37, in update
    with open(CONFIG_FILENAME, 'r') as f:
FileNotFoundError: [Errno 2] No such file or directory: '/usr/local/lib/python3.7/site-packages/config.json'
```

