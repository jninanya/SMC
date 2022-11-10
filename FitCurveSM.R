FitCurveSM<-function(x, y, xfun = c("Beta", "Gompertz"), xtime = c("tt", "dap"), init.par = c(300,900,1.), use.par.default = "yes", graph=FALSE){

xfun=xfun
xtime=xtime

#--- Specifying default values
if((xfun == "Beta" | xfun == "Gompertz") == FALSE){stop(paste0("Warning: Use Beta or Gompertz as argument for fun. Does not exist the ", xfun," function"))}

if((xtime == "tt" | xtime == "dap") == FALSE){stop(paste0("Warning: error in ", xtime, ". Use tt (thermal time) or dap (days after planting)"))}

#--- Default initial values for Beta or Gompertz functions
if(use.par.default == "yes"){
  if (xfun == "Beta"){
    p1 = ifelse(xtime == "tt",  300., 40.)   # tm
    p2 = ifelse(xtime == "tt",  900., 90.)   # te
    p3 = ifelse(xtime == "tt",    1.,  1.)   # wmax
  } else if(xfun == "Gompertz"){
    p1 = ifelse(xtime == "tt", 100.0, 15.0)  # b
    p2 = ifelse(xtime == "tt", 600.0, 45.0)  # tu
    p3 = ifelse(xtime == "tt",   0.7,  0.7)  # A
  }
  init.par=c(p1,p2,p3)
} else {
  init.par=init.par
}
#return(out=list(xfun,xtime,init.par))
#}

#=========================================#
# Fitting the Beta and Gompertz functions #
#=========================================#

#--- defining the Beta function (Yin, X. et al. 2003)
Beta = function(t, tm, te, wmax){
  wmax*(1+(te-t)/(te-tm))*((t/te)^(te/(te-tm)))
}

#--- defining the Gompertz function (Yin, X. et al. 2003)
Gompertz = function(t, b, tu, A){
  A*(exp(-exp(-(1/b)*(t-tu))))
}

#--- function to calculate t50
Beta50 = function(t){
  p3*(1+(p2-t)/(p2-p1))*((t/p2)**(p2/(p2-p1))) - w50     # where: p1 = tm, p2 = te, and p3 = wmax
}

#--- non-linear regression analysis
t = x
w = y
# for Beta function #    
if(xfun == "Beta"){
  pB = init.par
  w = w/100.
  suppressWarnings({
  parameter = nls(w ~ Beta(t, tm, te, wmax),
              start = c(tm = pB[1], te = pB[2], wmax = pB[3]), algorithm = "port",
              control = nls.control(warnOnly = TRUE), upper = c(Inf, Inf, 1.))
  })
# for Gompertz function #
} else if (xfun == "Gompertz"){
  pG = init.par
  suppressWarnings({
  parameter = nls(w ~ Gompertz(t, b, tu, A),
              start = c(b = pG[1], tu = pG[2], A = pG[3]),
              control = nls.control(warnOnly = TRUE), upper = c(Inf, Inf, 0.9))
  })
}
P = summary(parameter) 
 
#--- saving the parameter calculated values ---#
pF = vector(length=3)
pF[1] = P$coefficients[1,1] #tm or b
pF[2] = P$coefficients[2,1] #te or tu
pF[3] = P$coefficients[3,1] #wmax or A
if(xfun == "Beta"){names(pF) = c("tm", "te", "wmax")}
if(xfun == "Gompertz"){names(pF)= c("b", "tu", "A")}

#============================#
# Fitted values for cc or hi #
#============================#

#--- interval limits ---# 
xo = 0
xn = 1.1*t[length(t)]

if(xtime == "tt"){tt = seq(xo, xn, length = 120)}  #for thermal time
if(xtime == "dap"){tt = seq(xo, xn, by = 1)}       #for dap

if(xfun == "Beta"){
  tm = pF[1]
  te = pF[2]
  wmax = pF[3]
  
  CC = Beta(tt, tm, te, wmax)
  CC = ifelse(CC < 0., 0., CC)
  yy = CC
  sim = Beta(t, tm, te, wmax)
  sim = ifelse(sim < 0., 0., sim)
  
}else if (xfun == "Gompertz"){
  b = pF[1]
  tu = pF[2]
  A = pF[3]
    
  HI = Gompertz(tt, b, tu, A)
  yy=HI
  sim = Gompertz(t, b, tu, A)
}

if (graph==TRUE){
  xlabTitle <- ifelse(xtime == "tt", "thermal time (C day)", "days after planting")
  ylabTitle <- ifelse(xfun == "Beta", "canopy cover (%)", "harvest index")
  mainTitle <- ifelse(xfun == "Beta", "Fitting data to a Beta function", "Fitting data to a Gompertz function")

  plot(t, w, type = "p", ylim = c(0,1),
       main = mainTitle, las = 1,
       xlab = xlabTitle, ylab = ylabTitle)
  lines(tt, yy, col = "red", lwd = 2)
  abline(v=pF[1:2], col = "gray90", lty = 2, lwd = 1.5)
  abline(h=pF[3], col = "gray90", lty = 2, lwd = 1.5)
}
return(out=list("parameters"=pF, 
                "fitted.data"=data.frame("time"=x,"obs"=y,"sim"=sim), 
                "simulated.data"=data.frame("time"=tt,"simulated_data"=yy),
                "warning.message"=parameter$message,
                "out.model"=P))
}