---
name: bioconductor-onassisjavalibs
description: This package provides Java libraries and R interfaces for ontology annotation and semantic similarity calculations. Use when user asks to create ConceptMapper dictionaries from OBO files, annotate text with ontology concepts, or compute semantic similarity scores between ontology terms.
homepage: https://bioconductor.org/packages/release/data/experiment/html/OnassisJavaLibs.html
---


# bioconductor-onassisjavalibs

name: bioconductor-onassisjavalibs
description: Provides Java libraries and R interfaces for ontology annotation and semantic similarity. Use when needing to create ConceptMapper dictionaries from OBO files or compute semantic similarity scores between ontology terms using the Onassis framework.

# bioconductor-onassisjavalibs

## Overview

`OnassisJavaLibs` is a Bioconductor data package that provides the underlying Java infrastructure for the `Onassis` package. It contains compiled JAR files and source code for:
1. **ConceptMapper**: Annotating text with concepts from OBO, OWL, or RDF ontologies.
2. **Semantic Similarity**: Computing measures (e.g., Resnik, Seco) between ontology concepts or sets of concepts.

While primarily a dependency for `Onassis`, users can interact with these libraries directly via `rJava`.

## Core Workflows

### Initializing the Java Virtual Machine
Before using any functionality, you must initialize the JVM and add the specific JAR files to the class path.

```r
library(rJava)
library(OnassisJavaLibs)

.jinit()

# Path to ConceptMapper JAR
cm_jar <- system.file("extdata", "java", "conceptmapper-0.0.1-SNAPSHOT-jar-with-dependencies.jar", package="OnassisJavaLibs")
.jaddClassPath(cm_jar)

# Path to Similarity JAR
sim_jar <- system.file("extdata", "java", "similarity-0.0.1-SNAPSHOT-jar-with-dependencies.jar", package="OnassisJavaLibs")
.jaddClassPath(sim_jar)
```

### Creating a ConceptMapper Dictionary
To convert an OBO ontology into a dictionary format (`dict.xml`) usable for text annotation:

```r
# Load the OBO file (example provided in package)
obo_file <- system.file("extdata", "sample.cs.obo", package="OnassisJavaLibs")

# Create OntologyUtil instance
ontoutil <- .jnew("edu.ucdenver.ccp.datasource.fileparsers.obo.OntologyUtil", 
                  .jnew("java/io/File", obo_file))

# Define output file
output_file <- .jnew("java/io/File", "dict.xml")

# Build the dictionary
J("edu.ucdenver.ccp.nlp.wrapper.conceptmapper.dictionary.obo.OboToDictionary")$buildDictionary(
  output_file,
  ontoutil,
  .jnull(),
  J("edu.ucdenver.ccp.datasource.fileparsers.obo.OntologyUtil")$SynonymType$EXACT
)
```

### Computing Semantic Similarity
To calculate the similarity score between two ontology terms:

```r
# 1. Initialize Similarity class
similarity_obj <- .jnew("iit/comp/epigen/nlp/similarity/Similarity")

# 2. Load the ontology graph
obo_path <- system.file("extdata", "sample.cs.obo", package="OnassisJavaLibs")
ontology_graph <- similarity_obj$loadOntology(obo_path)

# 3. Configure measures (e.g., Resnik and Seco)
measure_config <- similarity_obj$setPairwiseConfig("resnik", "seco")

# 4. Convert term IDs to URIs
term1 <- "http://purl.obolibrary.org/obo/CL_0000771"
term2 <- "http://purl.obolibrary.org/obo/CL_0000988"

uri1 <- .jcast(similarity_obj$createURI(term1), "org.openrdf.model.URI")
uri2 <- .jcast(similarity_obj$createURI(term2), "org.openrdf.model.URI")

# 5. Compute score
score <- .jcall(similarity_obj, "D", "pair_similarity", 
                uri1, uri2, 
                .jcast(ontology_graph, "slib.graph.model.graph.G"), 
                measure_config)
print(score)
```

## Tips and Troubleshooting
- **Memory**: If working with large ontologies, increase the JVM heap size *before* calling `.jinit()` using `options(java.parameters = "-Xmx4g")`.
- **Casting**: When using `.jcall` or passing objects to Java methods, ensure you use `.jcast` to the specific interface expected by the Java library (e.g., `slib.graph.model.graph.G`).
- **File Paths**: Always use `system.file` to locate the bundled JARs and sample OBO files within the package structure.

## Reference documentation
- [OnassisJavaLibs](./references/OnassisJavaLibs.md)