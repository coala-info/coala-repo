# ensembl-vep CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ensembl-vep_filter_vep | PASS |  |
| ensembl-vep_haplo | PASS |  |
| ensembl-vep_variant_recoder | PASS |  |
| ensembl-vep_vep | PASS |  |
| ensembl-vep_vep_convert_cache | PASS |  |

## ensembl-vep_vep

### Tool Description
ENSEMBL VARIANT EFFECT PREDICTOR

### Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: https://www.ensembl.org/info/docs/tools/vep/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

### Original Help Text
```text
#----------------------------------#
# ENSEMBL VARIANT EFFECT PREDICTOR #
#----------------------------------#

Versions:
  ensembl              : 115.266b84d
  ensembl-compara      : 115.ae48a7a
  ensembl-funcgen      : 115.57f7061
  ensembl-io           : 115.25061d3
  ensembl-variation    : 115.b7c2637
  ensembl-vep          : 115.2

Help: dev@ensembl.org , helpdesk@ensembl.org
Twitter: @ensembl

http://www.ensembl.org/info/docs/tools/vep/script/index.html

Usage:
./vep [--cache|--offline|--database] [arguments]

Basic options
=============

--help                 Display this message and quit

-i | --input_file      Input file
-o | --output_file     Output file
--force_overwrite      Force overwriting of output file
--species [species]    Species to use [default: "human"]

--everything           Shortcut switch to turn on commonly used options. See web
                       documentation for details [default: off]
--fork [num_forks]     Use forking to improve script runtime

For full option documentation see:
http://www.ensembl.org/info/docs/tools/vep/script/vep_options.html
```

## ensembl-vep_filter_vep

### Tool Description
Filter the results of VEP on fields such as Consequence, SIFT, PolyPhen or allele frequency.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: https://www.ensembl.org/info/docs/tools/vep/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

### Original Help Text
```text
#------------#
# filter_vep #
#------------#

http://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html

Usage:
./filter_vep [arguments]
  
--help               -h   Print usage message and exit

--input_file [file]  -i   Specify the input file (i.e. the VEP results file).
                          If no input file is specified, the script will
                          attempt to read from STDIN. Input may be gzipped - to
                          force the script to read a file as gzipped, use --gz
--format [vcf|tab]        Specify input file format (tab for any tab-delimited
                          format, including default VEP output format)

--output_file [file] -o   Specify the output file to write to. If no output file
                          is specified, the script will write to STDOUT
--force_overwrite         Force the script to overwrite the output file if it
                          already exists

--filter [filters]   -f   Add filter. Multiple --filter flags may be used, and
                          are treated as logical ANDs, i.e. all filters must
                          pass for a line to be printed

--list               -l   List allowed fields from the input file
--count              -c   Print only a count of matched lines

--only_matched            In VCF files, the CSQ field that contains the
                          consequence data will often contain more than one
                          "block" of consequence data, where each block
                          corresponds to a variant/feature overlap. Using
                          --only_matched will remove blocks that do not pass the
                          filters. By default, the script prints out the entire
                          VCF line if any of the blocks pass the filters.

--vcf_info_field [key]    With VCF input files, by default filter_vep expects to
                          find VEP annotations encoded in the CSQ INFO key; VEP
                          itself can be configured to write to a different key
                          (with the equivalent --vcf_info_field flag). Use this
                          flag to change the INFO key VEP expects to decode.
                          
--ontology           -y   Use Sequence Ontology to match consequence terms. Use
                          with operator "is" to match against all child terms of
                          your value.
                          e.g. "Consequence is coding_sequence_variant" will
                          match missense_variant, synonymous_variant etc.
                          Requires database connection; defaults to connecting
                          to ensembldb.ensembl.org. Use --host, --port, --user,
                          --password, --version as per ./vep to change
                          connection parameters.
```

## ensembl-vep_haplo

### Tool Description
HAPLOSAURUS: predict haplotypes of protein-coding transcripts from phased genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: https://www.ensembl.org/info/docs/tools/vep/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

### Original Help Text
```text
#-------------#
# HAPLOSAURUS #
#-------------#

Versions:
  ensembl              : 115.266b84d
  ensembl-compara      : 115.ae48a7a
  ensembl-funcgen      : 115.57f7061
  ensembl-io           : 115.25061d3
  ensembl-variation    : 115.b7c2637
  ensembl-vep          : 115.2

Help: dev@ensembl.org , helpdesk@ensembl.org
Twitter: @ensembl

Usage:
perl haplo.pl [--cache|--offline|--database] [arguments]

Basic options
=============

--help                 Display this message and quit

-i | --input_file      Input file
-o | --output_file     Output file
--force_overwrite      Force overwriting of output file
--species [species]    Species to use [default: "human"]
```

## ensembl-vep_variant_recoder

### Tool Description
Translate between variant identifiers and notations using the Ensembl database.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: https://www.ensembl.org/info/docs/tools/vep/recoder/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

### Original Help Text
```text
#-----------------#
# VARIANT RECODER #
#-----------------#

Versions:
  ensembl              : 115.266b84d
  ensembl-compara      : 115.ae48a7a
  ensembl-funcgen      : 115.57f7061
  ensembl-io           : 115.25061d3
  ensembl-variation    : 115.b7c2637
  ensembl-vep          : 115.2

Help: dev@ensembl.org , helpdesk@ensembl.org

Example usage:
./variant_recoder --input_data "rs699"

Basic options
=============

--help                 Display this message and quit

--input_data | --id    Input as string
--input_file | -i      Input file
--species [species]    Species to use [default: "human"]
--pretty               Print prettified JSON


For full option documentation see:
https://www.ensembl.org/info/docs/tools/vep/recoder/index.html#vr_options
```

## ensembl-vep_vep_convert_cache

### Tool Description
Convert a VEP cache from the older text format to the Sereal / tabix-indexed format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: http://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html#convert
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

### Original Help Text
```text
#---------------#
# convert_cache.pl #
#---------------#

http://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html#convert

Usage:
perl convert_cache.pl [arguments]
  
--help               -h   Print usage message and exit
--quiet              -q   Shhh!
--force_overwrite    -f   Overwrite existing cache files if found
--remove             -r   Remove old cache files after conversion

--dir [dir]          -d   Cache directory (default: $HOME/.vep)
--species [species]  -s   Species cache to convert ("all" to do all found)
--version [version]  -v   Cache version to convert ("all" to do all found)

--compress [cmd]     -c   Path to binary/command to decompress gzipped files.
                          Defaults to "gzip -dc", some systems may prefer "zcat"
--bgzip [cmd]        -b   Path to bgzip binary (default: bgzip)
--tabix [cmd]        -t   Path to tabix binary (default: tabix)
```

## Metadata
- **Docker Image**: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
- **Homepage**: https://www.ensembl.org/info/docs/tools/vep/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ensembl-vep/overview
- **Total Downloads**: 393.6K
- **Last updated**: 2025-09-26
- **GitHub**: https://github.com/Ensembl/ensembl-vep
- **Stars**: N/A
### Original Help Text
```text
#----------------------------------#
# ENSEMBL VARIANT EFFECT PREDICTOR #
#----------------------------------#

Versions:
  ensembl              : 115.266b84d
  ensembl-compara      : 115.ae48a7a
  ensembl-funcgen      : 115.57f7061
  ensembl-io           : 115.25061d3
  ensembl-variation    : 115.b7c2637
  ensembl-vep          : 115.2

Help: dev@ensembl.org , helpdesk@ensembl.org
Twitter: @ensembl

http://www.ensembl.org/info/docs/tools/vep/script/index.html

Usage:
./vep [--cache|--offline|--database] [arguments]

Basic options
=============

--help                 Display this message and quit

-i | --input_file      Input file
-o | --output_file     Output file
--force_overwrite      Force overwriting of output file
--species [species]    Species to use [default: "human"]

--everything           Shortcut switch to turn on commonly used options. See web
                       documentation for details [default: off]
--fork [num_forks]     Use forking to improve script runtime

For full option documentation see:
http://www.ensembl.org/info/docs/tools/vep/script/vep_options.html
```

