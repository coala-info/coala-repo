# codingorf CWL Generation Report

## codingorf

### Tool Description
Finds coding regions in a DNA sequence and translates them into amino acid sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/codingorf:v1.0.0--pyh5e36f6f_0
- **Homepage**: https://github.com/Woosub-Kim/codingorf
- **Package**: https://anaconda.org/channels/bioconda/packages/codingorf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/codingorf/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Woosub-Kim/codingorf
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/codingorf", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/codingorf/__main__.py", line 11, in main
    orfParser.getCodingorf()
  File "/usr/local/lib/python3.9/site-packages/codingorf/classmodule.py", line 15, in getCodingorf
    aaSeq = orf.translate()
  File "/usr/local/lib/python3.9/site-packages/Bio/Seq.py", line 1377, in translate
    _translate_str(str(self), table, stop_symbol, to_stop, cds, gap=gap)
  File "/usr/local/lib/python3.9/site-packages/Bio/Seq.py", line 3011, in _translate_str
    raise CodonTable.TranslationError(
Bio.Data.CodonTable.TranslationError: Codon '--H' is invalid
```


## Metadata
- **Skill**: generated
