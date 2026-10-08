# evofold2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| evofold2_EvoFoldV2 | PASS |  |
| evofold2_dfgEval | PASS |  |
| evofold2_dfgTrain | PASS |  |
| evofold2_grammarTrain | PASS |  |
| evofold2_multinomial | PASS | synthetic data: small planted counts with a hand-checkable answer (0.012016) |

## evofold2_dfgEval

### Tool Description
dfgEval allows implementation of discrete factor graphs and evaluates the probability of data sets under these models.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofold2:0.1--0
- **Homepage**: https://github.com/jakob-skou-pedersen/phy
- **Package**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jakob-skou-pedersen/phy
- **Stars**: N/A
### Original Help Text
```text
dfgEval allows implementation of discrete factor graphs and evaluates the probability of data sets under these models.

  Usage: dfgEval [options] <inputVarData.tab> [inputFacData.tab]

The arguments inputVarData.tab and inputFacData.tab are both in named data format.
Allowed options:
  -h [ --help ]                         produce help message
  -o [ --ppFile ] arg                   Calculate posterior probabilities for 
                                        each state of each random variable and 
                                        output to file.
  -n [ --ncFile ] arg                   Calculate normalization constant output
                                        to file.
  -m [ --mpsFile ] arg                  Calculate most probable state for each 
                                        random variable and output to file.
  --expFile arg                         Calculate expectancies and output to 
                                        file
  -p [ --precision ] arg (=5)           Output precision of real numbers.
  --ppSumOther                          For post probs, for each state output 
                                        sum of post probs for all the other 
                                        states for that variable. This retains 
                                        precision for post probs very close to 
                                        one.
  -l [ --minusLogarithm ]               Output minus the natural logarithm of 
                                        result values (program will terminate 
                                        on negative results...).
  --mpsVars arg                         Define the random variables for which 
                                        the most probable state (mps) should be
                                        output. Default is to output the mps 
                                        for all random variables. The 
                                        specification string must be enclosed 
                                        in citation marks and whitespace 
                                        separated if it includes more than one 
                                        random variable, e.g.: "X Y".
  --ppVars arg                          Define the random variables for which 
                                        the posterior state probabilities (pp) 
                                        should be calculated. Default is to 
                                        output the pp for all states of all 
                                        random variables (may generate much 
                                        output!). Random variables are 
                                        specified similar to mpsVars, but must 
                                        be semicolon (';') separated. It is 
                                        possible to only output pp's for 
                                        certain states, in which case the 
                                        following specification format is used:
                                        "X=a b c; Y=a b".
  -s [ --dfgSpecPrefix ] arg (=./dfgSpec/)
                                        Prefix of DFG specification files..
  --factorGraphFile arg (=factorGraph.txt)
                                        Specification of the factor graph 
                                        structure.
  --variablesFile arg (=variables.txt)  Specification of the state map used by 
                                        each variable.
  --stateMapFile arg (=stateMaps.txt)   Specification of state maps.
  --facPotFile arg (=factorPotentials.txt)
                                        Specification of factor potentials.
  --subVarFile arg                      Input subscribed variables file in 
                                        named data format. Must use same 
                                        identifiers in same order as varFile
```


## evofold2_dfgTrain

### Tool Description
dfgTrain allows implementation of discrete factor graphs and evaluates the probability of data sets under these models.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofold2:0.1--0
- **Homepage**: https://github.com/jakob-skou-pedersen/phy
- **Package**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Validation**: PASS

### Original Help Text
```text
dfgTrain allows implementation of discrete factor graphs and evaluates the probability of data sets under these models.

  Usage: dfgTrain [options] <inputVarData.tab> [inputFacData.tab]

The arguments inputVarData.tab and inputFacData.tab are both in named data format.

Allowed options:
  -h [ --help ]                         produce help message
  -p [ --precision ] arg (=5)           Output precision of real numbers.
  -d [ --minDeltaLogLik ] arg (=0.0001) Defines stopping criteria for the EM 
                                        training. The training will stop when 
                                        the difference in log likelihood is 
                                        below minDeltaLogLik (default is 1e-4).
  -i [ --maxIter ] arg (=100)           Max numbr if iterations of the EM 
                                        training (default is 100).
  -l [ --logFile ] arg (=logFile.txt)   Log file for EM training.
  -e [ --emTrain ]                      Perform EM training.
  --dotFile arg                         Output dfg in dot format to given 
                                        fileName. (To convert to ps format, 
                                        e.g. run: "cat fileName.dot | dot -Tps 
                                        -Kneato -Gsize="7.5,10" -o dfg.ps".)
  -s [ --dfgSpecPrefix ] arg (=./dfgSpec/)
                                        Prefix of DFG specification files.
  -o [ --outSpecPrefix ] arg (=out_)    Prefix of DFG specification files. Any 
                                        included prefix directory must already 
                                        exist.
  -t [ --tmpSpecPrefix ] arg            Prefix of DFG specification files 
                                        written during each iteration of 
                                        training. Allows state of EM to be 
                                        saved - especially useful for large 
                                        datasets. Any included prefix directory
                                        must already exist. Not defined and not
                                        performed by default. 
  --factorGraphFile arg (=factorGraph.txt)
                                        Specification of the factor graph 
                                        structure.
  --variablesFile arg (=variables.txt)  Specification of the state map used by 
                                        each variable.
  --stateMapFile arg (=stateMaps.txt)   Specification of state maps.
  --facPotFile arg (=factorPotentials.txt)
                                        Specification of factor potentials.
  --subVarFile arg                      Input subscribed variables file in 
                                        named data format. Must use same 
                                        identifiers in same order as varFile
  --writeInfo                           Print factor graph info. Useful for 
                                        debugging factor graph specification.
```


## evofold2_EvoFoldV2

### Tool Description
EvoFold predicts and scores secondary structures in multiple sequence alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofold2:0.1--0
- **Homepage**: https://github.com/jakob-skou-pedersen/phy
- **Package**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Validation**: PASS

### Original Help Text
```text
EvoFold predicts and scores secondary structures in mulitple sequence alignments.

  Usage: EvoFold [options] <alg.ama> <tree.neiwck>

The tabular output contains the following columns:

  seqId beginPos endPos basePairCount strCykProb bgCykProb strProb bgProb cykScore score strPostProb fold posScore

Setting alg.ama to '-' reads from stdin.
Allowed options:
  -h [ --help ]                     produce help message
  -c [ --configFilePath ] arg (=./) Path to EvoFold configuration files.
  -f [ --completeFile ] arg         Output complete structure predictions for 
                                    each input element in addition to the 
                                    sub-structures.
  -n [ --annoName ] arg             Name of annotation to use (see annoMap file
                                    for definition of annotation symbols. Note 
                                    that '*' can be used as wildcard. 
                                    Specifying annotation is useful for adding 
                                    constraints on the predicted structure.
  --decimals arg (=5)               Output precision of score.
  -o [ --outputFile ] arg (=-)      Output file (default is stdout).
```

## evofold2_grammarTrain

### Tool Description
grammarTrain estimates transition probabilities of stochastic context free grammars.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofold2:0.1--0
- **Homepage**: https://github.com/jakob-skou-pedersen/phy
- **Package**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Validation**: PASS

### Original Help Text
```text
grammarTrins estimate transition probabilities (production rule probabilities) of stochastic context free grammars. Currently ama type input data is supported.

  Usage: grammarTrain [options] <grammar.txt> <emitModels.txt> <alg.ama>

Setting alg.ama to '-' reads from stdin.
Allowed options:
  -h [ --help ]                         produce help message
  -t [ --treeFile ] arg                 File with Newick tree used with phylo 
                                        grammars.
  -a [ --annoMapFile ] arg              Anno map file.
  -n [ --annoName ] arg                 Name of annotation to use.
  -p [ --pseudoCounts ] arg (=0)        Defines total number of pseudocounts 
                                        used for each transition distribution 
                                        (For each transition, the number of 
                                        pseudocounts is defined as the initital
                                        transition probs in the input file 
                                        times the given pseudoCounts value).
  -d [ --minDeltaLogLik ] arg (=0.0001) Defines stopping criteria for the EM 
                                        training. The training will stop when 
                                        the difference in log likelihood is 
                                        below minDeltaLogLik (default is 1e-4).
  -i [ --maxIter ] arg (=100)           Max numbr if iterations of the EM 
                                        training (default is 100).
  -l [ --logFile ] arg (=grammarLogFile.txt)
                                        Log file for EM training (default is 
                                        ./grammarLogFile.txt).
  -o [ --outputGrammar ] arg (=-)       Output file for trained grammar 
                                        (default is stdout).
  -o [ --tmpGrammar ] arg (=tmpGrammar.txt)
                                        Output file for partly trained grammar,
                                        printed in each interation (default is 
                                        tmpGrammar.txt).
```

## evofold2_multinomial

### Tool Description
multinomial calculates probabilities of category counts under the multinomial distribution.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofold2:0.1--0
- **Homepage**: https://github.com/jakob-skou-pedersen/phy
- **Package**: https://anaconda.org/channels/bioconda/packages/evofold2/overview
- **Validation**: PASS

### Original Help Text
```text
multinomial calculates probabilities of category counts under the multinomial distribution.

  Usage: multinomial [options] <parameters.tab> <counts.tab> <output.tab> 

By default, all input and output files use named data format.

Allowed options:
  -h [ --help ]               produce help message
  -p [ --precision ] arg (=5) Output precision of real numbers.
  -c [ --coefficients ]       Output coefficients instead of probabilities.
  -f [ --outputFormat ] arg   Use alternative output format. Possible values 
                              are: vector, rowMat, and colMat, which all use 
                              ublas style formatting.
  -l [ --logarithm ]          Output natural logarithm of result values.
```

## Metadata
- **Skill**: generated
