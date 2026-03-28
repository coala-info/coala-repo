# montreal-forced-aligner CWL Generation Report

## montreal-forced-aligner_mfa

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/conda-forge/packages/montreal-forced-aligner/overview
- **Total Downloads**: 495.3K
- **Last updated**: 2026-02-10
- **GitHub**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa model list acoustic

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa model download acoustic

### Tool Description
Download an acoustic model for Montreal Forced Aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa model download dictionary

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa validate

### Tool Description
Validate the alignment files for a corpus.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa find_oovs

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa align

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa g2p

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa transcribe

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa transcribe_whisper

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa train_acoustic

### Tool Description
Train an acoustic model.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## montreal-forced-aligner_mfa configure

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```


## Metadata
- **Skill**: generated
