# saccharis CWL Generation Report

## saccharis

### Tool Description
SACCHARIS 2 is a tool to analyze CAZyme families.

### Metadata
- **Docker Image**: quay.io/biocontainers/saccharis:2.0.5--pyh7e72e81_0
- **Homepage**: https://github.com/saccharis/SACCHARIS_2
- **Package**: https://anaconda.org/channels/bioconda/packages/saccharis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/saccharis/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/saccharis/SACCHARIS_2
- **Stars**: N/A
### Original Help Text
```text
usage: saccharis [-h] [--version] [--directory DIRECTORY]
                 (--family FAMILY | --family_file FAMILY_FILE | --family_category FAMILY_CATEGORY | --explore)
                 [--subfamily SUBFAMILY]
                 [--cazyme_mode {characterized,structure,all_cazymes}]
                 [--domain {archaea,bacteria,eukaryota,viruses,unclassified,all} [{archaea,bacteria,eukaryota,viruses,unclassified,all} ...]]
                 [--seqfile SEQFILE [SEQFILE ...]] [--rename_user] [--fresh]
                 [--verbose] [--skip_prune] [--fragments]
                 [--threads {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}]
                 [--tree {fasttree,raxml,raxml_ng}] [--skip_user_ask]
                 [--render]

SACCHARIS version: 2.0.1.dev22 SACCHARIS 2 is a tool to analyze CAZyme
families.

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --directory DIRECTORY, -o DIRECTORY
                        You can set a predefined output directory with this
                        flag, either a full path or a subfolder of the CWD.
                        Default is <Current Working Directory (CWD)>/output.
                        If you specify an absolute file path the end directory
                        will be used. If you specify a relative file path(e.g.
                        just a folder name), it will be a subdirectory of the
                        CWD.
  --family FAMILY, -f FAMILY
                        This is a single family name. -> eg. "GH43". Cannot
                        use with --family_file, --family_category, or explore
  --family_file FAMILY_FILE
                        This is a file containing a list of families you would
                        like to run the pipeline on sequentially. Cannot use
                        with --family/-f, --family_category, or explore.
  --family_category FAMILY_CATEGORY
                        This accepts the name of a list of families contained
                        in the "family_categories.json" config file. Custom
                        groupings can be added to this file by the user via
                        text editor, provided that you follow the same
                        formatting. The formatting is standard json format as
                        used by the default python json encoder for a dict of
                        lists of strings. Cannot use with --family/-f,
                        --family_file, or explore.
  --explore, -x         This is a boolean flag which enables an exploratory
                        mode to screen the user sequence file for cayme
                        families and then ask the user which of the families
                        in their sequence file to run the pipeline on.Cannot
                        use with --family/-f, --family_category, or
                        --family_file.
  --subfamily SUBFAMILY
                        This is a subfamily number, which cazy represents as a
                        number appended to the family, e.g. "--family GH43
                        --subfamily 1" accesses the family which the CAZy
                        database identifies as GH43_1. Optional argument, can
                        only use with --family, not --family_file,
                        --family_category, or --explore.
  --cazyme_mode {characterized,structure,all_cazymes}, -c {characterized,structure,all_cazymes}
                        This is the characterization level of cazymes you wish
                        to query from the CAZy database. Allowable modes:
                        characterized structure all_cazymes
  --domain {archaea,bacteria,eukaryota,viruses,unclassified,all} [{archaea,bacteria,eukaryota,viruses,unclassified,all} ...], -d {archaea,bacteria,eukaryota,viruses,unclassified,all} [{archaea,bacteria,eukaryota,viruses,unclassified,all} ...]
                        This is the domain of the organisms whose cazymes you
                        wish to query from the CAZy database. Default mode is
                        all domains. Allowable modes: archaea bacteria
                        eukaryota viruses unclassified all You can specify as
                        many of these domain options as you wish by separating
                        them with a space. e.g. '-d archaea bacteria' is a
                        valid domain argument which will include cazyme
                        sequences from organisms in both the archaea and
                        bacteria domains.
  --seqfile SEQFILE [SEQFILE ...], -s SEQFILE [SEQFILE ...]
                        If you would like to add your own sequences to this
                        run - this is your chance. Sequences MUST be in FASTA
                        FORMAT - if they are not the script will fail. Make
                        sure to include path with filename. Multiple FASTA
                        files are supported and will be merged together, with
                        metadata of source files saved for future use.
  --rename_user, -u     This is a boolean value flag that by default is set to
                        False, which means the program will not automatically
                        rename user sequence headers to conform with the user
                        sequence ID format. When this argument is included,
                        this will occur automatically, without prompting. When
                        not included, the program will prompt the user if they
                        wish to prepend their FASTA headers with the correct
                        ID format.
  --fresh, -n           This is a boolean value flag that by default is set to
                        False, which means existing data will be reused to
                        speed up analysis. When included, this options forces
                        data to be redownloaded from CAZy and NCBI even if
                        present and all analyses to be performed again with
                        fresh data. Saved data from previous runs with the
                        same family, cazyme mode, and domain settings will be
                        deleted and overwritten.
  --verbose             This is a boolean value flag that by default is set to
                        False, which means verbose output is hidden. If you
                        would like verbose output (particularly useful to
                        explore when certain sequences from CAZy are not being
                        included in an analysis), include this flag in your
                        call.
  --skip_prune, -k      This is a boolean value flag that by default is set to
                        False, which means the sequences will be pruned to
                        CAZyme boundaries. If you wouldlike to skip the
                        pruning step and use full genbank entries for
                        alignment and tree building, include this flag in your
                        call.
  --fragments, -m       This is a boolean value flag that by default is set to
                        False, which means fragments are left out by default.
                        If you would like to include fragment sequences from
                        CAZY, include this flag in your call.
  --threads {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, -t {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
                        Some tools(e.g. RAxML) allow the use of multi-core
                        processing. Set a number in here from 1 to
                        <max_cores>. The default is set at 3/4 of the number
                        of logical cores reported by your operating system.
                        This is to prevent lockups if other programs are
                        running.
  --tree {fasttree,raxml,raxml_ng}, -e {fasttree,raxml,raxml_ng}
                        Choice of tree building program. FastTree is the
                        default because it is substantially faster than RAxML.
                        RAxML may take days or even weeks to build large
                        trees, but sometimes builds slightly higher quality
                        trees than FastTree. Both RAxML and RAxML-NG are
                        supported.
  --skip_user_ask       This is a boolean flag that by default is set to False
                        which when true skips querying the user for input. If
                        a question would be posed to the user, the question
                        will be skipped and a reasonable default action will
                        occur if possible or the program will exit if
                        necessary. An example is that normally when no NCBI
                        API key is detected the program prompts the user for
                        their NCBI API key. If this setting is true, the
                        program instead continues without an API key, slowing
                        down queries but otherwise functioning. It is
                        recommended to use this option when running SACCHARIS
                        on a cluster or in automated fashion to prevent failed
                        runs in environments where querying the user is not
                        possible.
  --render, -r          This is a boolean flag that by default is set to False
                        which when true automatically tries to render
                        phylogenetic trees using the rsaccharis R library. The
                        rsaccharis package must be installed and the rscript
                        command available on the PATH variable for this
                        function to work, see
                        https://github.com/saccharis/rsaccharis for details.

The following list is of additional utilities and commands available to
interact with saccharis. Most commands (not saccharis-gui) have their own help
menu, similarly accessed via "<command_name> -h" or "<command_name> --help",
e.g. "saccharis.make_family_files -h"
COMMAND LIST:
- saccharis.make_family_files
- saccharis.add_family_category
- saccharis.rename_user_file
- saccharis.prune_seqs
- saccharis.screen_cazome
- saccharis.show_family_categories
- saccharis.config
- saccharis.update_db
- saccharis-gui
```


## Metadata
- **Skill**: generated

## saccharis_saccharis-gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/saccharis:2.0.5--pyh7e72e81_0
- **Homepage**: https://github.com/saccharis/SACCHARIS_2
- **Package**: https://anaconda.org/channels/bioconda/packages/saccharis/overview
- **Validation**: FAIL (generation failed)
### Generation Failed

No inputs — do not generate CWL.

### Validation Errors
- No inputs — do not generate CWL.

### Original Help Text
```text
JSON decode error encountered trying to load package settings from /usr/local/lib/python3.11/site-packages/saccharis/data/config.json, using defaults instead.
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/saccharis/utils/AdvancedConfig.py", line 60, in get_package_settings
    current_package_settings = load_from_file(config_path)
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/saccharis/utils/AdvancedConfig.py", line 42, in load_from_file
    settings = json.loads(sfile.read())
               ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
qt.qpa.xcb: could not connect to display 
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, minimal, minimalegl, offscreen, vnc, webgl, xcb.
```

