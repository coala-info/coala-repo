# pytest-xdist CWL Generation Report

## pytest-xdist_pytest

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytest-xdist:1.14--py36_0
- **Homepage**: https://github.com/pytest-dev/pytest-xdist
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/main/packages/pytest-xdist/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/pytest-dev/pytest-xdist
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
============================= test session starts ==============================
platform linux -- Python 3.6.1, pytest-3.0.7, py-1.4.33, pluggy-0.4.0
rootdir: /, inifile:
plugins: xdist-1.14
collected 0 items / 1 errors

==================================== ERRORS ====================================
______________________________ ERROR collecting  _______________________________
usr/local/lib/python3.6/site-packages/py/_error.py:65: in checked_call
    return func(*args, **kwargs)
E   OSError: [Errno 40] Too many levels of symbolic links: '//proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/sys/bus/gpio/drivers/gpio_stub_drv'

During handling of the above exception, another exception occurred:
usr/local/lib/python3.6/site-packages/py/_path/common.py:367: in visit
    for x in Visitor(fil, rec, ignore, bf, sort).gen(self):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:416: in gen
    for p in self.gen(subdir):
usr/local/lib/python3.6/site-packages/py/_path/common.py:401: in gen
    entries = path.listdir()
usr/local/lib/python3.6/site-packages/py/_path/local.py:382: in listdir
    names = py.error.checked_call(os.listdir, self.strpath)
usr/local/lib/python3.6/site-packages/py/_error.py:85: in checked_call
    raise cls("%s%r" % (func.__name__, args))
E   py.error.ELOOP: [Too many levels of symbolic links]: listdir('//proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/proc/1/cwd/sys/bus/gpio/drivers/gpio_stub_drv',)
!!!!!!!!!!!!!!!!!!! Interrupted: 1 errors during collection !!!!!!!!!!!!!!!!!!!!
=========================== 1 error in 9.06 seconds ============================
```

