# biotransformer CWL Generation Report

## biotransformer

### Tool Description
BioTransformer is a software tool that predicts small molecule metabolism in mammals, their gut microbiota, as well as the soil/aquatic microbiota. It also assists in metabolite identification based on metabolism prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/biotransformer:3.0.20230403--hdfd78af_0
- **Homepage**: https://bitbucket.org/djoumbou/biotransformer
- **Package**: https://anaconda.org/channels/bioconda/packages/biotransformer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biotransformer/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage:
java -jar biotransformer-4.0.jar [-a] [-b <BioTransformer Option>] [-cm
       <CYP450 Prediction Mode>] [-f <Formulas>] [-h] [-imol <MOL Input>]
       [-isdf <Sdf Input>] [-ismi <SMILES Input>] [-k <BioTransformer
       Task>] [-m <Masses>] [-mt <mass threshold for input substrates>]
       [-multiThread <MultiThread input>] [-ocsv <Csv Output>] [-osdf <Sdf
       Output>] [-pm <PhaseII Prediction Mode>] [-q <BioTransformer
       Sequence Option>] [-s <Number of steps>] [-t <Mass Tolerance>]
       [-useDB <Use retrieving from database feature>] [-useSub <Use the
       first 14 characters of the InChIkey when retrieving from database
       feature>]

This is the version 4.0 of BioTransformer. BioTransformer is a software
tool that predicts small molecule metabolism in mammals, their gut
microbiota, as well as the soil/aquatic microbiota. BioTransformer also
assists scientists in metabolite identification, based on the metabolism
prediction.

 -a,--annotate
 Search PuChem for each product, and store with CID and synonyms, when
 available.
 -b,--btType <BioTransformer Option>
 The type of description: Type of biotransformer - EC-based  (ecbased),
 CYP450 (cyp450), Phase II (phaseII), Human gut microbial (hgut), human
 super transformer* (superbio, or allHuman), Environmental microbial
 (envimicro)**.
 If option -m is enabled, the only valid biotransformer types are
 allHuman, superbio and env.
 -cm,--cyp450mode <CYP450 Prediction Mode>
 Specify the CYP450 predictoin Mode here: 1) CypReact + BioTransformer
 rules; 2) CyProduct only; 3) Combined: CypReact + BioTransformer rules +
 CyProducts.
 Default mode is 1.
 -f,--formulas <Formulas>
 Semicolon-separated list of formulas of compounds to identify
 -h,--help
 Prints the usage.
 -imol,--molinput <MOL Input>
 The input, which can be a Mol file
 -isdf,--sdfinput <Sdf Input>
 The input, which can be an SDF file.
 -ismi,--ismiles <SMILES Input>
 The input, which can be a SMILES string
 -k,--task <BioTransformer Task>
 The task to be permed: pred for prediction, or cid for compound
 identification
 -m,--masses <Masses>
 Semicolon-separated list of masses of compounds to identify
 -mt,--massThreshold <mass threshold for input substrates>
 Specify the mass threshold used to validate input substrates
 Default massThreshold is 1500Da.
 -multiThread <MultiThread input>
 Please input the parameters using the specific format to run this
 multi-thread feature
 -ocsv,--csvoutput <Csv Output>
 Select this option to return CSV output(s). You must enter an output
 filename
 -osdf,--sdfoutput <Sdf Output>
 Select this option to return SDF output(s). You must enter an output
 filename
 -pm,--phaseIImode <PhaseII Prediction Mode>
 Specify the PhaseII predictoin Mode here: 1) BioTransformer rules; 2)
 PhaseII predictor only; 3) Combined: PhaseII predictor + BioTransformer
 rules.
 Default mode is 1.
 -q,--bsequence <BioTransformer Sequence Option>
 Define an ordered sequence of biotransformer/nr_of_steps to apply. Choose
 only from the following BioTranformer Types: allHuman, cyp450, ecbased,
 env, hgut, and phaseII. For instance, the following string representation
 describes a sequence of 2 steps of CYP450 metabolism, followed by 1 step
 of Human Gut metabolism, 1 step of Phase II, and 1 step of Environmental
 Microbial Degradation:
 'cyp450:2; hgut:1; phaseII:1; env:1'
 -s,--nsteps <Number of steps>
 The number of steps for the prediction. This option can be set by the
 user for the EC-based, CYP450, Phase II, and Environmental microbial
 biotransformers. The default value is 1.
 -t,--mTolerance <Mass Tolerance>
 Mass tolerance for metabolite identification (default is 0.01).
 -useDB <Use retrieving from database feature>
 Please specify if you want to enable the retrieving from database
 feature.
 -useSub <Use the first 14 characters of the InChIkey when retrieving from
 database feature>   Please specify if you want to enable the using first
 14 characters of InChIKey when retrieving from database feature.

(* ) While the 'superbio' option runs a set number of transformation steps
in a pre-defined order (e.g. deconjugation first, then
Oxidation/reduction, etc.), the 'allHuman' option predicts all possible
metabolites from any applicable reaction(Oxidation, reduction,
(de-)conjugation) at each step.(** ) For the environmental microbial
biodegradation, all reactions (aerobic and anaerobic) are reported, and
not only the aerobic biotransformations (as per default in the EAWAG
BBD/PPS system).

*********
Examples:
*********

1) To predict the biotransformation of a molecule from an SDF input using
the human super transformer (option superbio) and annotate the metabolites
with names and database IDs (from PubChem), run


java -jar BioTransformer4.0.jar -k pred -b superbio -isdf #{input file
name} -osdf #{output file} -a.

2) To predict the 2-step biotransformation of Thymol (a monoterpene) using
the human super transformer (option allHuman) using the SMILES input,
cypMode = 3 (combined mode), not using retrieving database feature (-useDB
false) and saving to a CSV file, run

java -jar BioTransformer4.0.jar  -k pred -b allHuman -ismi
"CC(C)C1=CC=C(C)C=C1O" -ocsv #{replace with output file name} -s 2 -cm 3
-useDB false

3) Identify all human metabolites (max depth = 2) of Epicatechin
("O[C@@H]1CC2=C(O)C=C(O)C=C2O[C@@H]1C1=CC=C(O)C(O)=C1") with masses
292.0946 Da and 304.0946 Da, with a mass tolerance of 0.01 Da. Provide an
annotation (Common name, synonyms, and PubChem CID), when available.

java -jar BioTransformer4.0.jar  -k cid -b allHuman -ismi
"O[C@@H]1CC2=C(O)C=C(O)C=C2O[C@@H]1C1=CC=C(O)C(O)=C1" -osdf #{replace with
output file name} -s 2 -m "292.0946;304.0946" -t 0.01 -a

- DO NOT forget the quotes around the SMILES string or the list of masses
4) Simulate an order sequence of metabolism of Atrazine
("CCNC1=NC(=NC(=N1)Cl)NC(C)C"), starting with two steps of Cyp450
oxidation, followed by one step of conjugation.
 java -jar biotransformer4.0.jar + -ismi "CCNC1=NC(=NC(=N1)Cl)NC(C)C"
-osdf ~/atrazine-sequence.sdf -k pred -q "cyp450:2; phaseII:1"

To report issues, provide feedback, or ask questions, please send an
e-mail the following address: stian2@ualberta.ca

BioTransformer is offered to the public as a freely acessible software
package under the GNU License LGPL v3. Users are free to copy and
redistribute the material in any medium or format. Moreover, they could
modify, and build upon the material unfer the condition that they must
give appropriate credit, provide links to the license, and indicate if
changes were made. Furthermore, the above copyright notice and this
permission notice must be included. Use and re-distribution of the these
resources, in whole or in part, for commercial purposes requires explicit
permission of the authors. We ask that all users of the BioTransformer
software tool, the BioTransformer web server, or BioTransformerDB to cite
the BioTransformer reference in any resulting publications, and to
acknowledge the authors.
```


## Metadata
- **Skill**: generated

## biotransformer

### Tool Description
BioTransformer is a software tool that predicts small molecule metabolism in mammals, their gut microbiota, as well as the soil/aquatic microbiota. It also assists in metabolite identification based on metabolism prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/biotransformer:3.0.20230403--hdfd78af_0
- **Homepage**: https://bitbucket.org/djoumbou/biotransformer
- **Package**: https://anaconda.org/channels/bioconda/packages/biotransformer/overview
- **Validation**: PASS
### Original Help Text
```text
usage:
java -jar biotransformer-4.0.jar [-a] [-b <BioTransformer Option>] [-cm
       <CYP450 Prediction Mode>] [-f <Formulas>] [-h] [-imol <MOL Input>]
       [-isdf <Sdf Input>] [-ismi <SMILES Input>] [-k <BioTransformer
       Task>] [-m <Masses>] [-mt <mass threshold for input substrates>]
       [-multiThread <MultiThread input>] [-ocsv <Csv Output>] [-osdf <Sdf
       Output>] [-pm <PhaseII Prediction Mode>] [-q <BioTransformer
       Sequence Option>] [-s <Number of steps>] [-t <Mass Tolerance>]
       [-useDB <Use retrieving from database feature>] [-useSub <Use the
       first 14 characters of the InChIkey when retrieving from database
       feature>]

This is the version 4.0 of BioTransformer. BioTransformer is a software
tool that predicts small molecule metabolism in mammals, their gut
microbiota, as well as the soil/aquatic microbiota. BioTransformer also
assists scientists in metabolite identification, based on the metabolism
prediction.

 -a,--annotate
 Search PuChem for each product, and store with CID and synonyms, when
 available.
 -b,--btType <BioTransformer Option>
 The type of description: Type of biotransformer - EC-based  (ecbased),
 CYP450 (cyp450), Phase II (phaseII), Human gut microbial (hgut), human
 super transformer* (superbio, or allHuman), Environmental microbial
 (envimicro)**.
 If option -m is enabled, the only valid biotransformer types are
 allHuman, superbio and env.
 -cm,--cyp450mode <CYP450 Prediction Mode>
 Specify the CYP450 predictoin Mode here: 1) CypReact + BioTransformer
 rules; 2) CyProduct only; 3) Combined: CypReact + BioTransformer rules +
 CyProducts.
 Default mode is 1.
 -f,--formulas <Formulas>
 Semicolon-separated list of formulas of compounds to identify
 -h,--help
 Prints the usage.
 -imol,--molinput <MOL Input>
 The input, which can be a Mol file
 -isdf,--sdfinput <Sdf Input>
 The input, which can be an SDF file.
 -ismi,--ismiles <SMILES Input>
 The input, which can be a SMILES string
 -k,--task <BioTransformer Task>
 The task to be permed: pred for prediction, or cid for compound
 identification
 -m,--masses <Masses>
 Semicolon-separated list of masses of compounds to identify
 -mt,--massThreshold <mass threshold for input substrates>
 Specify the mass threshold used to validate input substrates
 Default massThreshold is 1500Da.
 -multiThread <MultiThread input>
 Please input the parameters using the specific format to run this
 multi-thread feature
 -ocsv,--csvoutput <Csv Output>
 Select this option to return CSV output(s). You must enter an output
 filename
 -osdf,--sdfoutput <Sdf Output>
 Select this option to return SDF output(s). You must enter an output
 filename
 -pm,--phaseIImode <PhaseII Prediction Mode>
 Specify the PhaseII predictoin Mode here: 1) BioTransformer rules; 2)
 PhaseII predictor only; 3) Combined: PhaseII predictor + BioTransformer
 rules.
 Default mode is 1.
 -q,--bsequence <BioTransformer Sequence Option>
 Define an ordered sequence of biotransformer/nr_of_steps to apply. Choose
 only from the following BioTranformer Types: allHuman, cyp450, ecbased,
 env, hgut, and phaseII. For instance, the following string representation
 describes a sequence of 2 steps of CYP450 metabolism, followed by 1 step
 of Human Gut metabolism, 1 step of Phase II, and 1 step of Environmental
 Microbial Degradation:
 'cyp450:2; hgut:1; phaseII:1; env:1'
 -s,--nsteps <Number of steps>
 The number of steps for the prediction. This option can be set by the
 user for the EC-based, CYP450, Phase II, and Environmental microbial
 biotransformers. The default value is 1.
 -t,--mTolerance <Mass Tolerance>
 Mass tolerance for metabolite identification (default is 0.01).
 -useDB <Use retrieving from database feature>
 Please specify if you want to enable the retrieving from database
 feature.
 -useSub <Use the first 14 characters of the InChIkey when retrieving from
 database feature>   Please specify if you want to enable the using first
 14 characters of InChIKey when retrieving from database feature.

(* ) While the 'superbio' option runs a set number of transformation steps
in a pre-defined order (e.g. deconjugation first, then
Oxidation/reduction, etc.), the 'allHuman' option predicts all possible
metabolites from any applicable reaction(Oxidation, reduction,
(de-)conjugation) at each step.(** ) For the environmental microbial
biodegradation, all reactions (aerobic and anaerobic) are reported, and
not only the aerobic biotransformations (as per default in the EAWAG
BBD/PPS system).

*********
Examples:
*********

1) To predict the biotransformation of a molecule from an SDF input using
the human super transformer (option superbio) and annotate the metabolites
with names and database IDs (from PubChem), run


java -jar BioTransformer4.0.jar -k pred -b superbio -isdf #{input file
name} -osdf #{output file} -a.

2) To predict the 2-step biotransformation of Thymol (a monoterpene) using
the human super transformer (option allHuman) using the SMILES input,
cypMode = 3 (combined mode), not using retrieving database feature (-useDB
false) and saving to a CSV file, run

java -jar BioTransformer4.0.jar  -k pred -b allHuman -ismi
"CC(C)C1=CC=C(C)C=C1O" -ocsv #{replace with output file name} -s 2 -cm 3
-useDB false

3) Identify all human metabolites (max depth = 2) of Epicatechin
("O[C@@H]1CC2=C(O)C=C(O)C=C2O[C@@H]1C1=CC=C(O)C(O)=C1") with masses
292.0946 Da and 304.0946 Da, with a mass tolerance of 0.01 Da. Provide an
annotation (Common name, synonyms, and PubChem CID), when available.

java -jar BioTransformer4.0.jar  -k cid -b allHuman -ismi
"O[C@@H]1CC2=C(O)C=C(O)C=C2O[C@@H]1C1=CC=C(O)C(O)=C1" -osdf #{replace with
output file name} -s 2 -m "292.0946;304.0946" -t 0.01 -a

- DO NOT forget the quotes around the SMILES string or the list of masses
4) Simulate an order sequence of metabolism of Atrazine
("CCNC1=NC(=NC(=N1)Cl)NC(C)C"), starting with two steps of Cyp450
oxidation, followed by one step of conjugation.
 java -jar biotransformer4.0.jar + -ismi "CCNC1=NC(=NC(=N1)Cl)NC(C)C"
-osdf ~/atrazine-sequence.sdf -k pred -q "cyp450:2; phaseII:1"

To report issues, provide feedback, or ask questions, please send an
e-mail the following address: stian2@ualberta.ca

BioTransformer is offered to the public as a freely acessible software
package under the GNU License LGPL v3. Users are free to copy and
redistribute the material in any medium or format. Moreover, they could
modify, and build upon the material unfer the condition that they must
give appropriate credit, provide links to the license, and indicate if
changes were made. Furthermore, the above copyright notice and this
permission notice must be included. Use and re-distribution of the these
resources, in whole or in part, for commercial purposes requires explicit
permission of the authors. We ask that all users of the BioTransformer
software tool, the BioTransformer web server, or BioTransformerDB to cite
the BioTransformer reference in any resulting publications, and to
acknowledge the authors.
```

