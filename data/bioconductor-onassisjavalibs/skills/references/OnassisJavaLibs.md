# OnassisJavaLibs: Java Libraries to support Onassis, Ontology Annotation and Semantic Similarity software

Eugenia Galeota

#### 2025-11-04

# Contents

* [1 Introduction](#introduction)
* [2 Contents of the package](#contents-of-the-package)
* [3 Accessing and compiling the Java source code](#accessing-and-compiling-the-java-source-code)
* [4 Use of the package](#use-of-the-package)
* [5 Acknowledgements](#acknowledgements)

# 1 Introduction

OnassisJavaLibs is a data package containing various compiled libraries in jar format and their source code used by *[Onassis](https://bioconductor.org/packages/3.22/Onassis)* to

* create a conceptmapper pipeline aimed at finding concepts belonging to OBO ontologies (OBO, OWL or RDF format) in any type of text
* compute different semantic similarity measures between two concepts of an ontology or two sets of concepts.

# 2 Contents of the package

Conceptmapper Java (1.8 version) libraries (<https://github.com/UCDenver-ccp/ccp-nlp>) version 3.3.2, and semantic similarity libraries (<https://github.com/UCDenver-ccp/ccp-nlp>) version 0.9.5 have been compiled using maven.

They are available in jar format within the extdata directory of this package and can be located through .

# 3 Accessing and compiling the Java source code

The source code for the java libraries is available in the `java` directory of package tarball. Users interested in compiling their own jar files can refer to the following information.

The `conceptmapper` subdirectory contains the java code to annotate text with concepts from OBO ontologies.
To create a jar file including all the needed dependencies, the source code can be compiled using maven (Apache Maven 3.3.9 was used).

The `slib` and `similarity` subdirectories contain the java code to determine the semantic similarities between concepts, and can be compiled and installed with the following goals, respectively:

```
#From the conceptmapper directory
mvn clean compile assembly:single --Dlog4j.configuration=log4j2.properties

#From the slib directory
mvn clean install

#From the similarity directory
mvn clean install assembly:single
```

# 4 Use of the package

The methods and classes implemented in the described Java libraries can be used through R functions and methods available within Onassis. Alternatively, the Java code can be directly executed using `rJava`. For example a dictionary from an OBO ontology file can be created through the following code:

```
require(rJava)
```

```
## Loading required package: rJava
```

```
#Initializing the JVM
.jinit()

#Adding the path to the jar file
jarfilePath <- file.path(system.file('extdata', 'java', 'conceptmapper-0.0.1-SNAPSHOT-jar-with-dependencies.jar', package='OnassisJavaLibs'))

.jaddClassPath(jarfilePath)

#Creating an instance of the OntologyUtil with the sample obo file
ontoutil <- .jnew("edu.ucdenver.ccp.datasource.fileparsers.obo.OntologyUtil", .jnew('java/io/File', file.path(system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs'))))

#Creating the output file containing the conceptmapper dictionary
outputFile = .jnew("java/io/File", "dict.xml")

#Building of the dictionary from the OBO ontology
dictionary <- J("edu.ucdenver.ccp.nlp.wrapper.conceptmapper.dictionary.obo.OboToDictionary")$buildDictionary(
  outputFile,
  ontoutil,
  .jnull(),
  J("edu.ucdenver.ccp.datasource.fileparsers.obo.OntologyUtil")$SynonymType$EXACT
)
```

To compute the semantic similarity between two terms of the same ontology, classes in the similarity library can be used in this way:

```
#Adding the similarity library containing the similarity class to compute semantic similarities
jarfilePath <- file.path(system.file('extdata', 'java', 'similarity-0.0.1-SNAPSHOT-jar-with-dependencies.jar', package='OnassisJavaLibs'))

.jaddClassPath(jarfilePath)

#Creating an instance of the class Similarity
similarity <- .jnew("iit/comp/epigen/nlp/similarity/Similarity")

#Loading the ontology in a grah structure
file_obo <- file.path(system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs'))

ontology_graph <- similarity$loadOntology(file_obo)

#Setting the semantic similarity measures
measure_configuration <- similarity$setPairwiseConfig('resnik', 'seco')

#Terms of the ontologies need to be converted into URIs

term1 <- 'http://purl.obolibrary.org/obo/CL_0000771'

term2 <- 'http://purl.obolibrary.org/obo/CL_0000988'

URI1 <- .jcast(similarity$createURI(term1), new.class = "org.openrdf.model.URI", check = FALSE, convert.array = FALSE)

URI2 <- .jcast(similarity$createURI(term2), new.class = "org.openrdf.model.URI", check = FALSE, convert.array = FALSE)

# Computation of the semantic similarity score

similarity_score <- .jcall(similarity, "D", "pair_similarity", URI1, URI2, .jcast(ontology_graph, new.class = "slib.graph.model.graph.G"), measure_configuration)

similarity_score
```

```
## [1] 0.04062586
```

# 5 Acknowledgements

We would like to thank you the library providers.

The methods for the conceptmapper pipeline and defining the ccp-nlp type system, have been developed and published by the Reagents of the University of Colorado under BSD 3-clause license.

The methods for computing the semantic similarities instead have been developed and published by the the Ecole des mines d’Alès under the GPL-compatible CeCILL license.

Both licenses are provided within the package.