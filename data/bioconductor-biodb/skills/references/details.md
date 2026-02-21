# Details on biodb

Pierrick Roger

#### 29 October 2025

#### Abstract

Provides some more advanced knowledge on *biodb*: OOP model, configuration,
request scheduler, persistent cache, logging…

#### Package

biodb 1.18.0

# 1 Introduction

In this document are presented different aspects of *biodb* in more details:
the object oriented programming model adopted,
its architecture,
how to configure the package,
how to create connectors and delete them,
understanding the request scheduler,
how to tune the logging system.

# 2 Object oriented programming (OOP) model

In R, you may already know the two classical OOP models *S3* and *S4*.
*S4* is certainly the most used model, and is based on an original system of
generic methods that can be specialized for each class.

Two more recent OOP models exist in R: *Reference Classes* (aka *RC* or *R5*
from package *methods*) and *R6* (from package *R6*).
These two models are very similar.
The *biodb* package uses a mix of *RC* and *R6*, but will switch completely to
*R6* in a near future.

They both implement an object model and based on references.
This means that each object is unique, never copied and accessed through
references.
In this system, the created objects are not copied, but their reference are
copied.
Any modification of an object in one part of the code, will be visible from all
other parts of the code.
This means that when you pass an instance to a function, that function is able
to modify the instance.

Also, in *RC* and *R6*, the functions are attached to the object.
In other words, the mechanism to call a function on a object is different from
*S4*.
The calling mechanism is thus slightly different, in *RC* or *R6* we write
`myObject$myFunction()` instead of `myFunction(myObject)` in S4.

See
[Reference Classes](https://www.rdocumentation.org/packages/methods/versions/3.6.0/topics/ReferenceClasses) chapter from package *methods*
and this [introduction to R6](https://r6.r-lib.org/articles/Introduction.html)
for more details.

# 3 Initialization & termination

*biodb* uses an initialization/termination scheme. You must first initialize
the library by creating an instance of the main class `BiodbMain`:

```
mybiodb <- biodb::newInst()
```

And when you are done with the library, you have to terminate the instance
explicitly:

```
mybiodb$terminate()
```

We will need a *biodb* instance for the rest of this vignette. Let us call the
constructor again:

```
mybiodb <- biodb::newInst()
```

# 4 Management classes

Several class instances are attached to the *biodb* instance for managing
different aspects of *biodb*: creating connectors, configuring *biodb*,
accessing the cache system, etc.

See table [1](#tab:mngtClasses) for a list of these instances and their
purpose.

Table 1: The management classes
Only one instance is created for each of theses classes, and attached to the `BiodbMain` instance,

| Class | Method to get the instance | Description |
| --- | --- | --- |
| BiodbConfig | `mybiodb$getConfig()` | Access to configuration values, and modification. |
| BiodbDbsInfo | `mybiodb$getDbsInfo()` | Databases information (name, description, request frequency, etc). |
| BiodbEntryFields | `mybiodb$getEntryFields()` | Entry fields information (description, type, cardinality, etc). |
| BiodbFactory | `mybiodb$getFactory()` | Creation of connectors and entries. |
| BiodbPersistentCache | `mybiodb$getPersistentCache()` | Return an instance of fscache::Cache that manages a cache system on disk. |
| BiodbRequestScheduler | `mybiodb$getRequestScheduler()` | Send requests to web servers, respecting the frequency limit for each database server. |

# 5 Configuration

Several configuration values are defined inside the `definitions.yml` file of
*biodb*.
New configuration values can also be defined in extension packages.

o get a list of the existing configuration keys with their current value, run:

```
mybiodb$getConfig()
```

```
## Biodb configuration instance.
##   Values:
##      allow.huge.downloads :  TRUE
##      autoload.extra.pkgs :  FALSE
##      cache.all.requests :  TRUE
##      cache.directory :  NA
##      cache.read.only :  FALSE
##      cache.system :  TRUE
##      compute.fields :  TRUE
##      dwnld.chunk.size :  NA
##      dwnld.timeout :  3600
##      entries.sep :  |
##      force.locale :  TRUE
##      intra.field.name.sep :  .
##      multival.field.sep :  ;
##      offline :  FALSE
##      proton.mass :  1.007276
##      svn.binary.path :
##      test.functions :  NA
##      use.cache.for.local.db :  FALSE
##      useragent :  R Bioconductor biodb library.
```

To get a data frame of all keys with their title (short description), type and
default value, call (result in table [2](#tab:keysDf)):

```
x <- mybiodb$getConfig()$listKeys()
```

Table 2: List of keys with some of their parameters

| key | title | type | default |
| --- | --- | --- | --- |
| allow.huge.downloads | Authorize download of big files. | logical | TRUE |
| autoload.extra.pkgs | Enable automatic loading of extension packages. | logical | FALSE |
| cache.all.requests | Enable caching of all requests and their results. | logical | TRUE |
| cache.directory | Path to the cache folder. | character | NA |
| cache.read.only | Set cache system in read only mode. | logical | FALSE |
| cache.system | Enable cache system. | logical | TRUE |
| use.cache.for.local.db | Enable the use of the cache system also for local databases. | logical | FALSE |
| dwnld.chunk.size | The number of new entries to wait before saving them into the cache. | integer | NA |
| dwnld.timeout | Download timeout in seconds. | integer | 3600 |
| compute.fields | Enable automatic computing of missing fields. | logical | TRUE |
| force.locale | Force change of current locale for the application. | logical | TRUE |
| multival.field.sep | The separator used for concatenating values. | character | ; |
| intra.field.name.sep | The separator use for building a field name. | character | . |
| entries.sep | The separator used between values from different entries. | character | | |
| offline | Stops sending requests to the network. | logical | FALSE |
| proton.mass | The mass of one proton. | numeric | 1.0072765 |
| svn.binary.path | The path to the svn binary. | character |  |
| test.functions | List of functions to test. | character | NA |
| useragent | The application name and contact address to send to the contacted web server. | character | R Bioconductor biodb library. |

To get the description of a key, run:

```
mybiodb$getConfig()$getDescription('useragent')
```

```
## [1] "The user agent description string. This string is compulsory when connection to remote databases."
```

To get a value, run:

```
mybiodb$getConfig()$get('useragent')
```

```
## [1] "R Bioconductor biodb library."
```

To set a field value, run:

```
mybiodb$getConfig()$set('useragent', 'My application ; wizard@of.oz')
mybiodb$getConfig()$get('useragent')
```

```
## [1] "My application ; wizard@of.oz"
```

If the field is boolean, you can use the following methods instead:

```
mybiodb$getConfig()$enable('offline')
mybiodb$getConfig()$disable('offline')
```

Configuration keys have default values.
You can get a key’s default value with this call:

```
mybiodb$getConfig()$getDefaultValue('useragent')
```

```
## [1] "R Bioconductor biodb library."
```

Environment variables can be used to overwrite default values.
To get the name of the environment variable associated with a particular key,
call the following method:

```
mybiodb$getConfig()$getAssocEnvVar('useragent')
```

```
## [1] "BIODB_USERAGENT"
```

# 6 Databases information

Before creating any connector, you can information on the available databases
and their connector classes.

Getting the databases info instance will print you a list of all available
database connector classes:

```
mybiodb$getDbsInfo()
```

```
## Biodb databases information instance.
## The following databases are defined:
##   comp.csv.file: Compound CSV File connector class.
##   comp.sqlite: Compound SQLite connector class.
##   mass.csv.file: Mass spectra CSV File connector class.
##   mass.sqlite: Mass spectra SQLite connector class.
```

If you want more information on one particular connector, run:

```
mybiodb$getDbsInfo()$get('mass.csv.file')
```

```
## Mass spectra CSV File class.
##   Class: mass.csv.file.
##   Package: biodb.
##   Description: A connector to handle a mass spectra database stored inside a CSV file. It is possible to choose the separator for the CSV file, as well as match the column names with the biodb entry fields...
##   Entry content type: tsv.
```

# 7 Accessing a custom CSV file with a biodb connector

When creating a connector with `CompCsvFileConn` or `MassCsvFileConn`, if your
CSV file uses standard biodb field names as column names in its header line,
then everything will be fine and all values will read, recognized and set into
entry objects.

However if your CSV file uses custom column names, those values will be ignore
by biodb.
To tell biodb to use those columns, you must define a mapping between each
custom column with a valid biodb entry field, by using the `setField()` method.

Here we create a connector to a CSV file database (see table
[3](#tab:compTable) for content) of chemical compounds that uses the semi-colon
as a separator:

```
compUrl <- system.file("extdata", "chebi_extract_custom.csv", package='biodb')
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)
compdb$setCsvSep(';')
```

We use the `getUnassociatedColumns()` method to get a list of custom column
names:

```
compdb$getUnassociatedColumns()
```

```
## Warning in warn("Column \"%s\" does not match any biodb field.", colname):
## Column "ID" does not match any biodb field.
```

```
## Warning in warn("Column \"%s\" does not match any biodb field.", colname):
## Column "molmass" does not match any biodb field.
```

```
## Warning in warn("Column \"%s\" does not match any biodb field.", colname):
## Column "kegg" does not match any biodb field.
```

```
## [1] "ID"      "molmass" "kegg"
```

The method returns 3 column names that have not been automatically mapped.
However there is a little trick here, since `mass` field has been automatically
mapped but with the wrong biodb field `molecular.mass`, as you can see when
calling the method `getFieldsAndColumnsAssociation()`:

```
compdb$getFieldsAndColumnsAssociation()
```

```
## $formula
## [1] "formula"
##
## $molecular.mass
## [1] "mass"
##
## $name
## [1] "name"
##
## $smiles
## [1] "smiles"
##
## $description
## [1] "description"
```

The `mass` column of the CSV file stores in fact the monoisotopic masses.
So we need to remap this column, and before that to reset the connector:

```
mybiodb$getFactory()$deleteConn(compdb)
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)
compdb$setCsvSep(';')
compdb$setField('accession', 'ID')
compdb$setField('kegg.compound.id', 'kegg')
compdb$setField('monoisotopic.mass', 'mass')
compdb$setField('molecular.mass', 'molmass')
```

Now the connector works fine, and we can for instance get a list of all
accession numbers:

```
compdb$getEntryIds()
```

```
##  [1] "1018"  "1390"  "1456"  "1549"  "1894"  "1932"  "1997"  "10561" "15939"
## [10] "16750" "35485" "40304" "64679"
```

And get whichever entry we want:

```
compdb$getEntry('1018')$getFieldsAsDataframe()
```

```
##   accession kegg.compound.id monoisotopic.mass molecular.mass   formula
## 1      1018           C07279           168.972        169.012 C2H8AsNO3
##                   name          smiles description comp.csv.file.id
## 1 2-Aminoethylarsonate NCC[As](O)(O)=O                         1018
```

Table 3: Excerpt from compound database CSV file.

| ID | formula | mass | molmass | kegg | name | smiles | description |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1018 | C2H8AsNO3 | 168.97201 | 169.012 | C07279 | 2-Aminoethylarsonate | `NCC[As](O)(O)=O` |  |
| 1390 | C8H8O2 | 136.05243 | 136.148 | C06224 | 3,4-Dihydroxystyrene | `Oc1ccc(C=C)cc1O` |  |
| 1456 | C3H9NO2 | 91.06333 | 91.109 | C06057 | 3-aminopropane-1,2-diol | `NC[C@H](O)CO` |  |
| 1549 | C3H5O3R | 89.02387 | 89.070 | C03834 | 3-hydroxymonocarboxylic acid | `OC([*])CC(O)=O` |  |
| 1894 | C5H11NO | 101.08406 | 101.147 | C10974 | 4-Methylaminobutanal | `CNCCCC=O` |  |
| 1932 | C6H6NR | 92.05002 | 92.119 | C03084 | 4-Substituted aniline | `Nc1ccc([*])cc1` |  |

# 8 Request scheduler

The `BiodbRequestScheduler` instance is responsible for sending requests to web
server, taking care of respecting the frequency specified by the `scheduler.n`
and `scheduler.t` parameters, and for receiving results and saving them to cache.

The cache is used to give back a result immediately without contacting the
server, in case the exact same request has already been run previously.

You do not have to interact with the request scheduler, it runs as a back end
component.

# 9 Entry fields information

The `BiodbEntryFields` instance stores information about all entry fields
declared inside definitions YAML files.

Get the entry fields instance:

```
mybiodb$getEntryFields()
```

```
## Biodb entry fields information instance.
```

Get a list of all defined fields:

```
mybiodb$getEntryFields()$getFieldNames()
```

```
##  [1] "aa.seq"                    "aa.seq.length"
##  [3] "aa.seq.location"           "accession"
##  [5] "average.mass"              "cas.id"
##  [7] "catalytic.activity"        "charge"
##  [9] "chebi.id"                  "chemspider.id"
## [11] "chrom.col.constructor"     "chrom.col.diameter"
## [13] "chrom.col.id"              "chrom.col.length"
## [15] "chrom.col.method.protocol" "chrom.col.name"
## [17] "chrom.flow.gradient"       "chrom.flow.rate"
## [19] "chrom.rt"                  "chrom.rt.max"
## [21] "chrom.rt.min"              "chrom.rt.unit"
## [23] "chrom.solvent"             "cofactor"
## [25] "comp.csv.file.id"          "comp.iupac.name.allowed"
## [27] "comp.iupac.name.cas"       "comp.iupac.name.pref"
## [29] "comp.iupac.name.syst"      "comp.iupac.name.trad"
## [31] "comp.sqlite.id"            "comp.super.class"
## [33] "composition"               "compound.id"
## [35] "description"               "ec"
## [37] "equation"                  "expasy.enzyme.id"
## [39] "formula"                   "gene.symbol"
## [41] "hmdb.metabolites.id"       "inchi"
## [43] "inchikey"                  "kegg.compound.id"
## [45] "kegg.genes.id"             "logp"
## [47] "mass.csv.file.id"          "mass.sqlite.id"
## [49] "molecular.mass"            "monoisotopic.mass"
## [51] "ms.level"                  "ms.mode"
## [53] "msdev"                     "msdevtype"
## [55] "msprecannot"               "msprecmz"
## [57] "mstype"                    "name"
## [59] "nb.compounds"              "nb.peaks"
## [61] "ncbi.gene.id"              "ncbi.pubchem.comp.id"
## [63] "nominal.mass"              "nt.seq"
## [65] "nt.seq.length"             "organism"
## [67] "pathway.class"             "peak.attr"
## [69] "peak.comp"                 "peak.error.ppm"
## [71] "peak.formula"              "peak.intensity"
## [73] "peak.mass"                 "peak.mz"
## [75] "peak.mzexp"                "peak.mztheo"
## [77] "peak.relative.intensity"   "peaks"
## [79] "products"                  "smiles"
## [81] "smiles.canonical"          "smiles.isomeric"
## [83] "substrates"
```

Get information about a field:

```
mybiodb$getEntryFields()$get('monoisotopic.mass')
```

```
## Entry field "monoisotopic.mass".
##   Description: Monoisotopic mass, in u (unified atomic mass units) or Da (Dalton). It is computed using the mass of the primary isotope of the elements including the mass defect (mass difference between neutron and proton, and nuclear binding energy). Used with high resolution mass spectrometers. See https://en.wikipedia.org/wiki/Monoisotopic_mass.
##   Class: double.
##   Type: mass.
##   Cardinality: one.
##   Aliases: exact.mass.
```

The object returned is a `BiodbEntryField` instance.
See the help page of this class to get a list of all methods you can call on
such an instance.

# 10 Persistent cache system

The persistent cache system is responsible for saving entry contents and
results of web server requests onto disk, and reuse them later to avoid
recontacting the web server.

Run the following method to get the instance of the `BiodbPersistentCache`
class:

```
mybiodb$getPersistentCache()
```

```
## Cache class
##   The main cache folder is at /home/biocbuild/.cache/R/biodb.
##   The cache is readable.
##   The cache is writable.
```

Do delete all entries of a connector from the persistence cache, run:

```
conn$deleteAllEntriesFromPersistentCache()
```

After that we need to delete entry instances from memory with the following
call:

```
conn$deleteAllEntriesFromVolatileCache()
```

Note that the results of web server requests are still inside the cache folder.
In order to force a new downloading of data, we need to erase those files too.
The following call will erase all cache files associated with a connector,
including the files deleted by `deleteAllEntriesFromPersistentCache()`:

```
conn$deleteWholePersistentCache()
```

# 11 Logging messages

*biodb* uses the *lgr* package for logging messages.
The *lgr* instance used by *biodb* can be gotten by calling:

```
biodb::getLogger()
```

```
## <Logger> [info] biodb
##
## inherited appenders:
##   console: <AppenderConsole> [all] -> console
```

See the [lgr](https://s-fleck.github.io/lgr/) home page for demonstration on
how to use it.

You can use the following *biodb* short cuts to send messages of different
levels.
To send an information message:

```
biodb::logInfo("%d entries have been processed.", 12)
```

To send a debug message:

```
biodb::logDebug("The file %s has been written.", 'myfile.txt')
```

To send a trace message:

```
biodb::logTrace("%d bytes written.", 1284902)
```

In addition *biodb* defines two methods to throw an error or a warning and log
this error or warning at the same time.
These are `biodb::error()` and `biodb::warn()`.

By default the *lgr* package displays information messages.
If you want to silence all messages, just run `lgr::lgr$remove_appender(1)`.
This is will remove the default appender and silence all messages from all
packages using *lgr*, including *biodb*.
However if you just want to silence *biodb* messages, run:

```
biodb::getLogger()$set_threshold(300)
```

Information messages are now silenced:

```
biodb::logInfo("hello")
```

For enabling again:

```
biodb::getLogger()$set_threshold(400)
```

And messages are echoed again:

```
biodb::logInfo("hello")
```

# 12 Closing biodb instance

Do not forget to terminate your biodb instance once you are done with it:

```
mybiodb$terminate()
```

# 13 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodb_1.18.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         bitops_1.0-9
##  [4] RSQLite_2.4.3       stringi_1.8.7       hms_1.1.4
##  [7] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
## [10] bookdown_0.45       fastmap_1.2.0       blob_1.2.4
## [13] R.oo_1.27.1         plyr_1.8.9          jsonlite_2.0.0
## [16] R.utils_2.13.0      progress_1.2.3      sqlq_1.0.1
## [19] DBI_1.2.3           BiocManager_1.30.26 XML_3.99-0.19
## [22] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [25] chk_0.10.0          crayon_1.5.3        R.methodsS3_1.8.2
## [28] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [31] yaml_2.3.10         tools_4.5.1         memoise_2.0.1
## [34] sched_1.0.3         vctrs_0.6.5         R6_2.6.1
## [37] lifecycle_1.0.4     stringr_1.5.2       bit_4.6.0
## [40] pkgconfig_2.0.3     bslib_0.9.0         glue_1.8.0
## [43] Rcpp_1.1.0          lgr_0.5.0           xfun_0.53
## [46] knitr_1.50          fscache_1.0.5       htmltools_0.5.8.1
## [49] rmarkdown_2.30      compiler_4.5.1      prettyunits_1.2.0
## [52] askpass_1.2.1       RCurl_1.98-1.17     openssl_2.3.4
```

# 14 References