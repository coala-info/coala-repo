# tesseract CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tesseract | PASS | image changed to the bioconda tesseract image (the old jitesoft image ran tesseract as its entrypoint, so the command was doubled); tested on tesseract's own eurotext.png test image with txt and tsv output. |

## tesseract

### Tool Description
Tesseract Open Source OCR Engine

### Metadata
- **Docker Image**: quay.io/biocontainers/tesseract:5.5.1
- **Homepage**: https://github.com/tesseract-ocr/tesseract
- **Package**: Not found
- **Validation**: PASS
- **manual**: https://tesseract-ocr.github.io/tessdoc/

- **Conda**: https://anaconda.org/channels/bioconda/packages/tesseract/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tesseract-ocr/tesseract
- **Stars**: N/A
### Original Help Text
```text
Usage:
  tesseract --help | --help-extra | --version
  tesseract --list-langs
  tesseract imagename outputbase [options...] [configfile...]

OCR options:
  -l LANG[+LANG]        Specify language(s) used for OCR.
NOTE: These options must occur before any configfile.

Single options:
  --help                Show this help message.
  --help-extra          Show extra help for advanced users.
  --version             Show version information.
  --list-langs          List available languages for tesseract engine.
```

## Metadata
- **Skill**: generated
