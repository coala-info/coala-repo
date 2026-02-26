# hubward CWL Generation Report

## hubward_process

### Tool Description
Process one or many studies. Items can be directories containing metadata.yaml/metadata-builder.py or a group configuration YAML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hubward:0.2.2--py27_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hubward/overview
- **Total Downloads**: 14.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/bwa
- **Stars**: N/A
### Original Help Text
```text
usage: hubward process [-h] items [items ...]

    Process one or many studies.

    *items* can be one or more directories or files to process. They are
    handled as follows:

    - If an item to process is a *directory* then it is expected to contain
      either:

        - a file called metadata.yaml (in which case that file is used as-is)

            or

        - a file called metadata-builder.py (in which case it is executed and
          is expected to create a metadata.yaml file).

        Each output file in the metadata.yaml file is considered up-to-date if
        it are newer than both the input file and the script that creates it.
        If it's up-to-date then nothing is done.  Otherwise, the script is run
        to update the output file.

    - If an item to process is a *file* then it is assumed to be a group
      configuration YAML-format file. All directories listed in that file's
      `studies` section will be processed.

    For creating a new study, see `hubward skeleton` which creates template
    files that can be filled in.
    

positional arguments:
  items       Path to directory containing metadata.yaml file or metadata-
              builder.yaml file, or path to a group config YAML file. Can
              specify multiple.

optional arguments:
  -h, --help  show this help message and exit
```


## hubward_upload

### Tool Description
Creates a track hub and uploads to configured host. Track hub files include hub.txt, genomes.txt, and trackDb.txt files. If --hub-only has been specified, only these files will be uploaded to the host configured in the group config file. Otherwise, these files and all of the configured data files (bigBed, bigWig, BAM, and VCF files) from individual studies are uploaded via rsync to their respective configured locations on the remote host.

### Metadata
- **Docker Image**: quay.io/biocontainers/hubward:0.2.2--py27_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: hubward upload [-h] [--hub-only] [--rsync_options RSYNC_OPTIONS]
                      [--host HOST] [--user USER] [--hub_remote HUB_REMOTE]
                      filename

    Creates a track hub and uploads to configured host.

    Track hub files include hub.txt, genomes.txt, and trackDb.txt files. If
    --hub-only has been specified, only these files will be uploaded to the
    host configured in the group config file.

    Otherwise, these files and all of the configured data files (bigBed,
    bigWig, BAM, and VCF files) from individual studies are uploaded via rsync
    to their respective configured locations on the remote host.
    

positional arguments:
  filename              Group config file

optional arguments:
  -h, --help            show this help message and exit
  --hub-only            Just update the hub text files, not data files
                        (default: False)
  --rsync_options RSYNC_OPTIONS
                        Options for rsync. Default is "'-avrL --progress'"
  --host HOST           Host to upload to. Overrides [server][host] in the
                        group config file. (default: -)
  --user USER           User for host. Overrides [server][user] in the group
                        config file. (default: -)
  --hub_remote HUB_REMOTE
                        Remote filename for the top-level hub file. Overrides
                        [server][hub_remote] in the config file. (default: -)
```


## hubward_liftover

### Tool Description
Lift over coordinates from one assembly to another, in bulk. For all configured tracks in <dirname>/metadata.yaml, if the configured track genome matches <from_assembly> then perform the liftover to a temporary directory and then move the result to <newdir> when complete.

### Metadata
- **Docker Image**: quay.io/biocontainers/hubward:0.2.2--py27_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: hubward liftover [-h] [--from_assembly FROM_ASSEMBLY]
                        [--to_assembly TO_ASSEMBLY]
                        dirname newdir

    Lift over coordinates from one assembly to another, in bulk.

    For all configured tracks in <dirname>/metadata.yaml, if the configured
    track genome matches <from_assembly> then perform the liftover to
    a temporary directory and then move the result to <newdir> when complete.

    Currently, only studies where all tracks are in the same assembly are
    supported. If a track is found that is from a different assembly,
    a ValueError is raised.

    The genome field of each track is also edited to reflect the new genome,
    and a symlink called ORIGINAL-STUDY is placed in <newdir>. In the end,
    a complete version of <dirname> is available in <newdir> with appropriate
    tracks lifted over to the new assembly and appropriate metadata edited to
    reflect the liftover.

    Note: this uses CrossMap (http://crossmap.sourceforge.net) which currently
    only runs in Python 2.7.
    

positional arguments:
  dirname               Single study to liftover
  newdir                Destination directory

optional arguments:
  -h, --help            show this help message and exit
  --from_assembly FROM_ASSEMBLY
                        Source assembly (default: -)
  --to_assembly TO_ASSEMBLY
                        Destination assembly (default: -)
```


## hubward_skeleton

### Tool Description
Populate <dirname> with template files that can be customized on a per-study basis. The skeleton is actually a working example.

### Metadata
- **Docker Image**: quay.io/biocontainers/hubward:0.2.2--py27_1
- **Homepage**: https://github.com/lh3/bwa
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: hubward skeleton [-h] [--use-metadata-builder] dirname

    Populate <dirname> with template files that can be customized on
    a per-study basis.

    The skeleton is actually a working example:

        hubward skeleton <dirname>
        hubward process <dirname>
        hubward upload <dirname>/example-group.yaml \
                --host <host> --user <user> \
                --hub_remote <remotepath>

    

positional arguments:
  dirname               Path to contain skeleton project

optional arguments:
  -h, --help            show this help message and exit
  --use-metadata-builder
                        Sets up a metadata-builder.py script instead of a
                        metadata.yaml config file. Useful for more complicated
                        studies (default: False)
```

