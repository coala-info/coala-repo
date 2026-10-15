# poseidon-trident CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| poseidon-trident_fetch | Failed | image problem: no CA certificates in the image, so the HTTPS download fails with unknown CA |
| poseidon-trident_forge | PASS |  |
| poseidon-trident_genoconvert | PASS |  |
| poseidon-trident_init | PASS |  |
| poseidon-trident_jannocoalesce | PASS | default all-columns mode crashes when the source janno has columns missing in the target; --includeColumns works |
| poseidon-trident_list | PASS | local mode works; --remote fails with the same missing CA certificates; --raw still prints a header line |
| poseidon-trident_rectify | PASS |  |
| poseidon-trident_summarise | PASS |  |
| poseidon-trident_survey | PASS |  |
| poseidon-trident_validate | PASS |  |

## poseidon-trident_init

### Tool Description
Create a new Poseidon package from genotype data

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident init ((-p|--genoOne FILE) | --genoFile FILE --snpFile FILE
                      --indFile FILE |
                      --bedFile FILE --bimFile FILE --famFile FILE | 
                      --vcfFile FILE) [--snpSet SET] (-o|--outPackagePath DIR) 
                    [-n|--outPackageName STRING] [--minimal]

  Create a new Poseidon package from genotype data

Available options:
  -h,--help                Show this help text
  -p,--genoOne FILE        One of the input genotype data files. Expects .bed,
                           .bed.gz, .bim, .bim.gz or .fam for PLINK, .geno,
                           .geno.gz, .snp, .snp.gz or .ind for EIGENSTRAT,
                           or.vcf or .vcf.gz for VCF. In case of EIGENSTRAT and
                           PLINK, the two other files must be in the same
                           directory and must have the same base name. If a
                           gzipped file is given, it is assumed that the file
                           pairs (.geno.gz, .snp.gz) or (.bim.gz, .bed.gz) are
                           both zipped, but not the .fam or .ind file. If a .ind
                           or .fam file is given, it is assumed that none of the
                           file triples is zipped.
  --genoFile FILE          Eigenstrat genotype matrix, optionally gzipped.
                           Accepted file endings are .geno, .geno.gz
  --snpFile FILE           Eigenstrat snp positions file, optionally gzipped.
                           Accepted file endings are .snp, .snp.gz
  --indFile FILE           Eigenstrat individual file. Accepted file endings are
                           .ind
  --bedFile FILE           Plink genotype matrix, optionally gzipped. Accepted
                           file endings are .bed, .bed.gz
  --bimFile FILE           Plink snp positions file, optionally gzipped.
                           Accepted file endings are .bim, .bim.gz
  --famFile FILE           Plink individual file. Accepted file endings are .fam
  --vcfFile FILE           VCF (Variant Call Format) file, optionall gzipped.
                           Accepted file endings are .vcf, .vcf.gz
  --snpSet SET             The snpSet of the package: 1240K, HumanOrigins or
                           Other. Only relevant for data input with -p|--genoOne
                           or --genoFile + --snpFile + --indFile, because the
                           packages in a -d|--baseDir already have this
                           information in their respective POSEIDON.yml files.
                           (default: Other)
  -o,--outPackagePath DIR  Path to the output package directory.
  -n,--outPackageName STRING
                           The output package name. This is optional: If no name
                           is provided, then the package name defaults to the
                           basename of the (mandatory) --outPackagePath
                           argument. (default: Nothing)
  --minimal                Should the output Poseidon package be reduced to a
                           necessary minimum?
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_forge

### Tool Description
Select packages, groups or individuals and create a new Poseidon package from them

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident forge ((-d|--baseDir DIR) | 
                       ((-p|--genoOne FILE) | --genoFile FILE --snpFile FILE
                         --indFile FILE |
                         --bedFile FILE --bimFile FILE --famFile FILE | 
                         --vcfFile FILE) [--snpSet SET]) 
                     [--forgeFile FILE | (-f|--forgeString DSL)] 
                     [--selectSnps FILE] [--intersect] [--outFormat FORMAT] 
                     [--onlyGeno | --minimal | --preservePyml] [-z|--zip]
                     (-o|--outPackagePath DIR) [-n|--outPackageName STRING] 
                     [--packagewise] [--outPlinkPopName MODE] [--ordered]

  Select packages, groups or individuals and create a new Poseidon package from
  them

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -p,--genoOne FILE        One of the input genotype data files. Expects .bed,
                           .bed.gz, .bim, .bim.gz or .fam for PLINK, .geno,
                           .geno.gz, .snp, .snp.gz or .ind for EIGENSTRAT,
                           or.vcf or .vcf.gz for VCF. In case of EIGENSTRAT and
                           PLINK, the two other files must be in the same
                           directory and must have the same base name. If a
                           gzipped file is given, it is assumed that the file
                           pairs (.geno.gz, .snp.gz) or (.bim.gz, .bed.gz) are
                           both zipped, but not the .fam or .ind file. If a .ind
                           or .fam file is given, it is assumed that none of the
                           file triples is zipped.
  --genoFile FILE          Eigenstrat genotype matrix, optionally gzipped.
                           Accepted file endings are .geno, .geno.gz
  --snpFile FILE           Eigenstrat snp positions file, optionally gzipped.
                           Accepted file endings are .snp, .snp.gz
  --indFile FILE           Eigenstrat individual file. Accepted file endings are
                           .ind
  --bedFile FILE           Plink genotype matrix, optionally gzipped. Accepted
                           file endings are .bed, .bed.gz
  --bimFile FILE           Plink snp positions file, optionally gzipped.
                           Accepted file endings are .bim, .bim.gz
  --famFile FILE           Plink individual file. Accepted file endings are .fam
  --vcfFile FILE           VCF (Variant Call Format) file, optionall gzipped.
                           Accepted file endings are .vcf, .vcf.gz
  --snpSet SET             The snpSet of the package: 1240K, HumanOrigins or
                           Other. Only relevant for data input with -p|--genoOne
                           or --genoFile + --snpFile + --indFile, because the
                           packages in a -d|--baseDir already have this
                           information in their respective POSEIDON.yml files.
                           (default: Other)
  --forgeFile FILE         A file with a list of packages, groups or individual
                           samples. Works just as -f, but multiple values can
                           also be separated by newline, not just by comma.
                           Empty lines are ignored and comments start with "#",
                           so everything after "#" is ignored in one line.
                           Multiple instances of -f and --forgeFile can be
                           given. They will be evaluated according to their
                           input order on the command line.
  -f,--forgeString DSL     List of packages, groups or individual samples to be
                           combined in the output package. Packages follow the
                           syntax *package_title*, populations/groups are simply
                           group_id and individuals <individual_id>. You can
                           combine multiple values with comma, so for example:
                           "*package_1*, <individual_1>, <individual_2>,
                           group_1". Duplicates are treated as one entry.
                           Negative selection is possible by prepending "-" to
                           the entity you want to exclude (e.g. "*package_1*,
                           -<individual_1>, -group_1"). forge will apply
                           excludes and includes in order. If the first entity
                           is negative, then forge will assume you want to merge
                           all individuals in the packages found in the baseDirs
                           (except the ones explicitly excluded) before the
                           exclude entities are applied. An empty forgeString
                           (and no --forgeFile) will therefore merge all
                           available individuals. If there are individuals in
                           your input packages with equal individual id, but
                           different main group or source package, they can be
                           specified with the special syntax
                           "<package:group:individual>".
  --selectSnps FILE        To extract specific SNPs during this forge operation,
                           provide a Snp file. Can be either Eigenstrat (file
                           ending must be '.snp' or '.snp.gz') or Plink (file
                           ending must be '.bim' or '.bim.gz'). When this option
                           is set, the output package will have exactly the SNPs
                           listed in this file. Any SNP not listed in the file
                           will be excluded. If option '--intersect' is also
                           set, only the SNPs overlapping between the SNP file
                           and the forged packages are output.
                           (default: Nothing)
  --intersect              Whether to output the intersection of the genotype
                           files to be forged. The default (if this option is
                           not set) is to output the union of all SNPs, with
                           genotypes defined as missing in those packages which
                           do not have a SNP that is present in another package.
                           With this option set, the forged dataset will
                           typically have fewer SNPs, but less missingness.
  --outFormat FORMAT       The format of the output genotype data: EIGENSTRAT,
                           PLINK or VCF. (default: PLINK)
  --onlyGeno               Should only the resulting genotype data be returned?
                           This means the output will not be a Poseidon package.
  --minimal                Should the output Poseidon package be reduced to a
                           necessary minimum?
  --preservePyml           Should the output Poseidon package mimic the input
                           package? With this option some fields of the source
                           package's POSEIDON.yml file, its README file and its
                           CHANGELOG file (if available) are copied to the
                           output package. Only works for a singular source
                           package.
  -z,--zip                 Should the resulting genotype- and snp-files be
                           gzipped?
  -o,--outPackagePath DIR  Path to the output package directory.
  -n,--outPackageName STRING
                           The output package name. This is optional: If no name
                           is provided, then the package name defaults to the
                           basename of the (mandatory) --outPackagePath
                           argument. (default: Nothing)
  --packagewise            Skip the within-package selection step in forge. This
                           will result in outputting all individuals in the
                           relevant packages, and hence a superset of the
                           requested individuals/groups. It may result in better
                           performance in cases where one wants to forge entire
                           packages or almost entire packages. Details: Forge
                           conceptually performs two types of selection: First,
                           it identifies which packages in the supplied base
                           directories are relevant to the requested forge, i.e.
                           whether they are either explicitly listed using
                           *PackageName*, or because they contain selected
                           individuals or groups. Second, within each relevant
                           package, individuals which are not requested are
                           removed. This option skips only the second step, but
                           still performs the first.
  --outPlinkPopName MODE   Where to write the population/group name into the FAM
                           file in Plink-format. Three options are possible:
                           asFamily (default) | asPhenotype | asBoth. See also
                           --inPlinkPopName.
  --ordered                With this option, the output of forge is ordered
                           according to the entities given.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_genoconvert

### Tool Description
Convert the genotype data in a Poseidon package to a different file format

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident genoconvert ((-d|--baseDir DIR) | 
                             ((-p|--genoOne FILE) | --genoFile FILE
                               --snpFile FILE --indFile FILE |
                               --bedFile FILE --bimFile FILE --famFile FILE | 
                               --vcfFile FILE) [--snpSet SET])
                           --outFormat FORMAT [-o|--outPackagePath DIR] 
                           [--removeOld] [--outPlinkPopName MODE] [--onlyLatest]
                           [-z|--zip]

  Convert the genotype data in a Poseidon package to a different file format

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -p,--genoOne FILE        One of the input genotype data files. Expects .bed,
                           .bed.gz, .bim, .bim.gz or .fam for PLINK, .geno,
                           .geno.gz, .snp, .snp.gz or .ind for EIGENSTRAT,
                           or.vcf or .vcf.gz for VCF. In case of EIGENSTRAT and
                           PLINK, the two other files must be in the same
                           directory and must have the same base name. If a
                           gzipped file is given, it is assumed that the file
                           pairs (.geno.gz, .snp.gz) or (.bim.gz, .bed.gz) are
                           both zipped, but not the .fam or .ind file. If a .ind
                           or .fam file is given, it is assumed that none of the
                           file triples is zipped.
  --genoFile FILE          Eigenstrat genotype matrix, optionally gzipped.
                           Accepted file endings are .geno, .geno.gz
  --snpFile FILE           Eigenstrat snp positions file, optionally gzipped.
                           Accepted file endings are .snp, .snp.gz
  --indFile FILE           Eigenstrat individual file. Accepted file endings are
                           .ind
  --bedFile FILE           Plink genotype matrix, optionally gzipped. Accepted
                           file endings are .bed, .bed.gz
  --bimFile FILE           Plink snp positions file, optionally gzipped.
                           Accepted file endings are .bim, .bim.gz
  --famFile FILE           Plink individual file. Accepted file endings are .fam
  --vcfFile FILE           VCF (Variant Call Format) file, optionall gzipped.
                           Accepted file endings are .vcf, .vcf.gz
  --snpSet SET             The snpSet of the package: 1240K, HumanOrigins or
                           Other. Only relevant for data input with -p|--genoOne
                           or --genoFile + --snpFile + --indFile, because the
                           packages in a -d|--baseDir already have this
                           information in their respective POSEIDON.yml files.
                           (default: Other)
  --outFormat FORMAT       the format of the output genotype data: EIGENSTRAT,
                           PLINK or VCF.
  -o,--outPackagePath DIR  Path for the converted genotype files to be written
                           to. If a path is provided, only the converted
                           genotype files are written out, with no change of the
                           original package. If no path is provided, genotype
                           files will be converted in-place, including a change
                           in the POSEIDON.yml file to yield an updated valid
                           package (default: Nothing)
  --removeOld              Remove the old genotype files when creating the new
                           ones.
  --outPlinkPopName MODE   Where to write the population/group name into the FAM
                           file in Plink-format. Three options are possible:
                           asFamily (default) | asPhenotype | asBoth. See also
                           --inPlinkPopName.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.
  -z,--zip                 Should the resulting genotype- and snp-files be
                           gzipped?
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_jannocoalesce

### Tool Description
Coalesce information from one or multiple janno files to another one

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident jannocoalesce ((-s|--sourceFile FILE) | (-d|--baseDir DIR))
                             (-t|--targetFile FILE) [-o|--outFile FILE] 
                             [--includeColumns ARG | --excludeColumns ARG] 
                             [-f|--force] [--sourceKey ARG] [--targetKey ARG] 
                             [--stripIdRegex ARG]

  Coalesce information from one or multiple janno files to another one

Available options:
  -h,--help                Show this help text
  -s,--sourceFile FILE     The source .janno file.
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -t,--targetFile FILE     The target .janno file to fill.
  -o,--outFile FILE        An optional file to write the results to. If not
                           specified, change the target file in place.
                           (default: Nothing)
  --includeColumns ARG     A comma-separated list of .janno column names to
                           coalesce. If not specified, all columns that can be
                           found in the source and target will get filled.
  --excludeColumns ARG     A comma-separated list of .janno column names NOT to
                           coalesce. All columns that can be found in the source
                           and target will get filled, except the ones listed
                           here.
  -f,--force               With this option, potential non-missing content in
                           target columns gets overridden with non-missing
                           content in source columns. By default, only missing
                           data gets filled-in.
  --sourceKey ARG          The .janno column to use as the source key.
                           (default: "Poseidon_ID")
  --targetKey ARG          The .janno column to use as the target key.
                           (default: "Poseidon_ID")
  --stripIdRegex ARG       An optional regular expression to identify parts of
                           the IDs to strip before matching between source and
                           target. Uses POSIX Extended regular expressions.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_rectify

### Tool Description
Adjust POSEIDON.yml files automatically to package changes

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident rectify (-d|--baseDir DIR) [--ignorePoseidonVersion] 
                       [--poseidonVersion ?.?.?] 
                       [--packageVersion VPART [--logText STRING]] 
                       [--checksumAll | [--checksumGeno] [--checksumJanno] 
                         [--checksumSSF] [--checksumBib]] 
                       [--newContributors DSL] [--jannoRemoveEmpty] 
                       [--onlyLatest]

  Adjust POSEIDON.yml files automatically to package changes

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --ignorePoseidonVersion  Read packages even if their poseidonVersion is not
                           compatible with trident.
  --poseidonVersion ?.?.?  Poseidon version the packages should be updated to:
                           e.g. "2.5.3".
  --packageVersion VPART   Part of the package version number in the
                           POSEIDON.yml file that should be updated: Major,
                           Minor or Patch (see https://semver.org).
  --logText STRING         Log text for this version in the CHANGELOG file.
  --checksumAll            Update all checksums.
  --checksumGeno           Update genotype data checksums.
  --checksumJanno          Update .janno file checksum.
  --checksumSSF            Update .ssf file checksum
  --checksumBib            Update .bib file checksum.
  --newContributors DSL    Contributors to add to the POSEIDON.yml file in the
                           form "[Firstname Lastname](Email address);...".
  --jannoRemoveEmpty       Reorder the .janno file and remove empty colums.
                           Remember to pair this option with --checksumJanno to
                           also update the checksum.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_fetch

### Tool Description
Download data from a remote Poseidon repository

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident fetch (-d|--baseDir DIR) 
                     (--downloadAll | 
                       (--fetchFile FILE | (-f|--fetchString DSL))) 
                     [--remoteURL URL] [--archive STRING]

  Download data from a remote Poseidon repository

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --downloadAll            Download all packages the server is offering.
  --fetchFile FILE         A file with a list of packages. Works just as -f, but
                           multiple values can also be separated by newline, not
                           just by comma. -f and --fetchFile can be combined.
  -f,--fetchString DSL     List of packages to be downloaded from the remote
                           server. Package names should be wrapped in asterisks:
                           *package_title*. You can combine multiple values with
                           comma, so for example: "*package_1*, *package_2*,
                           *package_3*". fetchString uses the same parser as
                           forgeString, but does not allow excludes. If groups
                           or individuals are specified, then packages which
                           include these groups or individuals are included in
                           the download.
  --remoteURL URL          URL of the remote Poseidon server.
                           (default: "https://server.poseidon-adna.org")
  --archive STRING         The name of the Poseidon package archive that should
                           be queried. If not given, then the query falls back
                           to the default archive of the server selected with
                           --remoteURL. See the archive documentation at
                           https://www.poseidon-adna.org/#/archive_overview for
                           a list of archives currently available from the
                           official Poseidon Web API. (default: Nothing)
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_list

### Tool Description
List packages, groups or individuals from local or remote Poseidon repositories

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident list ((-d|--baseDir DIR) | --remote [--remoteURL URL] 
                      [--archive STRING]) 
                    (--packages [--fullOutput] | --groups | --individuals 
                      [--fullJanno | [-j|--jannoColumn COLNAME]] |
                      --bibliography [--fullBib | [-b|--bibField BIB-FIELD]]) 
                    [--raw] [--onlyLatest]

  List packages, groups or individuals from local or remote Poseidon
  repositories

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --remote                 List packages from a remote server instead the local
                           file system.
  --remoteURL URL          URL of the remote Poseidon server.
                           (default: "https://server.poseidon-adna.org")
  --archive STRING         The name of the Poseidon package archive that should
                           be queried. If not given, then the query falls back
                           to the default archive of the server selected with
                           --remoteURL. See the archive documentation at
                           https://www.poseidon-adna.org/#/archive_overview for
                           a list of archives currently available from the
                           official Poseidon Web API. (default: Nothing)
  --packages               List all packages.
  --fullOutput             extend the output to include information contained
                           the POSEIDON.yml file
  --groups                 List all groups, ignoring any group names after the
                           first as specified in the .janno-file.
  --individuals            List all individuals/samples.
  --fullJanno              output all Janno Columns
  -j,--jannoColumn COLNAME List additional fields from the janno files, using
                           the .janno column heading name, such as "Country",
                           "Site", "Date_C14_Uncal_BP", etc... Can be given
                           multiple times
  --bibliography           output bibliography information for packages
  --fullBib                output all bibliography fields found in any
                           bibliography item
  -b,--bibField BIB-FIELD  List information from the given bibliography field,
                           for example "abstract" or "publisher". Can be given
                           multiple times.
  --raw                    Return the output table as tab-separated values
                           without header. This is useful for piping into grep
                           or awk.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_summarise

### Tool Description
Get an overview over the content of one or multiple Poseidon packages

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident summarise (-d|--baseDir DIR) [--raw]

  Get an overview over the content of one or multiple Poseidon packages

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --raw                    Return the output table as tab-separated values
                           without header. This is useful for piping into grep
                           or awk.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_survey

### Tool Description
Survey the degree of context information completeness for Poseidon packages

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident survey (-d|--baseDir DIR) [--raw] [--onlyLatest]

  Survey the degree of context information completeness for Poseidon packages

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --raw                    Return the output table as tab-separated values
                           without header. This is useful for piping into grep
                           or awk.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.

Output structure
Data coverage proportions - 0: ., <0.25: ░, <0.5: ▒, <1: ▓, 1: █
.janno column order - G: Genotype data present, S: .ssf file present, B: .bib file present, 1: Poseidon_ID, 2: Genetic_Sex, 3: Group_Name, 4: Alternative_IDs, 5: Relation_To, 6: Relation_Degree, 7: Relation_Type, 8: Relation_Note, 9: Collection_ID, 10: Country, 11: Country_ISO, 12: Location, 13: Site, 14: Latitude, 15: Longitude, 16: Date_Type, 17: Date_C14_Labnr, 18: Date_C14_Uncal_BP, 19: Date_C14_Uncal_BP_Err, 20: Date_BC_AD_Start, 21: Date_BC_AD_Median, 22: Date_BC_AD_Stop, 23: Date_Note, 24: MT_Haplogroup, 25: Y_Haplogroup, 26: Source_Tissue, 27: Nr_Libraries, 28: Library_Names, 29: Capture_Type, 30: UDG, 31: Library_Built, 32: Genotype_Ploidy, 33: Data_Preparation_Pipeline_URL, 34: Endogenous, 35: Nr_SNPs, 36: Coverage_on_Target_SNPs, 37: Damage, 38: Contamination, 39: Contamination_Err, 40: Contamination_Meas, 41: Contamination_Note, 42: Genetic_Source_Accession_IDs, 43: Primary_Contact, 44: Publication, 45: Note, 46: Keywords
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-trident_validate

### Tool Description
Check Poseidon packages or package components for structural correctness

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-trident/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trident validate ((-d|--baseDir DIR) [--ignoreGeno] [--fullGeno] 
                          [--ignoreDuplicates] [-c|--ignoreChecksums] 
                          [--ignorePoseidonVersion] |
                          --pyml FILE | (-p|--genoOne FILE) | --genoFile FILE
                          --snpFile FILE --indFile FILE |
                          --bedFile FILE --bimFile FILE --famFile FILE | 
                          --vcfFile FILE | --janno FILE | --ssf FILE | 
                          --bib FILE) [--noExitCode] [--onlyLatest]

  Check Poseidon packages or package components for structural correctness

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  --ignoreGeno             Ignore snp and geno file.
  --fullGeno               Test parsing of all SNPs (by default only the first
                           100 SNPs are probed).
  --ignoreDuplicates       Do not stop on duplicated individual names in the
                           package collection.
  -c,--ignoreChecksums     Whether to ignore checksums. Useful for speedup in
                           debugging.
  --ignorePoseidonVersion  Read packages even if their poseidonVersion is not
                           compatible with trident.
  --pyml FILE              Path to a POSEIDON.yml file.
  -p,--genoOne FILE        One of the input genotype data files. Expects .bed,
                           .bed.gz, .bim, .bim.gz or .fam for PLINK, .geno,
                           .geno.gz, .snp, .snp.gz or .ind for EIGENSTRAT,
                           or.vcf or .vcf.gz for VCF. In case of EIGENSTRAT and
                           PLINK, the two other files must be in the same
                           directory and must have the same base name. If a
                           gzipped file is given, it is assumed that the file
                           pairs (.geno.gz, .snp.gz) or (.bim.gz, .bed.gz) are
                           both zipped, but not the .fam or .ind file. If a .ind
                           or .fam file is given, it is assumed that none of the
                           file triples is zipped.
  --genoFile FILE          Eigenstrat genotype matrix, optionally gzipped.
                           Accepted file endings are .geno, .geno.gz
  --snpFile FILE           Eigenstrat snp positions file, optionally gzipped.
                           Accepted file endings are .snp, .snp.gz
  --indFile FILE           Eigenstrat individual file. Accepted file endings are
                           .ind
  --bedFile FILE           Plink genotype matrix, optionally gzipped. Accepted
                           file endings are .bed, .bed.gz
  --bimFile FILE           Plink snp positions file, optionally gzipped.
                           Accepted file endings are .bim, .bim.gz
  --famFile FILE           Plink individual file. Accepted file endings are .fam
  --vcfFile FILE           VCF (Variant Call Format) file, optionall gzipped.
                           Accepted file endings are .vcf, .vcf.gz
  --janno FILE             Path to a .janno file.
  --ssf FILE               Path to a .ssf file.
  --bib FILE               Path to a .bib file.
  --noExitCode             Do not produce an explicit exit code.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.
trident v1.6.7.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```
