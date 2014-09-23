####################
## euCall.R
####################


Value <- function(n=1, t="Call", s0, K, u, d=1/u, r){
  #Input test
  if(t!="Call" && t!="Put"){
    warning("The function admits only Call or Put values") 
    stop()
  }
  
  #Risk-Neutral probabilities
  p.tilde <- (1 + r - d)/(u-d)
  q.tilde <- 1 - p.tilde
  
  #Create a matrix to store all the prices of the Eu-Call option at different time periods 
  optionValue <- matrix(nrow = n+1, ncol = n+1)
  colnames(optionValue) <- paste("t =",0:n) 
  
  #Find the value of the option at the last period
  if (t=="Call") optionValue[,n+1] <- (s0 * u^(n:0) * d^(0:n) - K)
  if (t=="Put") optionValue[,n+1] <- (K - s0 * u^(n:0) * d^(0:n))
  
  
  #Handle negative numbers and set them to zero
  optionValue[,n+1] = (abs(optionValue[,n+1]) + optionValue[,n+1])/2
  
  #Loop through all time period and compute option values for each step
  for (j in n:0){
    for (i in 0:j){
      optionValue[i,j] <- (p.tilde*optionValue[i,(j+1)] + q.tilde*optionValue[(i+1),(j+1)])/(1 + r)
    }
  }
  
  #Fix NAs
  optionValue[is.na(optionValue)] <- 0
  
  optionValue
  
}

# #Test for the 'Value' function
# Value(n = 3,t="Call",s0 = 4,K = 5,u = 2,r = 0.25)

