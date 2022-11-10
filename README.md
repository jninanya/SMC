SMC
=====

R function to calibrate the potato growth model [SOLANUM](https://doi.org/10.21223/P3/E71OS6).

Usage
-----
```{r eval=F}
Thiry(id,ys,yp,data)
ThiryScore(x,inv=FALSE)
```
Arguments
-----
- **id:** Row name of the data frame __*data*__.
- **ys:** Column name of the yield data of drought stress condition. 
- **yp:** Column name of the yield data of potential condition.
- **data:** A data frame.
- **x:** A drought stress index (SSI, TOL, MP, GMP, and STI) calculated in the function __*"Thiry"*__.
- **inv:** A logical value. If __inv=TRUE__, the drought stress index (__*x*__) is inverted. Default __inv=FALSE__.

Values
-----
- **$indexes:** A data frame of the drought stress indexes SSI, TOL, MP, GMP, and STI.
- **$scores:** A data frame of the Thiry's scores.
- **$corr1.:**  A matrix of Pearson correlation among the drought stress indexes and the Thiry's scores.
- **$range:** A list object with the range of the Thiry's scores SSI, TOL, MP, GMP, and STI. 
- **$comb1.:** A data frame of combinations of the Thiry's scores.  
- **$corr2.:** A matrix of Pearson correlation among Thiry's combinations and the yield data (**ys** and **yp**).
- **$comb2.:** A data frame of the best Thiry's combination.

Example
-----
```{r eval=F}
n=20
data=data.frame("id"=1:n,"ys"=runif(n)*5,"yp"=runif(n)*10)
ts=Thiry("id","ys","yp",data)
```
