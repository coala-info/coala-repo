# biofluff CWL Generation Report

## biofluff_fluff

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/biofluff:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/simonvh/fluff
- **Package**: https://anaconda.org/channels/bioconda/packages/biofluff/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biofluff/overview
- **Total Downloads**: 57.7K
- **Last updated**: 2025-08-10
- **GitHub**: https://github.com/simonvh/fluff
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fluff", line 6, in <module>
    from fluff.parse import main
  File "/usr/local/lib/python3.12/site-packages/fluff/parse.py", line 4, in <module>
    from fluff.commands.heatmap import heatmap
  File "/usr/local/lib/python3.12/site-packages/fluff/commands/heatmap.py", line 17, in <module>
    from fluff.plot import heatmap_plot
  File "/usr/local/lib/python3.12/site-packages/fluff/plot.py", line 22, in <module>
    GENE_ARROW = ArrowStyle._Curve(beginarrow=False, endarrow=True, head_length=.4, head_width=.4)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: ArrowStyle._Curve.__init__() got an unexpected keyword argument 'beginarrow'
```

