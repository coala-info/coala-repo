# Code example from 'OnassisJavaLibs' vignette. See references/ for full tutorial.

## ----echo=TRUE, eval=TRUE-----------------------------------------------------

require(rJava)

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

## ----echo=TRUE, eval=TRUE-----------------------------------------------------

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

