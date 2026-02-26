# bionumpy CWL Generation Report

## bionumpy

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bionumpy:1.0.14--pyh05cac1d_0
- **Homepage**: https://github.com/bionumpy/bionumpy
- **Package**: https://anaconda.org/channels/bioconda/packages/bionumpy/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/bionumpy/overview
- **Total Downloads**: 37.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bionumpy/bionumpy
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/bionumpy/io/vcf_header.py:38: SyntaxWarning: invalid escape sequence '\d'
  regex = re.match('(\d)', x)
/usr/local/lib/python3.13/site-packages/bionumpy/io/vcf_header.py:80: SyntaxWarning: invalid escape sequence '\S'
  regex = re.search('^##(\S+?)=(.*)$', line)
/usr/local/lib/python3.13/site-packages/bionumpy/io/vcf_header.py:86: SyntaxWarning: invalid escape sequence '\S'
  f'^##(\S+?)=(.*)$, get {line}. Ignore this line.'))
/usr/local/lib/python3.13/site-packages/bionumpy/sequence/string_matcher.py:136: SyntaxWarning: invalid escape sequence '\['
  r = re.compile('\[[^\]]+\]')
/usr/local/lib/python3.13/site-packages/bionumpy/sequence/string_matcher.py:149: SyntaxWarning: invalid escape sequence '\['
  r = re.compile('(([A-Z]|\[[A-Z]+\])+)\.\{(\d*)\,(\d+)\}(.+)')
Traceback (most recent call last):
  File "/usr/local/bin/bionumpy", line 6, in <module>
    from bionumpy.cli import main
ImportError: cannot import name 'main' from 'bionumpy.cli' (/usr/local/lib/python3.13/site-packages/bionumpy/cli.py)
```

