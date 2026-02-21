# collectl CWL Generation Report

## collectl

### Tool Description
A performance monitoring tool that collects data for various system subsystems.

### Metadata
- **Docker Image**: quay.io/biocontainers/collectl:4.3.20.2--pl5321h05cac1d_0
- **Homepage**: https://github.com/sharkcz/collectl
- **Package**: https://anaconda.org/channels/bioconda/packages/collectl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/collectl/overview
- **Total Downloads**: 33.5K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/sharkcz/collectl
- **Stars**: N/A
### Original Help Text
```text
This is a subset of the most common switches and even the descriptions are
abbreviated.  To see all type 'collectl -x', to get started just type 'collectl'

usage: collectl [switches]
  -c, --count      count      collect this number of samples and exit
  -f, --filename   file       name of directory/file to write to
  -i, --interval   int        collection interval in seconds [default=1]
  -o, --options    options    misc formatting options, --showoptions for all
                                d|D - include date in output
                                  T - include time in output
                                  z - turn off compression of plot files
  -p, --playback   file       playback results from 'file' (be sure to quote
			      if wild carded) or the shell might mess it up
  -P, --plot                  generate output in 'plot' format
  -s, --subsys     subsys     specify one or more subsystems [default=cdn]
      --verbose               display output in verbose format (automatically
                              selected when brief doesn't make sense)

Various types of help
  -h, --help                  print this text
  -v, --version               print version
  -V, --showdefs              print operational defaults
  -x, --helpextend            extended help, more details descriptions too
  -X, --helpall               shows all help concatenated together

  --showoptions               show all the options
  --showsubsys                show all the subsystems
  --showsubopts               show all subsystem specific options
  --showtopopts               show --top options

  --showheader                show file header that 'would be' generated
  --showcolheaders            show column headers that 'would be' generated
  --showslabaliases           for SLUB allocator, show non-root aliases
  --showrootslabs             same as --showslabaliases but use 'root' names

Copyright 2003-2018 Hewlett-Packard Development Company, L.P.
collectl may be copied only under the terms of either the Artistic License
or the GNU General Public License, which may be found in the source kit
```


## Metadata
- **Skill**: generated
