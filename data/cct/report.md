# cct CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cct_build_blast_atlas | Failed | image problem: it calls cgview_comparison_tool with the broken default global_settings.conf ($CCT_HOME/lib/scripts/... does not exist), so project creation fails. |
| cct_build_blast_atlas_all_vs_all | Failed | image problem: ImageMagick (convert, montage) is not installed in the image. |
| cct_cgview_comparison_tool | Failed | image problem: the default global_settings.conf points to $CCT_HOME/lib/scripts/..., which does not exist, so project creation fails; the run works only when a corrected config is passed with -g. |
| cct_convert_vcf_to_features | PASS |  |
| cct_create_zoomed_maps | Failed | image problem: the script runs $CCT_HOME/bin/cgview.jar, which does not exist in the image. |
| cct_fetch_all_refseq_bacterial_genomes | PASS |  |
| cct_fetch_all_refseq_chloroplast_genomes | Not completed | It downloads every RefSeq chloroplast genome from NCBI with no size filter, too large for a test run. |
| cct_fetch_all_refseq_mitochondrial_genomes | Not completed | It downloads every RefSeq mitochondrial genome from NCBI with no size filter, too large for a test run. |
| cct_fetch_genome_by_accession | Failed | image problem: the script calls $CCT_HOME/lib/scripts/ncbi_search/ncbi_search.pl, which does not exist in the image. |
| cct_fetch_refseq_bacterial_genomes_by_name | Failed | image problem: the /usr/bin wrapper passes arguments unquoted, so a species name with a space breaks the call; a one-word genus name works. |
| cct_ncbi_search | Failed | image problem: the /usr/bin wrapper passes arguments unquoted, so a query with spaces is split and wrong records come back; single-term queries work. |
| cct_redraw_maps | Failed | image problem: the script runs $CCT_HOME/bin/cgview.jar, which does not exist in the image. |
| cct_remove_long_seqs | PASS |  |
| cct_remove_short_seqs | PASS |  |

## cct_fetch_genome_by_accession

### Tool Description
Downloads a GenBank record using the accession number.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   fetch_genome_by_accession.sh -a STRING -o DIR 

DESCRIPTION:
   Downloads a GenBank record using the accession number.

REQUIRED ARGUMENTS:
   -a, --accession STRING
      Accession number of the sequence to download.
   -o, --output DIR
      The output directory to download the GenBank file into.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message.

EXAMPLE:
   fetch_genome_by_accession.sh -a NC_007719 -o my_project/reference_genome
```

## cct_fetch_all_refseq_chloroplast_genomes

### Tool Description
Downloads all chloroplast RefSeq sequences form NCBI in GenBank format.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   fetch_all_refseq_chloroplast_genomes.sh -o DIR 

DESCRIPTION:
   Downloads all chloroplast RefSeq sequences form NCBI in GenBank format.

REQUIRED ARGUMENTS:
   -o, --output DIR
      The output directory to contain the downloaded GenBank files.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message.

EXAMPLE:
   fetch_all_refseq_chloroplast_genomes.sh -o my_project/comparison_genomes
```

## cct_ncbi_search

### Tool Description
Uses NCBI's eSearch to download collections of sequences.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   perl ncbi_search.pl -q STRING -o FILE -d STRING -r STRING [Options]

DESCRIPTION:
   Uses NCBI's eSearch to download collections of sequences.

REQUIRED ARGUMENTS:
   -q, --query [STRING]
      Raw query text.
   -o, --output [FILE]
      Output file to create. If the split option is given, this should be a
      directory, where the returned records will be written. If the directory
      does not exist it will be created. 
   -d, --database [STRING]
      Name of the NCBI database to search, such as 'nucleotide', 'protein',
      or 'gene'.
   -r, --return_type [STRING]
      The type of information requested. For sequences 'fasta' is often used.
      The accepted formats vary depending on the database being queried.
   -s, --split
      Return each record as a separate file where the file name will will be
      the accesssion id of the record. This option only works if the
      return_type is 'gb' or 'gbwithparts'.
   -m, --max_records [INTEGER]
      The maximum number of records to return (default is to return all matches
      satisfying the query).
   -v, --verbose
      Provide progress messages.
   -h, --help
      Show this message.

EXAMPLE:
   perl ncbi_search.pl -q 'dysphagia AND homo sapiens[ORGN]' \
     -o results.txt -d pubmed -r uilist -m 100
```

## cct_fetch_all_refseq_mitochondrial_genomes

### Tool Description
Downloads all mitochondrial RefSeq sequences form NCBI in GenBank format.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   fetch_all_refseq_mitochondrial_genomes.sh -o DIR 

DESCRIPTION:
   Downloads all bacterial RefSeq sequences form NCBI in GenBank format.

REQUIRED ARGUMENTS:
   -o, --output DIR
      The output directory to contain the downloaded GenBank files.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message.

EXAMPLE:
   fetch_all_refseq_mitochondrial_genomes.sh -o my_project/comparison_genomes
```

## cct_redraw_maps

### Tool Description
Used to redraw the maps after editing the CGView XML file or to change the output image formats.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   redraw_maps.sh -p DIR [Options]

DESCRIPTION:
   Used to redraw the maps. This can be used after editing the CGView XML file
   or to change the output image formats.

REQUIRED ARGUMENTS:
   -p, --project DIR
      Path to a completed CCT project.

OPTIONAL ARGUMENTS:
   -f, --format STRING
      Image format for output map. Options are png, jpg, svg, svgz. 
      (Default: png)
   -m, --memory STRING
      Memory value for Java's -Xmx option (Default: 1500m).
   -h, --help
      Show this message

EXAMPLE:
   redraw_maps.sh -p my_project -f svg   
```

## cct_convert_vcf_to_features

### Tool Description
Converts a VCF (Variant Call Format) file into a feature file (GFF) for the CGView Comparison Tool.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text

USAGE:
   perl convert_vcf_to_features.pl -i INFILE -o OUTFILE

DESCRIPTION:
   This script converts a VCF (Variant Call Format) file into a feature file
   (GFF). The resulting GFF file can be used by the CGview Comparison tool.
   Simply place the GFF file in the 'features' directory of a CCT project. 

REQUIRED ARGUMENTS:
   -i, --input FILE
      Input VCF file (tab deliminated).
   -o, --output FILE
      Name to call the output file.

EXAMPLE: 
   perl convert_vcf_to_features.pl -i input.vcf -o output.gff
```

## cct_build_blast_atlas_all_vs_all

### Tool Description
Generates several CCT projects automatically and combines the results into a single montage map.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   build_blast_atlas_all_vs_all.sh -p DIR [Options]

DESCRIPTION:
   This script generates several CCT projects automatically, and then it
   combines the results into a single montage map. The montage consists
   of a separate map for each sequence of interest. This allows each sequence
   in a group of sequences to be visualized as the reference sequence.

   This command is used to first create a blast atlas all vs all project
   directory and then again to generate the montage. After the project has
   been created, place the genomes to compare in the comparison_genomes
   directory.

   [Optional] Make changes to the project_settings_multi.conf file to
   configure how the maps will be drawn. Add additional GFF files to the
   features and analysis directories.

   Draw maps by running this command again with the '-p' option pointing to the
   project directory.

REQUIRED ARGUMENTS:
   -p, --project DIR
      If no project exists yet, creates a new project directory. Otherwise,
      initiates map creation for the project.

OPTIONAL ARGUMENTS:
   -m, --memory STRING
      Memory value for Java's -Xmx option (Default: 1500m).
   -c, --custom STRING
      Custom settings for map creation.
   -b, --max_blast_comparisons INTEGER
      Maximum number of comparison genomes to display (Default: 100).
   -z, --map_size STRING
      Size of custom maps to create. For quickly regenerating new map sizes,
      use this option with the --start_at_xml option. Possible sizes include
      small/medium/large/x-large or a combination separated by commas (e.g.
      small,large). The size(s) provided will override the size(s) in the
      configuration files.
   -x, --start_at_xml
      Jump to XML generation. Skips performing blast, which can
      speed map generation if blast has already been done. This option is for
      creating new maps after making changes to the .conf files or if creating
      new map sizes (see --map_size). Note that any changes in the .conf files
      related to blast will be ignored. This option will be ignored if the
      --start_at_map or --start_at_montage option is also provided.  
   -r, --start_at_map
      Start at map generation. Skips performing blast and
      generating XML. Useful if manual changes to the XML files have 
      been made. This option will be ignored if the --start_at_montage
      option is also provided.
   -g, --start_at_montage
      Start at montage generation. Skips creating the individual maps.
      Useful if changing how many columns the montage should have.
   -y, --columns INTEGER
      The number of columns to use in the montage image (Default: 4). If the
      maps have already been drawn once, it is best to use this option with the
      --start_at_montage option.
   -h, --help
      Show this message.

NOTES:
   This script will likely not work if there are spaces in the path to the
   project directory because the NCBI tool 'formatdb' cannot handle such
   paths.
```

## cct_build_blast_atlas

### Tool Description
Creates a blast atlas project directory from a GenBank reference genome, and draws the maps when run again on the project.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   build_blast_atlas.sh -i FILE [-p DIR] [Options]
   build_blast_atlas.sh -p DIR [Options]

DESCRIPTION:
   This command is used to first create a blast atlas project directory and
   then again to generate maps.  Run this command with the '-i' option and a
   GenBank file to create a new project using the GenBank file as the reference
   genome. Alternatively, a blank project can be created using the '-p'
   option, in which case a reference GenBank file will have to be placed in the
   reference_genomes directory. After the project has been created, place the
   genomes to compare with the reference in the comparison_genomes directory.

   [Optional] Make changes to the *.conf files to configure how the maps will
   be drawn. Add additional GFF files to the features and analysis directories.

   Draw maps by running this command again with the '-p' option pointing to the
   project directory.

REQUIRED ARGUMENTS:
   -i, --input FILE
      Sequence file in GenBank format, with a .gbk extension. This option is
      only required when first creating a blast atlas project. The project
      directory will be named after this file unless the '-p' option is
      provided.
   -p, --project DIR
      Initiates map creation for the project. If no project exists yet, a blank
      project will be created. When used with the '-i' option, this will be
      where the project is created. This option is only required when creating
      the blast atlas maps.

OPTIONAL ARGUMENTS:
   -m, --memory STRING
      Memory value for Java's -Xmx option (Default: 1500m).
   -c, --custom STRING
      Custom settings for map creation.
   -b, --max_blast_comparisons INTEGER
      Maximum number of comparison genomes to display (Default: 100).
   -z, --map_size STRING
      Size of custom maps to create. For quickly regenerating new map sizes,
      use this option with the --start_at_xml option. Possible sizes include
      small/medium/large/x-large or a combination separated by commas (e.g.
      small,large). The size(s) provided will override the size(s) in the
      configuration files.
   -x, --start_at_xml
      Jump to XML generation. Skips performing blast, which can speed map
      generation if blast has already been done. This option is for creating
      new maps after making changes to the .conf files.  Note that any changes
      in the .conf files related to blast will be ignored. This option will be
      ignored if the --start_at_map option is also provided.  
   -r, --start_at_map
      Start at map generation. Skips performing blast and
      generating XML. Useful if manual changes to the XML files have 
      been made or if creating new map sizes (see --map_size).
   -h, --help
      Show this message.

NOTE:
   This script will likely not work if there are spaces in the path to the
   project directory because the NCBI tool 'formatdb' cannot handle such
   paths.
```

## cct_create_zoomed_maps

### Tool Description
Creates a zoomed map for completed CCT project.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   create_zoomed_maps.sh -p DIR -c INTEGER -z INTEGER [Options]

DESCRIPTION:
   Creates a zoomed map for completed CCT project.

REQUIRED ARGUMENTS:
   -p, --project DIR
      Path to a completed CCT project.
   -c, --center INTEGER
      Nucleotide position to center the zoomed map on.
   -z, --zoom INTEGER
      Zoom multiplier.

OPTIONAL ARGUMENTS:
   -f, --format STRING
      Image format for output map. Options are png, jpg, svg, svgz. 
      (Default: png)
   -m, --memory STRING
      Memory value for Java's -Xmx option (Default: 1500m).
   -h, --help
      Show this message

EXAMPLE:
   create_zoomed_maps.sh -p my_project -c 10000 -z 10 -format svg   
```

## cct_fetch_all_refseq_bacterial_genomes

### Tool Description
Downloads all bacterial RefSeq sequences form NCBI in GenBank format.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   fetch_all_refseq_bacterial_genomes.sh -o DIR 

DESCRIPTION:
   Downloads all bacterial RefSeq sequences form NCBI in GenBank format.
   The --min and --max options can be used to restrict the size of the 
   returned sequences.

REQUIRED ARGUMENTS:
   -o, --output DIR
      The output directory to contain the downloaded GenBank files.

OPTIONAL ARGUMENTS:
   -m, --min INTEGER
      Records with a sequence length shorter than this value will be ignored.
   -x, --max INTEGER
      Records with a sequence length longer than this value will be ignored.
   -h, --help
      Show this message.

EXAMPLE:
   fetch_all_refseq_bacterial_genomes.sh -o my_project/comparison_genomes
```

## cct_fetch_refseq_bacterial_genomes_by_name

### Tool Description
Downloads GenBank records using a partial or complete bacterial species name.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   fetch_refseq_bacterial_genomes_by_name.sh -n STRING -o DIR 

DESCRIPTION:
   Downloads a GenBank record using a partial or complete bacterial species name.
   The --min and --max options can be used to restrict the size of the 
   returned sequences.

REQUIRED ARGUMENTS:
   -n, --name STRING
      Complete or partial name of the bacterial species.
   -m, --min INTEGER
      Records with a sequence length shorter than this value will be ignored.
   -x, --max INTEGER
      Records with a sequence length longer than this value will be ignored.
   -o, --output DIR
      The output directory to download the GenBank file into.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message.

EXAMPLE:
   fetch_refseq_bacterial_genomes_by_name.sh -n 'Escherichia*' -o my_project/comparison_genomes
```

## cct_cgview_comparison_tool

### Tool Description
Creates a CCT project directory, and draws BLAST comparison maps when run again on the filled project.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   cgview_comparison_tool.pl -p DIR [options]

DESCRIPTION:
   Run this command once to generate a project directory. After the project is
   created place a reference genome in the reference_genome directory and any
   genomes to compare with the reference in the comparison_genomes directory.

   [Optional] Make changes to the project_settings.conf file to configure how
   the maps will be drawn. Add additional GFF files to the features and
   analyis directories.

   Draw maps by running this command again with the '-p' option pointing to
   the project directory.

REQUIRED ARGUMENTS:
   -p, --project DIR
      If no project exists yet, a blank project directory will be created.
      If the project exists, maps will be created.

OPTIONAL ARGUMENTS:

   -s, --settings FILE
      The settings file. If none is provided, the default settings file will be
      copied from $CCT_HOME/conf/project_settings.conf to the project
      directory.
   -g, --config FILE
      The configuration file. The default is to use the
      $CCT_HOME/conf/global_settings.conf file.
   -z, --map_size STRING
      Size of custom maps to create. For quickly generating new map sizes, use
      this option with the --start_at_xml option. Possible sizes include
      small/medium/large/x-large or a combination separated by commas (e.g.
      small,large). The size(s) provided will override the size(s) in the
      configuration files.
   -x, --start_at_xml
      Jump to XML generation. Skips performing blast, which can
      speed map generation if blast has already been done. This option is for
      creating new maps after making changes to the .conf files. Note that
      any changes in the .conf files related to blast will be ignored.
   -r, --start_at_map
      Start at map generation. Skips performing blast and
      generating XML. Useful if manual changes to the XML files have 
      been made or if creating new map sizes (see --map_size).
   -f, --map_prefix STRING
      Prefix to be appended to map names (Default is to add no additional
      prefix).
   -b, --max_blast_comparisons INTEGER
      The maximum number of BLAST results sets to be passed to the XML
      creation phase (Default is 100).
   -t, --sort_blast_tracks
      Sort BLAST results such that genomes with highest similarity are plotted
      first.
   --cct
      Colour BLAST results based on percent identity of hit instead of by
      source genome, and ignore 'use_opacity' setting in configuration file.
   -m, --memory STRING
      Memory string to pass to Java's '-Xmx' option (Default is 1500m).
   -c, --custom STRINGS
      Settings used to customize the appearance of the map.
   -h, --help
      Show this message.

EXAMPLE: 
   perl cgview_comparison_tool.pl -p my_project -b 50 -t \
     --custom tickLength=20 labelFontSize=15 --map_size medium,x-large
```

## cct_remove_short_seqs

### Tool Description
Removes GenBank files that are shorter than the specified length from the provided directory.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
usage: remove_short_seqs.sh [[-i input] [-l length] | [-h]]
-i DIRECTORY the input directory of GenBank files with .gbk extensions
-l INTEGER remove GenBank files that describe sequences shorter than this length

USAGE:
   remove_short_seqs.sh -i DIR -l INTEGER

DESCRIPTION:
   Removes GenBank files that are shorter than the specified length from the
   provided directory.

REQUIRED ARGUMENTS:
   -i, --input DIR
      Input directory of GenBank files with .gbk extensions.
   -l, --length INTEGER
      Remove GenBank files that describe sequences shorter than this length.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message

EXAMPLE:
   remove_short_seqs.sh -i my_project/comparison_genomes -l 100000
```

## cct_remove_long_seqs

### Tool Description
Removes GenBank files that are longer than the specified length from the provided directory.

### Metadata
- **Docker Image**: biocontainers/cct:v20170919dfsg-1-deb_cv1
- **Homepage**: https://github.com/paulstothard/cgview_comparison_tool
- **Package**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/cct/overview
- **GitHub**: https://github.com/paulstothard/cgview_comparison_tool

### Original Help Text
```text
USAGE:
   remove_long_seqs.sh -i DIR -l INTEGER

DESCRIPTION:
   Removes GenBank files that are longer than the specified length from the
   provided directory.

REQUIRED ARGUMENTS:
   -i, --input DIR
      Input directory of GenBank files with .gbk extensions.
   -l, --length INTEGER
      Remove GenBank files that describe sequences longer than this length.

OPTIONAL ARGUMENTS:
   -h, --help
      Show this message

EXAMPLE:
   remove_long_seqs.sh -i my_project/comparison_genomes -l 100000
```

## Metadata
- **Skill**: generated
