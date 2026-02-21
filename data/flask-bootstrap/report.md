# flask-bootstrap CWL Generation Report

## flask-bootstrap

### Tool Description
The provided text does not contain help information or a description of the tool's functionality; it is a log of a failed execution attempt where the executable was not found.

### Metadata
- **Docker Image**: quay.io/biocontainers/flask-bootstrap:3.3.5.7--py36_0
- **Homepage**: https://github.com/cookiecutter-flask/cookiecutter-flask
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flask-bootstrap/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cookiecutter-flask/cookiecutter-flask
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/07 02:15:00  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "flask-bootstrap": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## flask-bootstrap_flask

### Tool Description
Flask command line interface

### Metadata
- **Docker Image**: quay.io/biocontainers/flask-bootstrap:3.3.5.7--py36_0
- **Homepage**: https://github.com/cookiecutter-flask/cookiecutter-flask
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Traceback (most recent call last):
  File "/usr/local/bin/flask", line 6, in <module>
    sys.exit(flask.cli.main())
  File "/usr/local/lib/python3.6/site-packages/flask/cli.py", line 513, in main
    cli.main(args=args, prog_name=name)
  File "/usr/local/lib/python3.6/site-packages/flask/cli.py", line 380, in main
    return AppGroup.main(self, *args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 676, in main
    _verify_python3_env()
  File "/usr/local/lib/python3.6/site-packages/click/_unicodefun.py", line 64, in _verify_python3_env
    stderr=subprocess.PIPE).communicate()[0]
  File "/usr/local/lib/python3.6/subprocess.py", line 707, in __init__
    restore_signals, start_new_session)
  File "/usr/local/lib/python3.6/subprocess.py", line 1326, in _execute_child
    raise child_exception_type(errno_num, err_msg)
FileNotFoundError: [Errno 2] No such file or directory: 'locale'
```

