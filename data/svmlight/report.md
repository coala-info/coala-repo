# svmlight CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svmlight_svm_classify | PASS |  |
| svmlight_svm_learn | PASS |  |

## svmlight_svm_classify

### Tool Description
SVM-light V6.02: Support Vector Machine, classification module

### Metadata
- **Docker Image**: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
- **Homepage**: http://svmlight.joachims.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/svmlight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svmlight/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-08-10
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Not enough input parameters!


SVM-light V6.02: Support Vector Machine, classification module     14.08.08

Copyright: Thorsten Joachims, thorsten@joachims.org

This software is available for non-commercial use only. It must not
be modified and distributed without prior permission of the author.
The author is not responsible for implications from the use of this
software.

   usage: svm_classify [options] example_file model_file output_file

options: -h         -> this help
         -v [0..3]  -> verbosity level (default 2)
         -f [0,1]   -> 0: old output format of V1.0
                    -> 1: output the value of decision function (default)
```

## svmlight_svm_learn

### Tool Description
SVM-light V6.02: Support Vector Machine, learning module

### Metadata
- **Docker Image**: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
- **Homepage**: http://svmlight.joachims.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/svmlight/overview
- **Validation**: PASS

### Original Help Text
```text

Not enough input parameters!


(more)

SVM-light V6.02: Support Vector Machine, learning module     14.08.08

Copyright: Thorsten Joachims, thorsten@joachims.org

This software is available for non-commercial use only. It must not
be modified and distributed without prior permission of the author.
The author is not responsible for implications from the use of this
software.

   usage: svm_learn [options] example_file model_file

Arguments:
         example_file-> file with training data
         model_file  -> file to store learned decision rule in
General options:
         -?          -> this help
         -v [0..3]   -> verbosity level (default 1)
Learning options:
         -z {c,r,p}  -> select between classification (c), regression (r),
                        and preference ranking (p) (default classification)
         -c float    -> C: trade-off between training error
                        and margin (default [avg. x*x]^-1)
         -w [0..]    -> epsilon width of tube for regression
                        (default 0.1)
         -j float    -> Cost: cost-factor, by which training errors on
                        positive examples outweight errors on negative
                        examples (default 1) (see [4])
         -b [0,1]    -> use biased hyperplane (i.e. x*w+b>0) instead
                        of unbiased hyperplane (i.e. x*w>0) (default 1)
         -i [0,1]    -> remove inconsistent training examples
                        and retrain (default 0)
Performance estimation options:
         -x [0,1]    -> compute leave-one-out estimates (default 0)
                        (see [5])
         -o ]0..2]   -> value of rho for XiAlpha-estimator and for pruning
                        leave-one-out computation (default 1.0) (see [2])
         -k [0..100] -> search depth for extended XiAlpha-estimator 
                        (default 0)
Transduction options (see [3]):
         -p [0..1]   -> fraction of unlabeled examples to be classified
                        into the positive class (default is the ratio of
                        positive and negative examples in the training data)
Kernel options:
         -t int      -> type of kernel function:
                        0: linear (default)
                        1: polynomial (s a*b+c)^d
                        2: radial basis function exp(-gamma ||a-b||^2)
                        3: sigmoid tanh(s a*b + c)
                        4: user defined kernel from kernel.h
         -d int      -> parameter d in polynomial kernel
         -g float    -> parameter gamma in rbf kernel
         -s float    -> parameter s in sigmoid/poly kernel
         -r float    -> parameter c in sigmoid/poly kernel
         -u string   -> parameter of user defined kernel
Optimization options (see [1]):
         -q [2..]    -> maximum size of QP-subproblems (default 10)
         -n [2..q]   -> number of new variables entering the working set
                        in each iteration (default n = q). Set n<q to prevent
                        zig-zagging.
         -m [5..]    -> size of cache for kernel evaluations in MB (default 40)
                        The larger the faster...
         -e float    -> eps: Allow that error for termination criterion
                        [y [w*x+b] - 1] >= eps (default 0.001)
         -y [0,1]    -> restart the optimization from alpha values in file
                        specified by -a option. (default 0)
         -h [5..]    -> number of iterations a variable needs to be
                        optimal before considered for shrinking (default 100)
         -f [0,1]    -> do final optimality check for variables removed
                        by shrinking. Although this test is usually 
                        positive, there is no guarantee that the optimum
                        was found if the test is omitted. (default 1)
         -y string   -> if option is given, reads alphas from file with given
                        and uses them as starting point. (default 'disabled')
         -# int      -> terminate optimization, if no progress after this
                        number of iterations. (default 100000)
Output options:
         -l string   -> file to write predicted labels of unlabeled
                        examples into after transductive learning
         -a string   -> write all alphas to this file after learning
                        (in the same order as in the training set)

(more)

More details in:
[1] T. Joachims, Making Large-Scale SVM Learning Practical. Advances in
    Kernel Methods - Support Vector Learning, B. Schölkopf and C. Burges and
    A. Smola (ed.), MIT Press, 1999.
[2] T. Joachims, Estimating the Generalization performance of an SVM
    Efficiently. International Conference on Machine Learning (ICML), 2000.
[3] T. Joachims, Transductive Inference for Text Classification using Support
    Vector Machines. International Conference on Machine Learning (ICML),
    1999.
[4] K. Morik, P. Brockhausen, and T. Joachims, Combining statistical learning
    with a knowledge-based approach - A case study in intensive care  
    monitoring. International Conference on Machine Learning (ICML), 1999.
[5] T. Joachims, Learning to Classify Text Using Support Vector
    Machines: Methods, Theory, and Algorithms. Dissertation, Kluwer,
    2002.
```

