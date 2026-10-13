* Pavel Solís
* Econometría I
* Laboratorio
*-------------------------------------------------------------------------------

* ==============================================================================
* Regresión lineal simple
* ==============================================================================
cd "~\Documentos\eco3404"
import excel "wgthgtage.xlsx", sheet("Hoja1") firstrow case(lower)
save wgthgtage, replace
summarize weight height age, detail
return list
correlate weight height age
matrix list r(C)
graph matrix weight height age, half
regress weight height
help regress
ereturn list
display e(N)
matrix list e(b)
display _b[height]
display _se[_cons]
display _b[height]/_se[height]
display _b[_cons] + _b[height]*60
help regress_post
predict yhat, xb
predict uhat, residuals
browse
display sqrt(e(rss)/e(df_r))
display e(mss)/(e(mss)+e(rss)) vs display 1-(e(rss)/(e(mss)+e(rss)))
summarize height weight yhat uhat
correlate height uhat
display _b[_cons] + _b[height]*61.36456
scatter weight height
twoway (scatter weight height) (lfit weight height)
scatter uhat yhat
regress weight height
regress weight height, level(90)
regress weight height, noconstant
// predict yhatnocons; predict uhatnocons, r; tw (sc w h) (line y*n* h); su y* u* 
regress weight height
regress weight height, robust
regress weight height if height > 60
regress weight height in 2/237
replace weight = . in 1
browse
corr weight height age
pwcorr, obs sig
regress weight height
generate sample = e(sample)
use wgthgtage, clear
regress weight height
dis _b[_cons]*.45
dis _se[_cons]*.45
dis _b[height]*.45/2.54
dis _se[height]*.45/2.54
generate weightkm = weight*0.45
generate heightcm = height*2.54
generate ageyr = age/12
keep weightkm heightcm ageyr
rename (weightkm heightcm ageyr) (weight height age)
save wgthgtage_isu, replace
summarize weight height age
regress weight height

* ==============================================================================
* Regresión lineal múltiple
* ==============================================================================
regress weight height age
predict yhat
predict uhat, r
summarize height age weight yhat uhat
correlate height uhat
display _b[_cons] + _b[height]*155.866 + _b[age]*13.70253
regress
regress height age, noheader coeflegend
predict r1, residuals
regress weight r1, noheader coeflegend
regress weight height age
test height
test height == 1
test height age
test height = _cons
display ttail(25, 1.4)
display invttail(25,0.1)
display Ftail(205,5,1.4)
display invFtail(205,5,0.1)

* ==============================================================================
* Detección de errores
* ==============================================================================
* Pregunta de interés: ¿El tamaño de generación afecta el rendimiento?
use elemapi, clear
regress api00 acs_k3 meals full
describe
browse api00 acs_k3 meals full
codebook api00 acs_k3 meals full
tabulate dnum if meals == .
summarize api00 acs_k3 meals full
summarize acs_k3, detail
tabulate acs_k3
list dnum snum acs_k3 if acs_k3 < 0
list dnum snum api00 acs_k3 meals full if dnum == 140
histogram acs_k3
graph box acs_k3
stem acs_k3
*replace acs_k3 = acs_k3*-1 if acs_k3 < 0
stem full
tabulate full
tabulate dnum if full <= 1
count if dnum == 401
*replace full = full*100 if full <= 1
graph matrix api00 acs_k3 meals full, half
regress api00 acs_k3 meals full
use elemapi2, clear
regress api00 acs_k3 meals full
regress api00 acs_k3 acs_46 meals full
regress api00 acs_k3 acs_46 meals full ell
regress api00 acs_k3 acs_46 meals full ell emer enroll