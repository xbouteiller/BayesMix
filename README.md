### BayesMix: A R/JAGS Bayesian mixed model for analyzing quantitative genetic data 
#############################################################################################

#### Preamble:

This code is still in development. Please contact Xavier Bouteiller at xavier.bouteiller(at)u-bordeaux(dot)fr with bug reports or questions. 

#### Readme:

Here I provide a R/JAGS code for analysing quantitative genetic data using a mixed model that allows to compute Qst quantitative trait differentiation index.

This repository contains:
- Code of the model: **_mixed_model.txt_**
- Code to execute the model in R (to be added soon)
- Plotting functions of the results (to be added soon)
- A sample data set (to be added soon)

#### Description of the original experimental design:

Original experimental design for which this bayesian mixed model was initially designed is described here. Code can be easily modified for any other experimental design.

This model was used to test for phenotypic differentiation between ranges and populations of a plant cultivated in several temperature conditions.
Seeds were harvested in two ranges. In each range ten populations were harvested. Finally in each population seeds were harvested on ten trees, thus seeds of the same tree are a half-sib family.
Finally, 5 seeds of each trees were planted in three different temperature conditions.
Thus temperature conditions and ranges were considered as fixed effect whereas populations and trees where considered as random effects.
To control for maternal effect, mean seed weight calcuted at the family level was used as covariate in the model.
Finally, temperature x population interaction was implemented in the model.

#### Model:

>Y,ijklm = b0 + b1,i + b2,j + B3,jk + B4,jkl + B5,ijk + c(x,ijkl-xmean) + e,ijklm
>e~N(o, sigma^2)

- Y: Individual phenotypic value for a surveyed trait
- Fixed effects: temperature (b1) / range (b2) 
- Random effects: population (B3) / tree (B4) 
- covariate parameter: (c)x,ijkl the mean family seed weight as a covariate for maternal effect (c)
- xmean global mean seed weight (substracted to  mean family seed weight in order to center the covariate)

#### QST estimation:

In order to compute QST, variance within populations (sigmaW^2) should be separated from variance between populations (sigmaB^2). Then for a phenotypic trait, QST can be calculated as follows:
```
QST = sigmaB^2 / (sigmaB^2 + 2 sigmaW^2)
```
As we used families of half-sibs,variance within populations is 4 times the variance at the tree (family) level (sigmaTREE^2)
```
sigmaW^2 = 4 X sigmaTREE^2
QST = sigmaB^2 / (sigmaB^2 + 8 X sigmaTREE^2)
```
QST can be calculated among the three environments or within each environment depending on the question. Thus, code for implementing the mixed model within or between chambers is provided.

#### References:

- Kruschke, J.K., 2015. Doing Bayesian data analysis: a tutorial with R, JAGS, and Stan, Edition 2. ed. Academic Press, Boston.
- O’Hara, R.B., Merilä, J., 2005. Bias and precision in QST estimates: Problems and some solutions. Genetics 171, 1331–1339.
- Plummer, M., 2005. JAGS: just another Gibbs sampler. In: Proceedings of the 3rd International Workshop on Distributed Statistical Computing (DSC 2003)
- R Core Team, 2015. R: A Language and Environment for Statistical Computing.

#### Publication:
A publication using this code is currently in preparation.
