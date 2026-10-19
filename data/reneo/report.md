# reneo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| reneo_config | Failed | tool bug: reneo config crashes with a TypeError because copy_config gets no system config path |
| reneo_run | Not completed | pipeline, skipped |

## reneo_run

### Tool Description
Run Reneo

### Metadata
- **Docker Image**: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vini2/phables
- **Package**: https://anaconda.org/channels/bioconda/packages/reneo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reneo/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Vini2/phables
- **Stars**: N/A
### Original Help Text
```text
Usage: reneo run [OPTIONS] [SNAKE_ARGS]...

  Run Reneo

Options:
  --input PATH                    Path to assembly graph file in .GFA format
                                  [required]
  --reads PATH                    Path to directory or TSV containing paired-
                                  end reads  [required]
  --minlength INTEGER             minimum length of circular unitigs to
                                  consider  [default: 1000]
  --mincov INTEGER                minimum coverage of paths to output
                                  [default: 1]
  --compcount INTEGER             maximum unitig count to consider a component
                                  [default: 200]
  --maxpaths INTEGER              maximum number of paths to resolve for a
                                  component  [default: 10]
  --mgfrac FLOAT                  length threshold to consider single copy
                                  marker genes  [default: 0.2]
  --evalue FLOAT                  maximum e-value for vog annotations
                                  [default: 1e-10]
  --hmmscore FLOAT                minimum hmm score for vog annotations
                                  [default: 50]
  --nvogs INTEGER                 minimum number of vogs to consider a
                                  component  [default: 10]
  --covtol INTEGER                coverage tolerance for extending subpaths
                                  [default: 100]
  --alpha FLOAT                   coverage multiplier for flow interval
                                  modelling  [default: 1.2]
  --databases TEXT                Custom DB location
  --hmmsearch / --no-hmmsearch    Perform or skip HMM searches  [default:
                                  hmmsearch]
  --unitigs / --no-unitigs        Output unitigs file  [default: unitigs]
  --split-paths / --no-split-paths
                                  Output fasta file for each path  [default:
                                  split-paths]
  --output PATH                   Output directory  [default: reneo.out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/config.yaml]
  --threads INTEGER               Number of threads to use  [default: 8]
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --printshellcmds, --nolock, --show-failed-
                                  logs]
  --profile TEXT                  Snakemake profile to use
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  reneo run ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           reneo run --input [assembly_graph.gfa] --reads [reads.dir/tsv]
  Specify threads:    reneo run ... --threads [threads]
  Disable conda:      reneo run ... --no-use-conda 
  Change defaults:    reneo run ... --snake-default="-k --nolock"
  Add Snakemake args: reneo run ... --dry-run --keep-going --touch
  Specify targets:    reneo run ... all print_targets
  Available targets:
      all             Run everything (default)
      preprocess      Run preprocessing only
      reneo           Run reneo (and preprocessing if needed)
      postprocess     Run postprocessing (with preprocessing and reneo if needed)
      print_targets   List available targets
```

## reneo_config

### Tool Description
Copy system default config to reneo.out/config.yaml

### Metadata
- **Docker Image**: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vini2/phables
- **Package**: https://anaconda.org/channels/bioconda/packages/reneo/overview
- **Validation**: PASS

### Original Help Text
```text
[2026:02:25 12:07:26] Copying system default config to reneo.out/config.yaml
Traceback (most recent call last):
  File "/usr/local/bin/reneo", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.10/site-packages/reneo/__main__.py", line 387, in main
    cli()
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/reneo/__main__.py", line 369, in config
    copy_config(kwargs["configfile"])
  File "/usr/local/lib/python3.10/site-packages/snaketool_utils/cli_utils.py", line 170, in copy_config
    copyfile(system_config, local_config)
  File "/usr/local/lib/python3.10/shutil.py", line 233, in copyfile
    if _samefile(src, dst):
  File "/usr/local/lib/python3.10/shutil.py", line 210, in _samefile
    return os.path.samefile(src, dst)
  File "/usr/local/lib/python3.10/genericpath.py", line 100, in samefile
    s1 = os.stat(f1)
TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType
```

## Metadata
- **Skill**: not generated
