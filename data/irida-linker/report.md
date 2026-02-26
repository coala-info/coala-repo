# irida-linker CWL Generation Report

## irida-linker_ngsArchiveLinker.pl

### Tool Description
Link or download sequence files from the IRIDA NGS Archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/irida-linker:1.1.1--hdfd78af_2
- **Homepage**: https://github.com/phac-nml/irida-linker
- **Package**: https://anaconda.org/channels/bioconda/packages/irida-linker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irida-linker/overview
- **Total Downloads**: 17.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/irida-linker
- **Stars**: N/A
### Original Help Text
```text
Usage:
    ngsArchiveLinker.pl -b <API URL> -p <projectId> -o <outputDirectory> [-s
    <sampleId> ...] [-t <filetype>]

Options:
    -p, --projectId [ARG]
            The ID of the project to get data from. (required)

    -o, --output [ARG]
            A directory to output the collection of links. (Default: Current
            working directory)

    -c, --config [ARG]
            The location of the config file. Not required if --baseURL
            option is used. (Default: $HOME/.irida/ngs-archive-linker.conf,
            /etc/irida/ngs-archive-linker.conf)

    -b, --baseURL [ARG]
            The base URL for the NGS Archive REST API. Overrides config file
            setting.

    -s, --sample [ARG]
            A sample id to get sequence files for. Not required. Multiple
            samples may be listed as -s 1 -s 2 -s 3...

    -t, --type [ARG]
            Type of file to link or download. Not required. Available
            options: "fastq", "assembly". Default "fastq". To get both
            types, you can enter --type fastq,assembly

    -i, --ignore
            Ignore creating links for files that already exist.

    -r, --rename
            Rename existing files with _# suffix. Useful for topup runs with
            similar filenames. NOTE: This option overrides the --ignore
            option.

    --flat  Create links or files in a flat directory under the project name
            rather than in sample directories.

    --username
            The username to use for API requests. Note: if this option is
            not entered it will be requested during running of the script.

    --password
            The password to use for API requests. Note: if this option is
            not entered it will be requested during running of the script.

    --download
            Option to download files from the REST API instead of
            softlinking. Note: Files may be quite large. This option is not
            recommended if you have access to the sequencing filesystem.

    -v, --verbose
            Print verbose messages.

    -h, --help
            Display a help message.

    --version
            Print version.
```

