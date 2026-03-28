### Questions

1. [What is the goal of the CONTRA project?](#goal)
2. [How do I cite CONTRAfold?](#citation)

What is the goal of the CONTRA project?

The aim of the CONTRA project is to better understand discriminatively-trained probabilistic models of sequences (known as conditional random fields or CRFs) and their application to a variety of problems in computational biology.

More specifically, most current applications of probabilistic sequence models in computational biology use *generative* probabilistic models, such as hidden Markov models (HMMs) and stochastic/probabilistic context free grammars (SCFGs/PCFGs). Generative models treat sequences as the result of simulating stochastic process: in HMMs, the stochastic process involves transitioning from one state of a finite state automaton to the next; in SCFGs/PCFGs, the stochastic process involves randomly picking the next production rule to apply to the current partial parse tree. While generative models are intuitive and allow convenient parameter training via maximum *joint likelihood* techniques, they also make many strong assumptions regarding the stochastic nature of the data they attempt to fit.

In the CONTRA project, we consider the application of discriminative probabilistic models, an alternative to generative models, to various problems in computational biology for which generative models have previously been proposed. Unlike generative models, discriminative models are trained by maximizing *conditional likelihood* (i.e., CONditional TRAining). By applying discriminative techniques to these problems, we hope to

1. gain an understanding of when generative or discriminative techniques are appropriate for a given problem,
2. learn about the biology of the processes we model by examining the model estimated by the learning algorithm, and
3. provide a sound mathematical foundation for new tools which deal with problems in computational biology.

Return to [top](#top).

How do I cite CONTRAfold?

Please cite:

> Do, C.B., Woods,D.A., and Batzoglou, S. (2006) CONTRAfold: RNA Secondary Structure Prediction without Energy-Based Models. *Bioinformatics*, 22(14): e90-e98. ([pdf](http://ai.stanford.edu/~chuongdo/papers/contrafold.pdf), [ps.gz](http://ai.stanford.edu/~chuongdo/papers/contrafold.ps.gz))

Return to [top](#top).