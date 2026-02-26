# rename CWL Generation Report

## rename

### Tool Description
Rename files according to a pattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/rename:1.601--0
- **Homepage**: http://plasmasturm.org/code/rename
- **Package**: https://anaconda.org/channels/bioconda/packages/rename/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rename/overview
- **Total Downloads**: 26.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
    rename [switches|transforms] [files]

    Switches:

    --man (read the full manual)
    -0/--null (when reading from STDIN)
    -f/--force or -i/--interactive (proceed or prompt when overwriting)
    -g/--glob (expand "*" etc. in filenames, useful in Windows\x{2122} CMD.EXE)
    -k/--backwards/--reverse-order
    -l/--symlink or -L/--hardlink
    -M/--use=Module
    -n/--just-print/--dry-run
    -N/--counter-format
    -p/--mkpath/--make-dirs
    --stdin/--no-stdin
    -t/--sort-time
    -T/--transcode=encoding
    -v/--verbose

    Transforms, applied sequentially:

    -a/--append=str
    -A/--prepend=str
    -c/--lower-case
    -C/--upper-case
    -d/--delete=str
    -D/--delete-all=str
    -e/--expr=code
    -P/--pipe=cmd
    -s/--subst from to
    -S/--subst-all from to
    -x/--remove-extension
    -X/--keep-extension
    -z/--sanitize
    --camelcase --urlesc --nows --rews --noctrl --nometa --trim (see manual)
```

