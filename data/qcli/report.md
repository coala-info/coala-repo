# qcli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| qcli_make_rst | PASS | uses the bioconda image quay.io/biocontainers/qcli:0.1.1--py_3 because the Debian image has no qcli scripts. |
| qcli_make_script | PASS | uses the bioconda image quay.io/biocontainers/qcli:0.1.1--py_3 because the Debian image has no qcli scripts. |

## qcli_make_rst

### Tool Description
This script will take a qcli script and convert the usage strings and options to generate a documentation .rst file.

### Metadata
- **Docker Image**: quay.io/biocontainers/qcli:0.1.1--py_3
- **Homepage**: https://github.com/bipy/qcli
- **Package**: https://anaconda.org/channels/bioconda/packages/qcli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qcli_make_rst [options] {-i/--input_fps INPUT_FPS -o/--output_dir OUTPUT_DIR}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

This script will take a qcli script and convert the usage strings and options to generate a documentation .rst file.

Example usage: 
Print help message and exit
 qcli_make_rst -h

Create RST for many files: Create rst files for all files ending with .py in the scripts/ directory. Write the rst files to the rst directory. Note that if the value you pass for -i contains a wildcard character (e.g., "*"), the value must be wrapped in quotes.
 qcli_make_rst -i "scripts/*py" -o rst

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -i INPUT_FPS, --input_fps=INPUT_FPS
                        the input file(s) to generate rst files for [REQUIRED]
    -o OUTPUT_DIR, --output_dir=OUTPUT_DIR
                        the directory where the resulting rst file(s) should
                        be written [REQUIRED]
```

## qcli_make_script

### Tool Description
This script will create a template qcli script and make it executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/qcli:0.1.1--py_3
- **Homepage**: https://github.com/bipy/qcli
- **Package**: https://anaconda.org/channels/bioconda/packages/qcli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: qcli_make_script [options] {-o/--output_fp OUTPUT_FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

This script will create a template qcli script and make it executable.

Example usage: 
Print help message and exit
 qcli_make_script -h

Example usage: Create a new script
 qcli_make_script -a "Greg Caporaso" -e gregcaporaso@gmail.com -o my_script.py

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  -a AUTHOR_NAME, --author_name=AUTHOR_NAME
                        The script author's (probably you) name to be included
                        in the header variables. This will typically need to
                        be enclosed  in quotes to handle spaces.
                        [default:AUTHOR_NAME]
  -e AUTHOR_EMAIL, --author_email=AUTHOR_EMAIL
                        The script author's (probably you) e-mail address to
                        be included in the header variables.
                        [default:AUTHOR_EMAIL]
  -c COPYRIGHT, --copyright=COPYRIGHT
                        The copyright information to be included in the header
                        variables. [default:Copyright 2013, The BiPy project]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -o OUTPUT_FP, --output_fp=OUTPUT_FP
                        The output filepath. [REQUIRED]
```

## Metadata
- **Skill**: generated
