# axiome CWL Generation Report

## axiome_ui

### Tool Description
AXIOME (Automated eXploration of Microbial Ecology) terminal user interface.

### Metadata
- **Docker Image**: quay.io/biocontainers/axiome:2.0.4--py27_0
- **Homepage**: https://github.com/ujjwalredd/Axiomeer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/axiome/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ujjwalredd/Axiomeer
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Traceback (most recent call last):
  File "/usr/local/bin/axiome", line 6, in <module>
    sys.exit(axiome.axiome.main())
  File "/usr/local/lib/python2.7/site-packages/axiome/axiome.py", line 28, in main
    App.run()
  File "/usr/local/lib/python2.7/site-packages/npyscreen/apNPSApplication.py", line 30, in run
    return npyssafewrapper.wrapper(self.__remove_argument_call_main)
  File "/usr/local/lib/python2.7/site-packages/npyscreen/npyssafewrapper.py", line 41, in wrapper
    wrapper_no_fork(call_function)
  File "/usr/local/lib/python2.7/site-packages/npyscreen/npyssafewrapper.py", line 82, in wrapper_no_fork
    locale.setlocale(locale.LC_ALL, '')
  File "/usr/local/lib/python2.7/locale.py", line 581, in setlocale
    return _setlocale(category, locale)
locale.Error: unsupported locale setting
```


## axiome_process

### Tool Description
Axiome process command for data processing

### Metadata
- **Docker Image**: quay.io/biocontainers/axiome:2.0.4--py27_0
- **Homepage**: https://github.com/ujjwalredd/Axiomeer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: axiome process [-h] -i input
axiome process: error: argument -h/--help: ignored explicit argument 'elp'
```


## axiome_utility

### Tool Description
Generates a file mapping template or copies AXIOME sample data into the current directory

### Metadata
- **Docker Image**: quay.io/biocontainers/axiome:2.0.4--py27_0
- **Homepage**: https://github.com/ujjwalredd/Axiomeer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: axiome utility [-h] {mapping_template,sample_data}

positional arguments:
  {mapping_template,sample_data}
                        mapping_template: generates a file mapping template in
                        the current directory, which can be opened in a
                        spreadsheet program; sample_data: copies AXIOME sample
                        data into the current directory

optional arguments:
  -h, --help            show this help message and exit
```


## Metadata
- **Skill**: generated
