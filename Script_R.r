#Launch dependencies


library(R2jags)
library(plyr)


#functions for executing jags
source("Fun_JAGS.R")


#-------------------------------------------------------------------------------------------------------------
#Importing data
df_traits<-read.table("SampleDataset.txt", sep ='\t', h = TRUE,
					colClasses = "character")
str(df_traits)

	#Converting Trait and SeedWeight columns as numeric
	df_traits$SeedWeight <-as.numeric(df_traits$SeedWeight)
	df_traits$Trait <-as.numeric(df_traits$Trait)
	str(df_traits)



#-------------------------------------------------------------------------------------------------------------------------------------
# model execution (needs plyr)

# Choice of the model 

choice = 1 # 1 by default
ModToChoose = c("mixed_model.txt" ) #you can add more model name in this vector
ModChoice = ModToChoose[choice]



#Executing Bayesian computation

#dlply would automatize the computation of the Bayesian modelisation for several traits, and would even
#automatize the computaiton within range and temperature


#For the Full Between chamber Model you can use 
#.(NameTrait)
# - NameTrait (1 here but could be more)

#For the within chamber Model it would be preferable to use:
# .(NameTrait, Temperature, Range) produce Bayesian modelisation for each:
# - NameTrait (1 here but could be more) 
# - Temperature (So here I use the between chamber model), so there are 2 temperatures (18°C/ 22°C )
# - Range, there are 2 ranges (France: Fr, Belgium: Bel)


#NECH is total number of iterations, should be at least 50000
#NBURN is size of the burnin, should be at least 10000
#NTHIN is thinning intervals, should be at least 10
#parameters is parameters to save (argument of InputDply)
#.parallel: dlply allows parallelization

TestDlply<-dlply(df_traits, .(NameTrait), InputDlply, parameters = c("b0","b1", "b2","B3", "c", "varP", "varF", "QST"),
MODEL = ModChoice, NECH = 2000, NBURN = 1000, NTHIN = 10, .parallel = FALSE)
TestDlply


#here there are a temperature effect b1[1] is significantky different from b1[2] but no range or population effect b2[i] are overlapping as B3[i]
#QST among chambers is almost null
#variation is at the family level varF >> varP


## Alternative for the within range model
# TestDlply<-dlply(df_traits, .(NameTrait, Temperature, Range), InputDlply, parameters = c("b0","b1", "b2","B3", "c", "varP", "varF", "QST"),
# MODEL = ModChoice, NECH = 2000, NBURN = 1000, NTHIN = 10, .parallel = FALSE)
# TestDlply
