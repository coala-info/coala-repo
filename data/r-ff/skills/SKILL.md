---
name: r-ff
description: "The ff package provides data structures that are stored on 	disk but behave (almost) as if they were in RAM by transparently  	mapping only a section (pagesize) in main memory - the effective  	virtual memory consumption per ff object. ff supports R's standard  	atomic data types 'double', 'logical', 'raw' and 'integer' and  	non-standard atomic types boolean (1 bit), quad (2 bit unsigned),  	nibble (4 bit unsigned), byte (1 byte signed with NAs), ubyte (1 byte  	unsigned), short (2 byte signed with NAs), ushort (2 byte unsigned),  	single (4 byte float with NAs). For example 'quad' allows efficient  	storage of genomic data as an 'A','T','G','C' factor. The unsigned  	types support 'circular' arithmetic. There is also support for  	close-to-atomic types 'factor', 'ordered', 'POSIXct', 'Date' and  	custom close-to-atomic types.  	ff not only has native C-support for vectors, matrices and arrays  	with flexible dimorder (major column-order, major row-order and  	generalizations for arrays). There is also a ffdf class not unlike  	data.frames and import/export filters for csv files. 	ff objects store raw data in binary flat files in native encoding, 	and complement this with metadata stored in R as physical and virtual 	attributes. ff objects have well-defined hybrid copying semantics,  	which gives rise to certain performance improvements through  	virtualization. ff objects can be stored and reopened across R  	sessions. ff files can be shared by multiple ff R objects  	(using different data en/de-coding schemes) in the same process  	or from multiple R processes to exploit parallelism. A wide choice of  	finalizer options allows to work with 'permanent' files as well as  	creating/removing 'temporary' ff files completely transparent to the  	user. On certain OS/Filesystem combinations, creating the ff files 	works without notable delay thanks to using sparse file allocation. 	Several access optimization techniques such as Hybrid Index  	Preprocessing and Virtualization are implemented to achieve good  	performance even with large datasets, for example virtual matrix  	transpose without touching a single byte on disk. Further, to reduce  	disk I/O, 'logicals' and non-standard data types get stored native and  	compact on binary flat files i.e. logicals take up exactly 2 bits to  	represent TRUE, FALSE and NA.  	Beyond basic access functions, the ff package also provides  	compatibility functions that facilitate writing code for ff and ram  	objects and support for batch processing on ff objects (e.g. as.ram,  	as.ff, ffapply). ff interfaces closely with functionality from package  	'bit': chunked looping, fast bit operations and coercions between  	different objects that can store subscript information ('bit',  	'bitwhich', ff 'boolean', ri range index, hi hybrid index). This allows 	to work interactively with selections of large datasets and quickly  	modify selection criteria.  	Further high-performance enhancements can be made available upon request. </p>"
homepage: https://cloud.r-project.org/web/packages/ff/index.html
---

# r-ff

name: r-ff
description: Memory-efficient storage and fast access for large datasets in R. Use this skill when working with datasets that exceed available RAM, requiring disk-based storage with transparent memory mapping. It supports specialized atomic types (boolean, quad, nibble, etc.), large matrices, and ffdf (data.frame-like) objects with high-performance I/O and chunked processing.

# r-ff

## Overview
The `ff` package provides data structures that are stored on disk but behave like RAM-resident objects. It achieves this by mapping only a small section (pagesize) into main memory. It is particularly useful for handling massive genomic data, large-scale matrices, and data frames (`ffdf`) that cannot fit in memory. It supports standard R types and non-standard packed types (e.g., 2-bit 'quad' for DNA bases) to further reduce disk footprint.

## Installation
```R
install.packages("ff")
# Often used with the 'bit' package for fast boolean indexing
install.packages("bit")
```

## Core Concepts and Workflows

### Creating ff Objects
`ff` objects can be vectors, matrices, or arrays.
```R
library(ff)

# Create an ff vector of integers
v <- ff(1:1000000, vmode="integer", filename="my_vec.ff")

# Create an ff matrix
m <- ff(0, dim=c(10000, 10000), vmode="double")

# Non-standard types (e.g., quad for 2-bit storage)
g <- ff(vmode="quad", length=1e6) 
```

### Working with ffdf (Data Frames)
`ffdf` objects are collections of `ff` vectors, mimicking R `data.frame` behavior.
```R
# Create ffdf from existing vectors
df <- ffdf(a=ff(1:10), b=ff(11:20))

# Import from CSV (efficiently handles large files)
dat <- read.table.ffdf(file="large_data.csv", sep=",", header=TRUE)
```

### Access and Indexing
Accessing `ff` objects looks like standard R, but triggers disk I/O.
```R
# Standard indexing
subset_v <- v[1:100]

# Virtual transpose (no data moved on disk)
m_transposed <- vt(m)

# Update in-place
v[1:10] <- 0
```

### Chunked Processing
To process data that exceeds RAM, use chunked loops to read/process/write in stages.
```R
# Use chunk() from the bit package
library(bit)
for (i in chunk(v)){
  # Process a piece of the data in RAM
  v[i] <- v[i] * 2
}
```

### Persistence and Finalizers
`ff` objects use finalizers to manage disk files.
- **Temporary**: Files are deleted when the R session ends or the object is garbage collected (default).
- **Permanent**: Use `finalizer="close"` to keep files on disk.
```R
# Save metadata to reopen in a later session
ffsave(v, file="my_data")
# In a new session:
ffload("my_data")
```

## Tips for Performance
1. **vmode**: Choose the smallest `vmode` possible (e.g., `byte` or `short` instead of `integer`) to save disk space and I/O time.
2. **dimorder**: For matrices, match the `dimorder` to your access pattern (row-major vs column-major).
3. **Hybrid Indexing**: `ff` uses "hi" (hybrid index) objects to optimize non-contiguous disk access.
4. **Avoid as.ram**: Calling `as.ram(obj)` loads the entire object into memory. Only use it on small subsets.

## Reference documentation
- [Large objects for R project](./references/home_page.md)