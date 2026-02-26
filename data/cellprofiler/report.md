# cellprofiler CWL Generation Report

## cellprofiler

### Tool Description
Run CellProfiler in headless mode or with a GUI.

### Metadata
- **Docker Image**: quay.io/biocontainers/cellprofiler:4.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/CellProfiler/CellProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/cellprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellprofiler/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CellProfiler/CellProfiler
- **Stars**: N/A
### Original Help Text
```text
Usage: cellprofiler [options] [<output-file>])
         where <output-file> is the optional filename for the output file of
               measurements when running headless.
         The flags -p, -r and -c are required for a headless run.

Options:
  -h, --help            show this help message and exit
  -p PIPELINE_FILENAME, --pipeline=PIPELINE_FILENAME, --project=PIPELINE_FILENAME
                        Load this pipeline file or project on startup. If
                        specifying a pipeline file rather than a project, the
                        -i flag is also needed unless the pipeline is saved
                        with the file list.
  -c, --run-headless    Run headless (without the GUI)
  -r, --run             Run the given pipeline on startup
  -o OUTPUT_DIRECTORY, --output-directory=OUTPUT_DIRECTORY
                        Make this directory the default output folder
  -i IMAGE_DIRECTORY, --image-directory=IMAGE_DIRECTORY
                        Make this directory the default input folder
  -f FIRST_IMAGE_SET, --first-image-set=FIRST_IMAGE_SET
                        The one-based index of the first image set to process
  -l LAST_IMAGE_SET, --last-image-set=LAST_IMAGE_SET
                        The one-based index of the last image set to process
  -g GROUPS, --group=GROUPS
                        Restrict processing to one grouping in a grouped
                        pipeline. For instance, "-g ROW=H,COL=01", will
                        process only the group of image sets that match the
                        keys.
  --plugins-directory=PLUGINS_DIRECTORY
                        CellProfiler will look for plugin modules in this
                        directory (headless-only).
  --conserve-memory=CONSERVE_MEMORY
                        CellProfiler will attempt to release unused memory
                        after each image set.
  --version             Print the version and exit
  -t TEMP_DIR, --temporary-directory=TEMP_DIR
                        Temporary directory. CellProfiler uses this for
                        downloaded image files and for the measurements file,
                        if not specified. The default is /tmp
  -d DONE_FILE, --done-file=DONE_FILE
                        The path to the "Done" file, written by CellProfiler
                        shortly before exiting
  --measurements        Open the pipeline file specified by the -p switch and
                        print the measurements made by that pipeline
  --print-groups=PRINT_GROUPS_FILE
                        Open the measurements file following the --print-
                        groups switch and print the groups in its image sets.
                        The measurements file should be generated using
                        CreateBatchFiles. The output is a JSON-encoded data
                        structure containing the group keys and values and the
                        image sets in each group.
  --get-batch-commands=BATCH_COMMANDS_FILE
                        Open the measurements file following the --get-batch-
                        commands switch and print one line to the console per
                        group. The measurements file should be generated using
                        CreateBatchFiles and the image sets should be grouped
                        into the units to be run. Each line is a command to
                        invoke CellProfiler. You can use this option to
                        generate a shell script that will invoke CellProfiler
                        on a cluster by substituting "CellProfiler" with your
                        invocation command in the script's text, for instance:
                        CellProfiler --get-batch-commands Batch_data.h5 | sed
                        s/CellProfiler/farm_jobs.sh. Note that CellProfiler
                        will always run in headless mode when --get-batch-
                        commands is present and will exit after generating the
                        batch commands without processing any pipeline. Note
                        that this exact version is deprecated and will be
                        removed in CellProfiler 5; you may use the new version
                        now with --get-batch-commands-new
  --get-batch-commands-new=NEW_BATCH_COMMANDS_FILE
                        Open the batch file following the --get-batch-
                        commands-new switch and print one line to the console
                        per group. Each line is a command to invoke
                        CellProfiler. You can use this option to generate a
                        shell script that will invoke CellProfiler on a
                        cluster by substituting "CellProfiler". This new
                        version (which will be the only version in
                        CellProfiler 5) will return groups if CellProfiler has
                        more than one group and --images-per-batch is NOT
                        passed (or is passed as 1), otherwise it will always
                        return -f and -l commands. with your invocation
                        command in the script's text, for instance:
                        CellProfiler --get-batch-commands-new Batch_data.h5 |
                        sed s/CellProfiler/farm_jobs.sh. Note that
                        CellProfiler will always run in headless mode when
                        --get-batch-commands is present and will exit after
                        generating the batch commands without processing any
                        pipeline.
  --images-per-batch=IMAGES_PER_BATCH
                        For pipelines that do not use image grouping this
                        option specifies the number of images that should be
                        processed in each batch if --get-batch-commands is
                        used. Defaults to 1.
  --data-file=DATA_FILE
                        Specify the location of a .csv file for LoadData. If
                        this switch is present, this file is used instead of
                        the one specified in the LoadData module.
  --file-list=IMAGE_SET_FILE
                        Specify a file list of one file or URL per line to be
                        used to initially populate the Images module's file
                        list.
  --do-not-write-schema
                        Do not execute the schema definition and other per-
                        experiment SQL commands during initialization when
                        running a pipeline in batch mode.
  --write-schema-and-exit
                        Create the experiment database schema and exit
  --omero-credentials=OMERO_CREDENTIALS
                        Enter login credentials for OMERO. The credentials are
                        entered as comma-separated key/value pairs with keys,
                        "host" - the DNS host name for the OMERO server,
                        "port" - the server's port # (typically 4064), "user"
                        - the name of the connecting user, "password" - the
                        connecting user's password, "session-id" - the session
                        ID for an OMERO client session., "config-file" - the
                        path to the OMERO credentials config file. A typical
                        set of credentials might be: --omero-credentials
                        host=demo.openmicroscopy.org,port=4064,session-
                        id=atrvomvjcjfe7t01e8eu59amixmqqkfp
  -L LOG_LEVEL, --log-level=LOG_LEVEL
                        Set the verbosity for logging messages: 10 or DEBUG
                        for debugging, 20 or INFO for informational, 30 or
                        WARNING for warning, 40 or ERROR for error, 50 or
                        CRITICAL for critical, 50 or FATAL for fatal.
                        Otherwise, the argument is interpreted as the file
                        name of a log configuration file (see
                        http://docs.python.org/library/logging.config.html for
                        file format)
  --always-continue     Keep running after an image set throws an error
  --widget-inspector    Enable the widget inspector menu item under "Test"
```


## Metadata
- **Skill**: generated
