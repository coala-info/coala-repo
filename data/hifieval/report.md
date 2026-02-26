# hifieval CWL Generation Report

## hifieval_hifieval.py

### Tool Description
HIFI-eval is a tool for evaluating the quality of HiFi reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
- **Homepage**: https://github.com/magspho/hifieval
- **Package**: https://anaconda.org/channels/bioconda/packages/hifieval/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hifieval/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/magspho/hifieval
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/hifieval.py", line 697, in <module>
    main(sys.argv)
  File "/usr/local/bin/hifieval.py", line 618, in main
    opts, args = getopt.getopt(argv[1:],"o:h:br:c:", 
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/getopt.py", line 93, in getopt
    opts, args = do_longs(opts, args[0][2:], longopts, args[1:])
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/getopt.py", line 157, in do_longs
    has_arg, opt = long_has_args(opt, longopts)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/getopt.py", line 174, in long_has_args
    raise GetoptError(_('option --%s not recognized') % opt, opt)
getopt.GetoptError: option --help not recognized
```

