#this function is for computing the input data list to the Bayesian computation


datalistfun<-function(df){
	
			
	
	residSD = 1#sqrt(mean(lmInfo$residuals^2)) # residual root mean squared deviation, not used now but see Kruschke 2015
	xMetSD = sd(df$SeedWeight, na.rm = T)
	SeedweightMean = mean(df$SeedWeight, na.rm=T)

	datalist<-list(
	Trait = df$Trait, 
	Temp = as.factor(df$Temperature),
	Range = as.factor(df$Range),
	Pop = as.factor(df$Population), 
	Tree = as.factor(df$Tree),
	
			
	yMean = mean(df$Trait, na.rm = T), 
	ySD =sd(df$Trait, na.rm = T),
	residSD = residSD,
		
	SeedweightMean = SeedweightMean, #ANCOVA
	Seedweight=df$SeedWeight,
	xMetSD=xMetSD,
	
	NTEMP = nlevels(as.factor(df$Temperature)),
	NINDIV = dim(df)[1],
	NRANGE= nlevels(as.factor(df$Range)),
	NPOP=nlevels(as.factor(df$Population)),
	NTREE=nlevels(as.factor(df$Tree))
	)
	
	return(datalist)
	
	}


#	datalistfun(df_traits)
	
	

#This function is for initializing chains
initfun<-function(df, nchain = 4){

	NTEMP = nlevels(as.factor(df$Temperature))
	NRANGE= nlevels(as.factor(df$Range))
	NPOP=nlevels(as.factor(df$Population))
	NTREE=nlevels(as.factor(df$Tree))

	nchain <- nchain

	initial<-c(a0 = 0,a1 = rep(0,NTEMP), a2 = rep(0,NRANGE) , A3 = rep(0,NPOP),
		A4 = rep(0,NTREE), aMet=0)

		
	init<-list()
	for(j in 1:nchain){init[[j]]<-initial}
	

	return(init)

}

initfun(df_traits)

#This function execute the Bayesian computation (needs datalist fun and initfun)
InputDlply<-function(df, NECH = 2000, NBURN = 1000, NTHIN = 10, nchain = 4, MODEL = "mixed_model.txt", 
parameters = c("b0","b1", "b2","B3", "c", "varP", "varF", "QST")){
	
	require(R2jags)
			
	datalist <- datalistfun(df = df)
	init <- initfun(df = df, nchain = nchain)
		
	mix <-jags(model.file=MODEL, data=datalist, n.chains=nchain, inits=init, parameters.to.save=parameters,
	n.iter=NECH , n.burnin=NBURN, n.thin=NTHIN)
	
	return(mix)
	
	}


	
