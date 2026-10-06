# montreal-forced-aligner CWL Generation Report

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

## Metadata
- **Skill**: generated
