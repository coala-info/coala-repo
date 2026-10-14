# phables CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phables_config | Failed | tool bug: phables config 1.5.0 always crashes with TypeError (copy_config is called without the system config path) |
| phables_run | Not completed | pipeline, skipped |

## phables_run

### Tool Description
Run Phables

### Metadata
- **Docker Image**: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vini2/phables
- **Package**: https://anaconda.org/channels/bioconda/packages/phables/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phables/overview
- **Total Downloads**: 19.9K
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/Vini2/phables
- **Stars**: N/A
### Original Help Text
```text
Usage: phables run [OPTIONS] [SNAKE_ARGS]...

  Run Phables

Options:
  --output PATH                 Output directory  [default: phables.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/config.yaml]
  --threads INTEGER             Number of threads to use  [default: 1]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: use-
                                conda]
  --conda-prefix PATH           Custom conda env directory
  --profile TEXT                Snakemake profile
  --snake-default TEXT          Customise Snakemake runtime args  [default:
                                --rerun-incomplete, --printshellcmds,
                                --nolock, --show-failed-logs]
  --input PATH                  Path to assembly graph file in .GFA format
                                [required]
  --reads PATH                  Path to directory containing paired-end reads
                                [required]
  --minlength INTEGER           minimum length of circular unitigs to consider
                                [default: 2000]
  --mincov INTEGER              minimum coverage of paths to output  [default:
                                10]
  --compcount INTEGER           maximum unitig count to consider a component
                                [default: 200]
  --maxpaths INTEGER            maximum number of paths to resolve for a
                                component  [default: 10]
  --mgfrac FLOAT                length threshold to consider single copy
                                marker genes  [default: 0.2]
  --evalue FLOAT                maximum e-value for phrog annotations
                                [default: 1e-10]
  --seqidentity FLOAT           minimum sequence identity for phrog
                                annotations  [default: 0.3]
  --covtol INTEGER              coverage tolerance for extending subpaths
                                [default: 100]
  --alpha FLOAT                 coverage multiplier for flow interval
                                modelling  [default: 1.2]
  --longreads                   provide long reads as input (else defaults to
                                short reads)
  --prefix TEXT                 prefix for genome identifier
  -h, --help                    Show this message and exit.

  
  If you use Phables in your work, please cite Phables as,
  
  Vijini Mallawaarachchi, Michael J Roach, Przemyslaw Decewicz, 
  Bhavya Papudeshi, Sarah K Giles, Susanna R Grigson, George Bouras, 
  Ryan D Hesse, Laura K Inglis, Abbey L K Hutton, Elizabeth A Dinsdale, 
  Robert A Edwards, Phables: from fragmented assemblies to high-quality 
  bacteriophage genomes, Bioinformatics, Volume 39, Issue 10, 
  October 2023, btad586, https://doi.org/10.1093/bioinformatics/btad586
  
  
  For more information on Phables please visit:
  https://phables.readthedocs.io/
  
  
  CLUSTER EXECUTION:
  phables run ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           phables run --input [assembly graph file]
  Specify threads:    phables run ... --threads [threads]
  Disable conda:      phables run ... --no-use-conda 
  Change defaults:    phables run ... --snake-default="-k --nolock"
  Add Snakemake args: phables run ... --dry-run --keep-going --touch
  Specify targets:    phables run ... print_stages
  Available targets:
      all             Run everything (default)
      preprocess      Run preprocessing only
      phables         Run phables (and preprocessing if needed)
      postprocess     Run postprocessing (with preprocessing and phables if needed)
      print_stages    List available stages
```

## phables_config

### Tool Description
Copy system default config to phables.out/config.yaml

### Metadata
- **Docker Image**: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vini2/phables
- **Package**: https://anaconda.org/channels/bioconda/packages/phables/overview
- **Validation**: PASS

### Original Help Text
```text
[2026:02:25 00:51:02] Copying system default config to phables.out/config.yaml
Traceback (most recent call last):
  File "/usr/local/bin/phables", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.10/site-packages/phables/__main__.py", line 348, in main
    cli()
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1485, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1406, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1873, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 1269, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.10/site-packages/click/core.py", line 824, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/phables/__main__.py", line 331, in config
    copy_config(configfile)
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
- **Skill**: generated
