# sqlite CWL Generation Report

## sqlite

### Tool Description
FILENAME is the name of an SQLite database. A new database is created if the file does not previously exist.

### Metadata
- **Docker Image**: quay.io/biocontainers/sqlite:3.33.0
- **Homepage**: https://github.com/sqlitebrowser/sqlitebrowser
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: /usr/local/bin/sqlite3 [OPTIONS] FILENAME [SQL]
FILENAME is the name of an SQLite database. A new database is created
if the file does not previously exist.
OPTIONS include:
   -A ARGS...           run ".archive ARGS" and exit
   -append              append the database to the end of the file
   -ascii               set output mode to 'ascii'
   -bail                stop after hitting an error
   -batch               force batch I/O
   -box                 set output mode to 'box'
   -column              set output mode to 'column'
   -cmd COMMAND         run "COMMAND" before reading stdin
   -csv                 set output mode to 'csv'
   -echo                print commands before execution
   -init FILENAME       read/process named file
   -[no]header          turn headers on or off
   -help                show this message
   -html                set output mode to HTML
   -interactive         force interactive I/O
   -json                set output mode to 'json'
   -line                set output mode to 'line'
   -list                set output mode to 'list'
   -lookaside SIZE N    use N entries of SZ bytes for lookaside memory
   -markdown            set output mode to 'markdown'
   -memtrace            trace all memory allocations and deallocations
   -mmap N              default mmap size set to N
   -newline SEP         set output row separator. Default: '\n'
   -nofollow            refuse to open symbolic links to database files
   -nullvalue TEXT      set text string for NULL values. Default ''
   -pagecache SIZE N    use N slots of SZ bytes each for page cache memory
   -quote               set output mode to 'quote'
   -readonly            open the database read-only
   -separator SEP       set output column separator. Default: '|'
   -stats               print memory stats before each finalize
   -table               set output mode to 'table'
   -version             show SQLite version
   -vfs NAME            use NAME as the default VFS
   -zip                 open the file as a ZIP Archive
```
## Metadata
- **Skill**: generated

## sqlite_sqlitebrowser

### Tool Description
The provided text appears to be a log of a failed container build or image fetch operation rather than command-line help text. As a result, no specific tool arguments or options could be extracted from the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/sqlite:3.33.0
- **Homepage**: https://github.com/sqlitebrowser/sqlitebrowser
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/sqlite:3.33.0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

