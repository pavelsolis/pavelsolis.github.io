use https://stats.idre.ucla.edu/stat/stata/webbooks/reg/elemapi2,clear
regress api00 enroll
predict yfitted, xb
predict resid, r
scatter resid yfitted
rvfplot, yline(0)
generate resid2=resid^2
generate yfitted2 = yfitted^2
regress resid2 enroll
regress resid2 yfitted yfitted2 

regress api00 enroll
hettest
imtest, white

regress api00 enroll
rvfplot
generate lenroll = log(enroll)
hist enroll 
hist lenroll 

regress api00 lenroll
rvfplot
hettest
imtest, white

regress api00 lenroll, robust
rvfplot
