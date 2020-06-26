library(rstan)
library(matrixStats)

#get data

test_dat <- list(N = nrow(combineX),
                 K = 8,
                 P = ncol(combineX),
                 a1 = 1.5,
                 U = combineX)

fit <- stan(file = 'funGaussianGibbs.stan', data = test_dat, chains=2, cores=2,iter=50000)
res_stan <- extract(fit, inc_warmup = FALSE)

StanCEst <- matrix(0, nrow=p, ncol=p)
for(t in 1:50000){

  StanCEst <- StanCEst + res_stan$S[t,,]

}
StanCEst <- StanCEst/50000


# test_dat <- list(N1 = length(inds1),
#                  N0 = length(inds0),
#                  K = 6,
#                  P = 50,
#                  X1 = combineX[inds1,],
#                  X0 = combineX[inds0,],
#                  Anu = 100)
# fitHorseHMC <- stan(file = 'HorseShoePenDA.stan', data = test_dat, chains=1)
# res_stan <- extract(fitHorseHMC, inc_warmup = FALSE)
# StanCEst <- matrix(0, nrow=P, ncol=P)
# for(t in 1:1000){
# 
#   StanCEst <- StanCEst + res_stan$S[t,,]
# 
# }
# StanCEst <- StanCEst/1000
# StanEpsilonEst <- matrix(0, nrow=P, ncol=k)
# for(t in 1:1000){
#   
#   StanEpsilonEst <- StanEpsilonEst + res_stan$Epsilon[t,,]
#   
# }
# StanEpsilonEst <- StanEpsilonEst/1000
