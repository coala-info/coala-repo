# irida-uploader CWL Generation Report

## irida-uploader

### Tool Description
This program parses sequencing runs and uploads them to IRIDA.

### Metadata
- **Docker Image**: quay.io/biocontainers/irida-uploader:0.9.5--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/irida-uploader
- **Package**: https://anaconda.org/channels/bioconda/packages/irida-uploader/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irida-uploader/overview
- **Total Downloads**: 51.4K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/phac-nml/irida-uploader
- **Stars**: N/A
### Original Help Text
```text
usage: irida-uploader -d DIRECTORY [-h] [--version] [-c CONFIG] [-f] [-p] [-b]
                                   [-u UPLOAD_MODE] [-ci [CONFIG_CLIENT_ID]]
                                   [-cs [CONFIG_CLIENT_SECRET]]
                                   [-cu [CONFIG_USERNAME]]
                                   [-cp [CONFIG_PASSWORD]]
                                   [-cb [CONFIG_BASE_URL]]
                                   [-cr [CONFIG_PARSER]] [-r] [-cd [DELAY]]
                                   [-ct [CONFIG_TIMEOUT]]
                                   [-fs [MINIMUM_FILE_SIZE]]

This program parses sequencing runs and uploads them to IRIDA.

required arguments:
  -d DIRECTORY, --directory DIRECTORY
                        Location of sequencing run to upload.
                        Directory must be writable.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -c, --config CONFIG   Path to an alternative configuration file. This
                        overrides the default config file in the config
                        directory
  -f, --force           Uploader will ignore the status file, and try to
                        upload even when a run is in non new status.
  -p, --continue_partial
                        Uploader will continue an existing upload run when
                        upload status is partial.
  -b, --batch           Uploader will expect a directory containing a
                        sequencing run directories, and upload in batch. The
                        list of runs is generated at start time (Runs added to
                        directory mid upload will not be uploaded).
  -u, --upload_mode UPLOAD_MODE
                        Choose which upload mode to use. Supported modes:
                        ['default', 'assemblies', 'fast5']
  -ci, --config_client_id [CONFIG_CLIENT_ID]
                        Override the "client_id" field in config file. This is
                        for the uploader client created in IRIDA, used to
                        handle the data upload
  -cs, --config_client_secret [CONFIG_CLIENT_SECRET]
                        Override "client_secret" in config file. This is for
                        the uploader client created in IRIDA, used to handle
                        the data upload
  -cu, --config_username [CONFIG_USERNAME]
                        Override "username" in config file. This is your IRIDA
                        account username.
  -cp, --config_password [CONFIG_PASSWORD]
                        Override "password" in config file. This corresponds
                        to your IRIDA account.
  -cb, --config_base_url [CONFIG_BASE_URL]
                        Override "base_url" in config file. The api url for
                        your irida instance (example:
                        https://my.irida.server/api/)
  -cr, --config_parser [CONFIG_PARSER]
                        Override "parser" in config file. Choose the type of
                        sequencer data that is being uploaded. Supported
                        parsers: ['miseq', 'miseq_v26', 'miseq_v31',
                        'miseq_win10_jun2021', 'miniseq', 'nextseq',
                        'nextseq2k_nml', 'iseq', 'directory',
                        'nanopore_assemblies', 'seqfu']
  -r, --readonly        Upload in Read Only mode, does not write status or log
                        file to run directory.
  -cd, --delay [DELAY]  Accepts an Integer for minutes to delay. When set, new
                        runs will have their status set to delayed. When
                        uploading a run with the delayed status, the run will
                        only upload if the given amount of minutes has passes
                        since it was set to delayed. Default = 0: When set to
                        0, runs will not be given delayed status.
  -ct, --config_timeout [CONFIG_TIMEOUT]
                        Accepts an Integer for the expected transfer time in
                        seconds per MB. Default is 10 second for every MB of
                        data to transfer (100kb/s). Increasing this number can
                        reduce timeout errors when your transfer speed is very
                        slow.
  -fs, --minimum_file_size [MINIMUM_FILE_SIZE]
                        Accepts an Integer for the minimum file size in KB.
                        Default is 0 KB. Files that are too small will appear
                        as an error during run validation.

-c* options can be used without a parameter to prompt for input.
```


## Metadata
- **Skill**: generated

## irida-uploader_irida-uploader-gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/irida-uploader:0.9.5--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/irida-uploader
- **Package**: https://anaconda.org/channels/bioconda/packages/irida-uploader/overview
- **Validation**: FAIL (generation failed)
### Generation Failed

No inputs — do not generate CWL.

### Validation Errors
- No inputs — do not generate CWL.

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/irida-uploader-gui", line 6, in <module>
    from iridauploader.gui.gui import main
  File "/usr/local/lib/python3.13/site-packages/iridauploader/gui/__init__.py", line 1, in <module>
    from iridauploader.gui.main_dialog import MainDialog
  File "/usr/local/lib/python3.13/site-packages/iridauploader/gui/main_dialog.py", line 3, in <module>
    import PyQt5.QtWidgets as QtWidgets
ModuleNotFoundError: No module named 'PyQt5'
```

