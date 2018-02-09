### BayesMix: A R/JAGS Bayesian mixed model for analyzing quantitative genetics data 
#############################################################################################

#### Preamble:

This code was successfully tested on my dataset. Please contact Xavier Bouteiller at xavier.bouteiller(at)u-bordeaux(dot)fr with bug reports or questions. 

#### Readme:

Here I provide a R/JAGS code for analysing quantitative genetics data using a mixed model that allows to compute Qst quantitative trait differentiation index.

This repository contains:
- Code of the model: **_mixed_model.txt_**
- Code to execute the model in R (to be added)
- Plotting functions of the results (to be added)
- A sample data set **_SampleDataset.txt_**

#### Description of the original experimental design:

Original experimental design for which this bayesian mixed model was initially designed is described here. Code can be easily modified for any other experimental design.

This model was used to test for phenotypic differentiation between ranges and populations of a plant cultivated in several temperature conditions.
Seeds were harvested in two ranges. In each range ten populations were harvested. Finally in each population seeds were harvested on ten trees, thus seeds of the same tree are a half-sib family.
Finally, 5 seeds of each trees were planted in three different temperature conditions.
Thus temperature conditions and ranges were considered as fixed effect whereas populations and trees where considered as random effects.
To control for maternal effect, mean seed weight calcuted at the family level was used as covariate in the model.
Finally, temperature x population interaction was implemented in the model.

#### Model:

<a href="https://www.codecogs.com/eqnedit.php?latex=Y_{ijklm}&space;=&space;b0&space;&plus;&space;b1_{i}&space;&plus;&space;b2_{j}&space;&plus;&space;B3_{jk}&space;&plus;&space;B4_{jkl}&space;&plus;&space;B5_{ijk}&space;&plus;&space;c(x_{ijkl}-\bar{x})&space;&plus;&space;e_{ijklm}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Y_{ijklm}&space;=&space;b0&space;&plus;&space;b1_{i}&space;&plus;&space;b2_{j}&space;&plus;&space;B3_{jk}&space;&plus;&space;B4_{jkl}&space;&plus;&space;B5_{ijk}&space;&plus;&space;c(x_{ijkl}-\bar{x})&space;&plus;&space;e_{ijklm}" title="Y_{ijklm} = b0 + b1_{i} + b2_{j} + B3_{jk} + B4_{jkl} + B5_{ijk} + c(x_{ijkl}-\bar{x}) + e_{ijklm}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=e\sim&space;\mathcal{N}(0,&space;\sigma^2)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?e\sim&space;\mathcal{N}(0,&space;\sigma^2)" title="e\sim \mathcal{N}(0, \sigma^2)" /></a>

- Y: Individual phenotypic value for a surveyed trait
- Fixed effects: temperature (b1) / range (b2) 
- Random effects: population (B3) / tree (B4)
- Interaction effect (B5): temperature x population
- covariate parameter: (c) <a href="https://www.codecogs.com/eqnedit.php?latex=x_{ijkl}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_{ijkl}" title="x_{ijkl}" /></a> the mean family seed weight as a covariate for maternal effect (c)
- <a href="https://www.codecogs.com/eqnedit.php?latex=\bar{x}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\bar{x}" title="\bar{x}" /></a> global mean seed weight (substracted to  mean family seed weight in order to center the covariate)

#### QST estimation:

In order to compute QST, variance within populations (<a href="https://www.codecogs.com/eqnedit.php?latex=\sigma_{W}^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\sigma_{W}^2" title="\sigma_{W}^2" /></a>) should be separated from variance between populations (<a href="https://www.codecogs.com/eqnedit.php?latex=\sigma_{B}^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\sigma_{B}^2" title="\sigma_{B}^2" /></a>). Then for a phenotypic trait, QST can be calculated as follows:

<a href="https://www.codecogs.com/eqnedit.php?latex=QST&space;=&space;\frac{\sigma_{B}^2&space;}{(\sigma_{B}^2&space;&plus;&space;2&space;\sigma_{W}^2)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?QST&space;=&space;\frac{\sigma_{B}^2&space;}{(\sigma_{B}^2&space;&plus;&space;2&space;\sigma_{W}^2)}" title="QST = \frac{\sigma_{B}^2 }{(\sigma_{B}^2 + 2 \sigma_{W}^2)}" /></a>

As we used families of half-sibs,variance within populations is 4 times the variance at the tree (i.e. family) level (<a href="https://www.codecogs.com/eqnedit.php?latex=\sigma_{tree}^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\sigma_{tree}^2" title="\sigma_{tree}^2" /></a>)

<a href="https://www.codecogs.com/eqnedit.php?latex=\sigma_{W}^2&space;=&space;4&space;\sigma_{tree}^2&space;\newline&space;\newline&space;QST&space;=&space;\frac{\sigma_{B}^2&space;}{(\sigma_{B}^2&space;&plus;&space;8&space;\sigma_{tree}^2)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\sigma_{W}^2&space;=&space;4&space;\sigma_{tree}^2&space;\newline&space;\newline&space;QST&space;=&space;\frac{\sigma_{B}^2&space;}{(\sigma_{B}^2&space;&plus;&space;8&space;\sigma_{tree}^2)}" title="\sigma_{W}^2 = 4 \sigma_{tree}^2 \newline \newline QST = \frac{\sigma_{B}^2 }{(\sigma_{B}^2 + 8 \sigma_{tree}^2)}" /></a>

QST can be calculated among the three environments or within each environment depending on the question. Thus, code for implementing the mixed model within or between chambers is provided.

#### References:

- Kruschke, J.K., 2015. Doing Bayesian data analysis: a tutorial with R, JAGS, and Stan, Edition 2. ed. Academic Press, Boston.
- O’Hara, R.B., Merilä, J., 2005. Bias and precision in QST estimates: Problems and some solutions. Genetics 171, 1331–1339.
- Plummer, M., 2005. JAGS: just another Gibbs sampler. In: Proceedings of the 3rd International Workshop on Distributed Statistical Computing (DSC 2003)
- R Core Team, 2015. R: A Language and Environment for Statistical Computing.

#### Publication:

If you are using this Bayesian Mixed Model, please cite:

>Bouteiller XP, Barraquand F, Garnier-Géré P, Harmand N, Laizet Y, Raimbault A, Segura R, Lassois L, Monty A, Verdu C, Mariette S & Porté AJ >(2018) No evidence for genetic differentiation in juvenile traits between Belgian and French populations of the invasive tree *Robinia >pseudoacacia* . Plant Ecology and Evolution.
