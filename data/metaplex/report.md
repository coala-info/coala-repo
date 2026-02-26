# metaplex CWL Generation Report

## metaplex_Metaplex-remultiplex

### Tool Description
Remultiplexes a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NGabry/MetaPlex
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/Metaplex-remultiplex", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/metaplex/remultiplexing.py", line 101, in main
    remultiplex(sys.argv[1], sys.argv[2])
IndexError: list index out of range
```


## metaplex_Metaplex-calculate-IJR

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/NGabry/MetaPlex
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplex/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/Metaplex-calculate-IJR", line 6, in <module>
    from metaplex.index_jump import main
  File "/usr/local/lib/python3.9/site-packages/metaplex/index_jump.py", line 8, in <module>
    from qiime2 import Artifact
ModuleNotFoundError: No module named 'qiime2'
```

