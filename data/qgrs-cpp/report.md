# qgrs-cpp CWL Generation Report

## qgrs-cpp_qgrs

### Tool Description
Finds and analyzes G-quadruplexes (QGRS) in a DNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/qgrs-cpp:1.0--h503566f_5
- **Homepage**: https://github.com/freezer333/qgrs-cpp
- **Package**: https://anaconda.org/channels/bioconda/packages/qgrs-cpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qgrs-cpp/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/freezer333/qgrs-cpp
- **Stars**: N/A
### Original Help Text
```text
-----------------------------------------------------------------------------------------------------------
 Command line options
-----------------------------------------------------------------------------------------------------------
-h                    help (this)
-csv                  output in csv mode
-json                 output in JSON mode
-i [input filename]   read input from a file as specified (defaults to stdin)
-o [output filename]  write output to file as specified (defaults to stdout)
-t [n]                filter output to QGRS with number tetrads equal to or greater than n (defaults to 2)
-s [n]                filter output to QGRS with g-score equal to or greater than n (defaults to 17)
-g [c]                replace all G characters within tetrads with given character.
-v                    include overlapping QGRS in output (very large outputs may be generated)
-notitle              omit column titles in output (does not apply to JSON)

-----------------------------------------------------------------------------------------------------------
 Output (default or csv)
-----------------------------------------------------------------------------------------------------------
Column 1 - ID (order found in sequence).  x.y where x is the primary id, and y is number assigned overlaps.  
           For example, all QGRS listed as 2.y overlap QGRS listed with ID 2 - where 2 is the QGRS resulting
           in the highest G-Score in the group.
Column 2 - Position of the start of the first tetrad (relative to beginning of input sequence)
Column 3 - Position of the start of the second tetrad (relative to beginning of input sequence)
Column 4 - Position of the start of the third tetrad (relative to beginning of input sequence)
Column 5 - Position of the start of the fourth tetrad (relative to beginning of input sequence)
Column 6 - Number of tetrads
Column 7 - G-Score
Column 8 - Sequence

-----------------------------------------------------------------------------------------------------------
 Manual sequence entry)
-----------------------------------------------------------------------------------------------------------
When you run this program without the -i option, the sequence must be entered via stdin.  Unless you are piping 
in file contents, you will need to actually copy/paste or type the sequence data.  The program expects an EOF
signal at the end of the sequence - which will signal that it has received all input.  On the keyboard, type 
Ctrl+D to enter the EOF signal!
-----------------------------------------------------------------------------------------------------------
```

