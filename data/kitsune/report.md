# kitsune CWL Generation Report

## kitsune_acf

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/natapol/kitsune
- **Package**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/natapol/kitsune
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kitsune", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kitsune/kitsune.py", line 70, in main
    module = importlib.import_module("kitsune.modules.{}".format(cmd))
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 995, in exec_module
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/acf.py", line 7, in <module>
    from kitsune.modules import kitsunejf as jf
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kitsunejf.py", line 9, in <module>
    from pkg_resources import packaging
ImportError: cannot import name 'packaging' from 'pkg_resources' (/usr/local/lib/python3.12/site-packages/pkg_resources/__init__.py)
```


## kitsune_cre

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/natapol/kitsune
- **Package**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kitsune", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kitsune/kitsune.py", line 70, in main
    module = importlib.import_module("kitsune.modules.{}".format(cmd))
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 995, in exec_module
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/cre.py", line 8, in <module>
    from kitsune.modules import kitsunejf as jf
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kitsunejf.py", line 9, in <module>
    from pkg_resources import packaging
ImportError: cannot import name 'packaging' from 'pkg_resources' (/usr/local/lib/python3.12/site-packages/pkg_resources/__init__.py)
```


## kitsune_dmatrix

### Tool Description
Create a dmatrix for XGBoost

### Metadata
- **Docker Image**: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/natapol/kitsune
- **Package**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kitsune", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kitsune/kitsune.py", line 70, in main
    module = importlib.import_module("kitsune.modules.{}".format(cmd))
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 995, in exec_module
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/dmatrix.py", line 9, in <module>
    from kitsune.modules import kitsunejf as jf
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kitsunejf.py", line 9, in <module>
    from pkg_resources import packaging
ImportError: cannot import name 'packaging' from 'pkg_resources' (/usr/local/lib/python3.12/site-packages/pkg_resources/__init__.py)
```


## kitsune_kopt

### Tool Description
Kopt is a tool for optimizing K-mer counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/natapol/kitsune
- **Package**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kitsune", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kitsune/kitsune.py", line 70, in main
    module = importlib.import_module("kitsune.modules.{}".format(cmd))
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 995, in exec_module
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kopt.py", line 23, in <module>
    from kitsune.modules import kitsunejf as jf
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kitsunejf.py", line 9, in <module>
    from pkg_resources import packaging
ImportError: cannot import name 'packaging' from 'pkg_resources' (/usr/local/lib/python3.12/site-packages/pkg_resources/__init__.py)
```


## kitsune_ofc

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/natapol/kitsune
- **Package**: https://anaconda.org/channels/bioconda/packages/kitsune/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kitsune", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kitsune/kitsune.py", line 70, in main
    module = importlib.import_module("kitsune.modules.{}".format(cmd))
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 995, in exec_module
  File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/ofc.py", line 9, in <module>
    from kitsune.modules import kitsunejf as jf
  File "/usr/local/lib/python3.12/site-packages/kitsune/modules/kitsunejf.py", line 9, in <module>
    from pkg_resources import packaging
ImportError: cannot import name 'packaging' from 'pkg_resources' (/usr/local/lib/python3.12/site-packages/pkg_resources/__init__.py)
```


## Metadata
- **Skill**: generated
